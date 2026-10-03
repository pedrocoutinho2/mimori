// Edge Function "painel-usuarios": convida e remove usuários do painel.
// Só um admin do painel pode chamar. A pessoa convidada recebe e-mail e cria a própria senha.
// Segredos (SUPABASE_SERVICE_ROLE_KEY) vêm do `supabase secrets set`, nunca do código.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const URL = Deno.env.get("SUPABASE_URL")!;
const ANON = Deno.env.get("SUPABASE_ANON_KEY")!;
const SERVICE = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const SITE = Deno.env.get("SITE_URL") ?? "https://mimori3d.com.br";
const cors = { "Access-Control-Allow-Origin": SITE, "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type", "Access-Control-Allow-Methods": "POST, OPTIONS" };
const resposta = (corpo: unknown, status = 200) => new Response(JSON.stringify(corpo), { status, headers: { ...cors, "Content-Type": "application/json" } });

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  if (req.method !== "POST") return resposta({ erro: "Método não aceito" }, 405);

  // Quem está chamando precisa ser admin do painel.
  const quem = createClient(URL, ANON, { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } });
  const { data: eu } = await quem.auth.getUser();
  if (!eu?.user) return resposta({ erro: "Faça login de novo" }, 401);
  const { data: papel } = await quem.from("painel_usuarios").select("papel").eq("user_id", eu.user.id).single();
  if (papel?.papel !== "admin") return resposta({ erro: "Só administrador pode mudar usuários" }, 403);

  const admin = createClient(URL, SERVICE);
  const { acao, email, nome, papel: novoPapel } = await req.json();

  if (acao === "convidar") {
    const e = String(email ?? "").trim().toLowerCase();
    if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(e)) return resposta({ erro: "E-mail inválido" }, 400);
    const p = novoPapel === "admin" ? "admin" : "editor";
    const { data, error } = await admin.auth.admin.inviteUserByEmail(e, { redirectTo: `${SITE}/admin/` });
    if (error) return resposta({ erro: error.message }, 400);
    const { error: e2 } = await admin.from("painel_usuarios").upsert({ user_id: data.user.id, email: e, nome: nome ?? null, papel: p });
    if (e2) return resposta({ erro: e2.message }, 400);
    return resposta({ ok: true });
  }

  if (acao === "remover") {
    const e = String(email ?? "").trim().toLowerCase();
    if (e === eu.user.email) return resposta({ erro: "Você não pode remover o próprio acesso" }, 400);
    const { error } = await admin.from("painel_usuarios").delete().eq("email", e);
    if (error) return resposta({ erro: error.message }, 400);
    return resposta({ ok: true });
  }

  return resposta({ erro: "Ação desconhecida" }, 400);
});

// Trocar a própria senha não precisa desta função: no painel, supabase.auth.updateUser({ password }).

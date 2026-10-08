# Mesa Financeira com Supabase

Arquivos: `index.html` (o app), `schema.sql` (tabelas e segurança), `cadastrar-cliente.sql` (novo cliente).

## Passo a passo
1. Crie um projeto em supabase.com.
2. SQL Editor > cole `schema.sql` > Run.
3. Authentication > Providers > Email: deixe ativo e desative "Allow new users to sign up" (só você cadastra clientes).
4. Authentication > Users > Add user (e-mail e senha do cliente).
5. Rode `cadastrar-cliente.sql` com o nome da empresa e o e-mail do usuário.
6. Project Settings > API: copie a Project URL e a chave `anon public`.
7. No `index.html`, preencha `SB_URL` e `SB_KEY` (bloco "Supabase: configuração").
8. Suba no GitHub e ative o GitHub Pages (Settings > Pages > branch main). Em Authentication > URL Configuration, ponha a URL do Pages em "Site URL".

## Segurança
- A chave `anon` pode ficar no HTML: quem protege os dados é o RLS. Nunca coloque a `service_role` no código nem no GitHub.
- Teste com dois clientes: o usuário A não pode ver nada da empresa B.
- Ative backups (plano Pro) e mantenha contrato de operador (LGPD) com seus clientes.

## Como os dados ficam
Tabela `registros` (empresa_id, colecao, id, dados jsonb). Coleções: `lanc`, `contas`, `config`. Cada empresa só enxerga as próprias linhas.

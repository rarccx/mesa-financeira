-- Execute uma vez em Supabase > SQL Editor.
-- Cria um registro por usuário, com acesso só ao próprio dado (RLS).
create table if not exists public.mesa_dados (
  user_id uuid primary key references auth.users(id) on delete cascade,
  dados jsonb not null default '{}'::jsonb,
  atualizado_em timestamptz not null default now()
);

alter table public.mesa_dados enable row level security;

create policy "ler os próprios dados" on public.mesa_dados
  for select using (auth.uid() = user_id);
create policy "inserir os próprios dados" on public.mesa_dados
  for insert with check (auth.uid() = user_id);
create policy "atualizar os próprios dados" on public.mesa_dados
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "apagar os próprios dados" on public.mesa_dados
  for delete using (auth.uid() = user_id);

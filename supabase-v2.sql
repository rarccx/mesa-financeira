-- Execute uma vez em Supabase > SQL Editor (depois do supabase.sql).
-- Cria o armazenamento privado de comprovantes: cada usuário acessa só a própria pasta.
insert into storage.buckets (id, name, public)
values ('comprovantes', 'comprovantes', false)
on conflict (id) do nothing;

create policy "ler os próprios comprovantes" on storage.objects
  for select to authenticated
  using (bucket_id = 'comprovantes' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "enviar os próprios comprovantes" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'comprovantes' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "apagar os próprios comprovantes" on storage.objects
  for delete to authenticated
  using (bucket_id = 'comprovantes' and (storage.foldername(name))[1] = auth.uid()::text);

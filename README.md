# Site da Cris Reis

Site de serviços da mentora Cristiainy "Cris" Reis, em um único arquivo (`index.html`) com rotas por hash.

- `index.html`: home, Mentoria Singular, cinco páginas de serviço com lista de espera, chat/formulários, termos, privacidade e painel `#admin`.
- `img/`: fotos e imagens de hero (versões larga e vertical).
- `docs/supabase-admin.sql`: tabelas e regras de acesso do rastreamento e do painel (rodar quando o Supabase existir).
- `docs/checklist.html`: checklist de pendências com a Cris.

## Pontos de configuração (dentro do `index.html`)
- `SUPA` (`url` e `key`): conexão com o Supabase. Vazio = painel em modo local.
- `AGENDA_URL`: link da agenda da sessão de diagnóstico.
- `ESBELT_URL`: link do licenciamento Esbelt ON.
- Link da bio do Instagram: `?src=instagram`.

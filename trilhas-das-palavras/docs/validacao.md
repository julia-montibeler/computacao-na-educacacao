# Registro de validação

## Situação inicial

- Projeto executado em modo headless na Godot 4.5.1 no Windows; validação visual e Android pendentes.
- Conteúdo editorial provisório; revisão com professora pendente.
- Áudios ainda não produzidos; trilha fonêmica bloqueada.
- Compatibilidade com aparelhos e desempenho ainda não medidos.

## Verificações locais — 09/11/2026

Motor: Godot 4.5.1.stable.official.f62fdbde1, executável portátil oficial; versão usada para desenvolvimento, ainda não escolhida definitivamente para os tablets.

| Verificação | Resultado |
|---|---|
| Importação do projeto e cinco SVGs | Aprovada |
| `tests/run_tests.gd` | Código de saída 0; zero falhas |
| `tests/ui_smoke.gd` | Código de saída 0; zero falhas |
| Cena principal, cinco quadros headless | Código de saída 0; sem erros de execução |

O teste de lógica cobre catálogo inválido, IDs desconhecidos, erro, acerto repetido, avanço repetido, conclusão, troca de trilha e limpeza de sessão. O teste de interface aciona botões de uma sessão completa de Palavras, incluindo erro, nova tentativa e reinício. Nenhum destes resultados comprova layout ou desempenho no tablet.

## Registro por aparelho/build

Preencher sem dados pessoais de alunos:

| Campo | Resultado |
|---|---|
| Data e versão do build | Pendente |
| Versão Godot / renderizador | Pendente / Compatibility proposto |
| Tablet / Android / RAM / CPU | Pendente |
| Instalação e primeira abertura em modo avião | Pendente |
| Três trilhas e mídias completas | Pendente |
| Legibilidade e áreas de toque | Pendente |
| Pausa, retorno e botão Voltar | Pendente |
| Tempo de abertura, três medições | Pendente |
| Pico de memória e sessões repetidas | Pendente |
| Fluidez e latência de toque | Pendente |
| Tamanho APK / assets próprios | Pendente |
| Defeitos, ajustes e resultado da repetição | Pendente |

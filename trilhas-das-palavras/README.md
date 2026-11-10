# Trilhas das Palavras — protótipo 0.1

Primeira implementação do [plano](../Trilhas_das_Palavras_Implementation_Plan_v01.md), em Godot 4.x com GDScript e renderizador Compatibility. A compatibilidade com tablets ainda não foi validada; a orientação horizontal é provisória.

## Executar

1. Abrir `project.godot` na Godot padrão 4.x (não requer .NET). Esta versão foi verificada na Godot 4.5.1.
2. Aguardar a importação dos SVGs.
3. Executar a cena principal com F6 ou o projeto com F5.
4. Selecionar PALAVRAS ou FRASES e concluir cinco desafios.

O projeto não usa servidor, bibliotecas externas, fontes remotas ou serviços de rede. O progresso fica apenas em memória. As configurações de som e movimento também são temporárias.

## Implementado

- Início com instrução visual/textual e seleção manual de trilha.
- Uma interface de desafio reutilizada, três caminhos, validação por ID, dica e nova tentativa.
- Uma estrela por item, proteção contra eventos repetidos e avanço manual após leitura.
- Cenário vetorial com personagem e indicação de progresso; redução de movimento.
- Conclusão, reinício e confirmação para sair durante uma sessão.
- Carregamento JSON com validação e rejeição de catálogo inconsistente.
- Gerenciador de áudio local, pronto para receber recursos revisados.
- Quinze registros editoriais provisórios e cinco ilustrações SVG próprias.

## Limites desta versão

O catálogo é um **rascunho para revisão**, sem aprovação pedagógica. Sons e Letras está bloqueada: seus cinco itens precisam de gravações de fonemas revisadas pela professora. Os botões de áudio das outras trilhas ficam indisponíveis enquanto não houver gravações. Ainda não há instrução falada ou tutorial animado.

As frases usam pistas textuais provisórias para tornar a resposta explícita; substituir por cenas/áudios adequados após revisão. Não apresentar esta versão como produto validado para uso autônomo por crianças.

Ainda faltam: teste no tablet, escolha definitiva da versão do motor/orientação, gravações, revisão dos itens, configuração e geração do APK, medição de desempenho e piloto.

## Testes

Na pasta do projeto, após a importação dos recursos:

```powershell
godot --headless --editor --path . --import
godot --headless --path . --script tests/run_tests.gd
godot --headless --path . --script tests/ui_smoke.gd
```

Substituir `godot` pelo caminho do executável local quando necessário. O roteiro testa o controlador real e o loader, incluindo dados inválidos, erros, repetição de respostas, avanço, conclusão e reinício. Retorna código diferente de zero quando há falha.

O teste de interface simula botões reais de início, seleção de trilha, erro, nova tentativa, cinco acertos, conclusão e reinício. Ambos os roteiros passaram na Godot 4.5.1 em 09/11/2026. A cena principal também iniciou em modo headless sem erros. Isso não valida aparência, áudio ou comportamento em Android.

Testar manualmente também: layout, toque, botão Voltar, saída, repetição de áudio após inclusão das gravações, pausa/retomada e navegação com som/movimento desativados.

## Conteúdo e recursos

Editar `data/desafios.json`, preservando IDs e os três valores de trilha. Recursos devem estar em `res://assets/`. Os campos opcionais `audioEnunciado`, `audioSolucao` e `audioDica` aceitam caminhos locais; ausência é representada por string vazia ou campo omitido. O carregador aceita rascunhos sem áudio, mas impede iniciar a trilha fonêmica nessas condições.

As ilustrações SVG desta versão foram desenhadas em código para o projeto, sem recursos de terceiros. A fonte é a padrão do motor. Qualquer recurso adicionado posteriormente precisa ter sua origem/licença registrada.

## Exportação Android

Ainda não há preset Android validado. Após identificar os tablets:

1. Registrar a versão exata da Godot, instalar os templates correspondentes e configurar SDK/JDK conforme essa versão.
2. Criar preset Android e definir identificador do pacote, arquiteturas e versão mínima compatíveis com os aparelhos reais.
3. Exportar todos os recursos e incluir explicitamente `data/*.json` no filtro de arquivos não reconhecidos como recursos. Conferir imagens e áudios referenciados por caminhos no JSON.
4. Manter permissões mínimas, sem microfone, câmera, localização ou internet.
5. Usar chave de assinatura guardada fora do projeto e nunca versionar credenciais.
6. Instalar o APK sem dados anteriores e executar as trilhas em modo avião desde a primeira abertura.

Registrar resultados e medições em `docs/validacao.md` antes de declarar compatibilidade ou conclusão do MVP.

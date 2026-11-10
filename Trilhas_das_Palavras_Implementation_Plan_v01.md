# Trilhas das Palavras — Plano de implementação do MVP

**Base:** [Solution Design v0.2](Trilhas_das_Palavras_Solution_Design_v02.md).  
**Versão:** 0.1 — 09/11/2026.  
**Objetivo:** orientar a construção, a verificação e a entrega de um APK Android educativo para uso offline em tablets da escola.  
**Status:** plano proposto; hardware, conteúdo e metas de desempenho ainda dependem de validação.

**Implementação iniciada em 09/11/2026:** projeto em [`trilhas-das-palavras/`](trilhas-das-palavras/README.md), com controlador, catálogo validado, navegação, desafios e testes locais aprovados na Godot 4.5.1. As etapas técnicas 2–4 foram iniciadas com conteúdo provisório, enquanto o levantamento de hardware e a prova Android permanecem pendentes. Não houve aprovação pedagógica, geração de APK ou validação nos tablets; Sons e Letras aguarda áudios e permanece bloqueada. Resultados e limites em [`docs/validacao.md`](trilhas-das-palavras/docs/validacao.md).

## 1. Resultado da implementação

Entregar um jogo com uma mecânica de três caminhos, três trilhas selecionadas manualmente e cinco desafios por trilha. Cada desafio deve permitir ouvir instruções, escolher uma alternativa, receber dica após erro e concluir com uma estrela, solução completa e convite à leitura oral. A sessão termina com cinco estrelas e opções de reinício ou retorno ao início.

O APK deve incluir todos os recursos necessários e funcionar em modo avião desde a primeira abertura. O aceite depende de execução nos aparelhos reais e de revisão do conteúdo pela professora.

Permanecem fora desta entrega: contas, identificação de alunos, gravação de voz, reconhecimento de fala, serviços online, telemetria, integração com Anthon, editor de conteúdo e adaptação automática de dificuldade.

## 2. Decisões de trabalho e pontos em aberto

As decisões abaixo tornam o plano executável, mas não representam novas exigências já aprovadas pela professora.

| Tema | Proposta para o MVP | Quando confirmar |
|---|---|---|
| Tecnologia | Godot 2D e GDScript; versão e renderizador fixados após teste no hardware | Etapa 1 |
| Alternativa técnica | Kotlin com interface 2D simples se Godot não atender aos aparelhos | Ao concluir a prova técnica |
| Orientação | Escolher uma orientação para o MVP após teste de legibilidade e toque | Etapa 1 |
| Sessão | Cinco desafios na ordem editorial, sem embaralhar questões ou alternativas inicialmente | Revisão pedagógica |
| Persistência | Progresso apenas em memória; fechar o processo encerra a sessão | Antes da etapa 3 |
| Leitura oral | Após acerto, exibir solução e botão CONTINUAR; sem avanço automático que interrompa a leitura | Revisão do fluxo |
| Som | Controle de som e repetição de áudio; desligar o som não impede navegação | Etapa 4 |
| Movimento | Animações curtas e opção de reduzir/desativar movimento | Etapa 4 |
| Retorno ao menu | Durante uma sessão, confirmar a saída para evitar perda acidental | Revisão do fluxo |
| Pausa | Ao colocar o app em segundo plano, interromper áudio e impedir avanço involuntário | Etapa 3 |

Não definir uma versão mínima de Android ou prometer desempenho antes de identificar os dispositivos. A sessão de cinco itens deve ser observada no piloto: a duração de 10–15 minutos é uma referência pedagógica, não um temporizador do jogo.

## 3. Sequência e dependências

Executar nesta ordem:

1. **Etapa 0:** confirmar conteúdo, aparelhos e condições de instalação.
2. **Etapa 1:** provar instalação, renderização, toque e áudio em um APK mínimo.
3. **Etapa 2:** estruturar projeto, contrato JSON e carregamento validado.
4. **Etapa 3:** implementar uma rodada completa com estado e pontuação seguros.
5. **Etapa 4:** completar navegação, interface, áudio e acessibilidade.
6. **Etapa 5:** integrar os quinze desafios revisados.
7. **Etapa 6:** verificar, otimizar e produzir a versão candidata ao piloto.
8. **Etapa 7:** aplicar o piloto, corrigir problemas e entregar o MVP.

A preparação editorial dos quinze itens pode ocorrer enquanto a mecânica é construída, depois de estabilizar o contrato de conteúdo. A integração final depende da revisão pedagógica. Se a prova técnica reprovar Godot, revisar as tarefas técnicas das etapas seguintes antes de prosseguir, preservando conteúdo e critérios de aceite.

## 4. Etapa 0 — Preparar os insumos

### Tarefas

- [ ] Registrar modelos dos tablets, versão do Android, RAM, armazenamento disponível, resolução, arquitetura de CPU e capacidade gráfica disponível.
- [ ] Identificar o aparelho com menor capacidade e os demais perfis que precisarão de teste.
- [ ] Combinar com a escola como instalar e atualizar APKs e quem terá acesso aos aparelhos.
- [ ] Confirmar com a professora as correspondências som–letra, palavras e frases já trabalhadas.
- [ ] Selecionar um item representativo por trilha para o primeiro protótipo.
- [ ] Preparar uma planilha editorial com os quinze itens: objetivo, enunciado, alternativas, resposta, dica, solução, imagem, áudio e situação da revisão.
- [ ] Definir quem implementa, quem revisa conteúdo e quem acompanha o teste nos aparelhos. Uma pessoa pode assumir mais de um papel.

**Entregáveis:** inventário de dispositivos, catálogo editorial inicial e registro de decisões pendentes.

**Critério de saída:** há acesso a pelo menos um tablet representativo, instalação viável e três exemplos pedagógicos utilizáveis. A ausência desses insumos deve ficar registrada como dependência, sem presumir validação.

## 5. Etapa 1 — Validar a tecnologia no tablet

### Tarefas

- [ ] Preparar o ambiente Godot e as ferramentas de exportação Android compatíveis com a versão candidata.
- [ ] Criar uma cena simples com texto acentuado, imagem, três áreas de toque e reprodução de áudio local.
- [ ] Gerar um APK contendo esses recursos, sem dependência de download.
- [ ] Instalar no tablet de menor capacidade e abrir pela primeira vez em modo avião.
- [ ] Testar toque, proporção da tela, legibilidade, áudio, suspensão e retorno ao aplicativo.
- [ ] Medir tamanho do APK, tamanho dos assets próprios, tempo de abertura, memória e resposta ao toque; registrar aparelho e procedimento.
- [ ] Fixar versão do motor, renderizador, orientação e configurações de exportação com base nos resultados.

**Entregáveis:** APK de prova, instruções de reprodução do build e relatório técnico curto.

**Critério de saída:** instalação e fluxo básico funcionam nos perfis de hardware previstos. Caso contrário, registrar o problema, avaliar uma correção simples e testar a alternativa nativa se necessário. Não produzir toda a arte antes dessa decisão.

### Metas iniciais para avaliação

As metas abaixo são propostas deste plano e precisam ser confirmadas após a primeira medição; não são resultados obtidos nem limites definidos pelo Solution Design.

| Indicador | Referência inicial | Verificação |
|---|---|---|
| Abertura até menu utilizável | Até 5 segundos | Três aberturas com processo encerrado; registrar cada resultado |
| Feedback visual ao toque | Até 200 ms | Filmagem ou instrumentação local no aparelho |
| Fluidez durante transições | Buscar pelo menos 30 FPS | Medição em build de teste no aparelho de menor capacidade |
| Memória | Definir orçamento após a prova | Registrar pico e comportamento após sessões repetidas |
| Assets próprios | Até 15 MB, conforme proposta original | Inventário dos arquivos distribuídos; APK medido separadamente |
| Estabilidade | Nenhum travamento ou avanço indevido nos roteiros de aceite | Execução completa das três trilhas |

## 6. Etapa 2 — Estruturar projeto e conteúdo

### Organização proposta

```text
trilhas-das-palavras/
  project.godot
  export_presets.cfg
  scenes/
    menu.tscn
    trilhas.tscn
    desafio.tscn
    conclusao.tscn
    components/caminho.tscn
  scripts/
    game.gd
    challenge_loader.gd
    audio_manager.gd
  data/desafios.json
  assets/
    imagens/
    audio/
    fontes/
  tests/
  docs/
    build-android.md
    validacao-dispositivos.md
    revisao-conteudo.md
    roteiro-piloto.md
```

Manter credenciais e chaves de assinatura fora do repositório. Fixar as versões das ferramentas no guia de build e excluir caches e arquivos gerados do controle de versão.

### Contrato de conteúdo

Usar os nomes dos campos do exemplo da seção 7.4 do Solution Design. Como extensão proposta, envolver os desafios em um objeto com `versaoSchema` e uma lista `desafios`, e adicionar `audioDica` para pistas faladas quando necessário. Validar essa extensão antes de produzir os quinze registros.

| Campo | Regra de validação |
|---|---|
| `id` | Texto não vazio e único no catálogo |
| `trilha` | Um dos valores `sons_letras`, `palavras`, `frases` |
| `habilidade`, `enunciado`, `textoCompleto`, `dica` | Textos não vazios |
| `texto` | Texto da tarefa; pode ser vazio em item exclusivamente sonoro, por decisão editorial |
| `alternativas` | Exatamente três objetos com `id` único no item e `texto` não vazio |
| `respostaCorreta` | Referencia exatamente um dos IDs de alternativa |
| `imagem` | Recurso local existente, obrigatório quando a imagem desambigua a tarefa |
| `audioEnunciado`, `audioSolucao`, `audioDica` | Recursos locais existentes quando declarados; obrigatoriedade pedagógica por item |

Para a trilha de sons e letras, exigir referência sonora adequada à habilidade. Diferenciar o áudio de instrução da reprodução do fonema: gravar e revisar com a professora o som solicitado, evitando substituí-lo inadvertidamente pelo nome da letra. O botão de repetição deve deixar claro qual áudio reproduz.

### Tarefas

- [ ] Criar a estrutura mínima do projeto e carregar os três itens de protótipo.
- [ ] Implementar validação de estrutura, unicidade, trilha, alternativas e referências de mídia.
- [ ] Validar que o catálogo final contém cinco itens por trilha.
- [ ] Garantir que JSON e mídias referenciadas por caminhos sejam incluídos na exportação.
- [ ] Interromper o início da trilha diante de conteúdo inválido e mostrar mensagem simples para solicitar ajuda de um adulto; registrar detalhes apenas no ambiente de desenvolvimento.

**Critério de saída:** conteúdo válido carrega e conteúdo inválido é rejeitado antes da rodada. A validação automática não substitui a revisão de ambiguidades pela professora.

## 7. Etapa 3 — Construir a mecânica completa

### Responsabilidades

| Componente | Responsabilidade |
|---|---|
| `game.gd` | Trilha atual, índice do item, estado da rodada, estrelas, conclusão e reinício |
| `challenge_loader.gd` | Ler e validar catálogo; entregar os itens da trilha |
| `audio_manager.gd` | Reproduzir, interromper, repetir e silenciar áudio local |
| `desafio.tscn` | Apresentar o item e emitir escolha e pedido de continuação |
| `caminho.tscn` | Área completa de toque associada ao ID da alternativa |

### Estado da rodada

| Estado | Entradas aceitas | Resultado |
|---|---|---|
| `aguardando_resposta` | Escolha de alternativa e repetição de áudio | Avalia o ID selecionado |
| `dica` | Repetição da pista; escolhas bloqueadas durante o feedback curto | Volta ao mesmo desafio sem pontuar |
| `acerto` | Repetição da solução; escolhas bloqueadas | Registra conclusão uma vez e mostra solução e convite à leitura |
| `aguardando_continuar` | CONTINUAR e repetição da solução | Inicia transição |
| `transicao` | Nenhuma escolha | Avança personagem e carrega próximo item ou conclusão |

O estado global também diferencia início, seleção da trilha e conclusão. Não depender apenas da aparência desabilitada dos botões: o controlador deve rejeitar eventos incompatíveis com o estado atual.

### Tarefas

- [ ] Implementar início de sessão com índice e estrelas zerados.
- [ ] Associar cada caminho ao ID da alternativa, sem usar posição visual como resposta.
- [ ] No erro, manter item, alternativas e estrelas; mostrar dica e permitir nova tentativa.
- [ ] No acerto, registrar o ID concluído e conceder exatamente uma estrela.
- [ ] Mostrar a solução completa e o convite à leitura oral antes de CONTINUAR.
- [ ] Impedir múltiplas transições por toque repetido.
- [ ] Encerrar ao concluir o quinto item; reiniciar limpa todo o estado da sessão.
- [ ] Interromper áudio ao trocar de item ou sair da sessão.
- [ ] Tratar pausa e retomada sem reprocessar resposta ou somar estrela novamente.

**Critério de saída:** uma trilha provisória pode ser concluída, inclusive com erros e toques rápidos, sem duplicação de estrelas, salto de item ou bloqueio permanente.

## 8. Etapa 4 — Completar a experiência

- [ ] Implementar início, seleção das três trilhas, desafio, feedback e conclusão.
- [ ] Incluir demonstração curta da interação e instruções faladas locais.
- [ ] Usar um cenário reutilizado, personagem simples e caminhos com toda a superfície tocável.
- [ ] Ajustar texto e áreas de toque à orientação escolhida e às telas reais.
- [ ] Garantir que a maior frase e a maior alternativa do catálogo não sejam cortadas.
- [ ] Diferenciar feedback por texto, símbolo ou forma, além de cor.
- [ ] Disponibilizar repetição de áudio, controle de som e redução de movimento.
- [ ] Evitar sobreposição de falas; uma nova reprodução interrompe a anterior.
- [ ] Permitir continuar com o som desligado; documentar que tarefas fonêmicas exigem áudio ou mediação docente equivalente.
- [ ] Implementar retorno ao início e tratamento do botão Voltar do Android de forma consistente.
- [ ] Não usar cronômetro, vidas, ranking ou mensagens de punição.

**Critério de saída:** todas as telas são navegáveis por toque, o fluxo é compreensível com demonstração curta e o layout funciona nos aparelhos selecionados. A autonomia infantil será observada no piloto, sem presumir validação apenas por teste adulto.

## 9. Etapa 5 — Integrar o conteúdo final

- [ ] Finalizar cinco itens de sons e letras, cinco de palavras e cinco de frases.
- [ ] Revisar cada conjunto de enunciado, imagem, áudio, alternativas e solução com a professora.
- [ ] Conferir frases de até três ou quatro palavras e adequação ao conteúdo já trabalhado.
- [ ] Gravar instruções, referências sonoras, soluções e dicas necessárias, com volume consistente.
- [ ] Otimizar imagens e áudios sem prejudicar compreensão ou legibilidade.
- [ ] Registrar origem e licença de imagens, fontes e sons; substituir recursos sem autorização de uso.
- [ ] Ouvir e visualizar todos os itens dentro do APK exportado, não apenas no editor.
- [ ] Registrar responsável, data e resultado da revisão por item.

**Critério de saída:** quinze itens revisados, sem ambiguidade conhecida, sem arquivos ausentes e sem recursos provisórios que alterem o sentido da atividade.

## 10. Etapa 6 — Verificar e empacotar

### Verificações automatizáveis prioritárias

Criar testes focados nos riscos da lógica e dos dados, usando o mecanismo compatível com a versão escolhida da stack:

- Catálogo válido aceito; IDs duplicados, resposta inexistente, quantidade incorreta de alternativas e mídia ausente rejeitados.
- Erro preserva item e estrelas; acerto concede uma estrela; repetir o evento não duplica a recompensa.
- CONTINUAR avança uma única vez e o último item leva à conclusão.
- Reiniciar limpa o estado anterior e trocar de trilha seleciona o catálogo correto.

### Roteiro manual de aceite

| Caso | Ação | Resultado esperado |
|---|---|---|
| Instalação limpa offline | Instalar sem dados anteriores e abrir em modo avião | Menu e todos os recursos disponíveis desde a primeira abertura |
| Três trilhas | Concluir cada trilha | Cinco itens corretos e cinco estrelas em cada sessão |
| Erro e recuperação | Errar duas vezes e depois acertar | Mesmo item, dica disponível e apenas uma estrela |
| Toques rápidos | Tocar repetidamente em opções e CONTINUAR | Nenhuma pontuação duplicada ou questão pulada |
| Áudio | Repetir, silenciar, sair e entrar em outro item | Sem falas sobrepostas ou áudio da tela anterior |
| Ciclo de vida | Suspender e retomar; depois encerrar o processo e reabrir | Retomada coerente; após encerramento, nova sessão sem progresso, conforme decisão proposta |
| Navegação | Voltar durante desafio e reiniciar na conclusão | Saída previsível e nova sessão zerada |
| Layout | Abrir itens com os maiores textos e testar telas previstas | Sem cortes, sobreposição ou caminhos difíceis de tocar |
| Recursos reduzidos | Desativar som e movimento | Navegação preservada; tarefas sonoras realizadas com apoio previsto |
| Estabilidade | Executar três sessões consecutivas no aparelho de menor capacidade | Sem travamentos ou crescimento contínuo de memória observado |
| Privacidade | Revisar dependências, manifesto e permissões do APK | Sem coleta de dados, publicidade, telemetria ou permissões desnecessárias |

### Preparação da versão candidata

- [ ] Executar os testes e registrar build, aparelho, resultado e problemas encontrados.
- [ ] Corrigir falhas de instalação, conteúdo, pontuação, navegação e áudio antes do piloto.
- [ ] Repetir medições da etapa 1 e comparar com as metas acordadas.
- [ ] Conferir o tamanho dos assets próprios separadamente do APK final.
- [ ] Gerar APK de distribuição assinado, com versão identificável e instruções de instalação.
- [ ] Preservar a chave de assinatura para futuras atualizações, fora do repositório.
- [ ] Repetir o teste offline no APK final; não assumir que o resultado do editor ou de outro build é suficiente.

**Critério de saída:** versão candidata instalável nos aparelhos previstos, roteiro aprovado e nenhum defeito conhecido que impeça a sessão ou forneça correção pedagógica errada.

## 11. Etapa 7 — Piloto e fechamento

- [ ] Preparar uma orientação breve para a professora: selecionar trilha, repetir som, acompanhar leitura e encerrar sessão.
- [ ] Realizar uma sessão acompanhada, com duração ajustável à turma.
- [ ] Registrar observações anônimas em checklist externo ao app, sem nomes ou gravações de crianças.
- [ ] Observar: ajuda para iniciar, compreensão dos caminhos, uso de dicas, participação oral, conclusão e dificuldades de interface ou conteúdo.
- [ ] Quando viável, anotar tentativas por item no checklist sem implementar telemetria.
- [ ] Classificar problemas em impeditivos, relevantes para uso e melhorias posteriores.
- [ ] Corrigir impeditivos e problemas que comprometam conteúdo ou interação; verificar novamente os fluxos afetados.
- [ ] Registrar limitações e sugestões de evolução separadamente do escopo entregue.

**Critério de saída:** APK final verificado, conteúdo revisado, resultados do piloto documentados e limitações conhecidas declaradas. Engajamento e conclusão da sessão não devem ser apresentados como prova de aprendizagem.

## 12. Rastreabilidade dos requisitos

| Requisito do Solution Design | Implementação principal | Evidência de aceite |
|---|---|---|
| RF01 | Início, seleção manual e estado de sessão | Iniciar e reiniciar as três trilhas |
| RF02–RF04 | Loader, cena de desafio e escolha por ID | Catálogo validado e respostas conferidas |
| RF05 | Estado de dica e nova tentativa | Erro preserva item e pontuação |
| RF06 | Conclusão única e transição | Teste de toque repetido e cinco estrelas finais |
| RF07 | Solução, convite oral e CONTINUAR | Revisão do fluxo com a professora |
| RF08 | Tela de conclusão e reinício | Nova sessão sem estado residual |
| RF09 | Gerenciador de áudio e controles | Repetição, silêncio e ausência de sobreposição |
| RF10; RNF09 | Recursos empacotados | Instalação limpa e primeira abertura em modo avião |
| RNF01–RNF02; RNF05 | Prova técnica e otimização | Medições e instalação nos tablets reais |
| RNF03–RNF04 | Layout, demonstração e controles | Roteiro visual e observações do piloto |
| RNF06 | Ausência de coleta e dependências de rastreamento | Revisão de permissões, código e dependências |
| RNF07 | JSON separado da lógica | Alterar item sem modificar o controlador |
| RNF08 | Máquina de estados e conclusão única | Testes de erro, repetição, transição e retomada |

## 13. Pacote final de entrega

- [ ] Código-fonte com versão do motor e instruções para reproduzir o build.
- [ ] APK final identificado por versão e registro dos aparelhos compatíveis testados.
- [ ] Catálogo de quinze itens e registro da revisão pedagógica.
- [ ] Recursos com origem/licença documentadas.
- [ ] Guia curto de instalação e uso pela professora.
- [ ] Relatório de testes, tamanhos e medições de desempenho.
- [ ] Checklist e síntese anônima do piloto, com limitações e pendências.

O esforço e o calendário devem ser estimados após a prova técnica, considerando disponibilidade dos tablets, da professora e de quem fará as gravações. Essas dependências precisam entrar no planejamento junto das tarefas de programação.

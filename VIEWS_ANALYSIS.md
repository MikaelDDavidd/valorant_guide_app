# Análise Completa de Views e Design (UI/UX)

Este documento fornece uma análise exaustiva da estrutura visual, padrões de design e implementação de interface do usuário do aplicativo `valorant_guide_app`.

## 1. Design System Global

O aplicativo segue uma estética "Gamer/Dark Mode" inspirada na identidade visual do Valorant, utilizando alto contraste e cores vibrantes sobre fundos escuros.

### Paleta de Cores (`AppColors`)
O tema é dinâmico, permitindo alternância (controlada pelo `AgentsController`), mas a base é:
- **Background Principal:** `#0F1923` (Dark Blue/Black - Valorant Black) ou `#EEEEEE` (Light Mode alternativo).
- **Cor Primária (Destaque):** `#FD4959` (Valorant Red).
- **Texto Principal:** `#EEEEEE` (Off-white) ou `#14212E` (Dark Blue para Light Mode).
- **Gradientes:**
  - Início: `#6365C2` (Roxo Azulado).
  - Fim: `#292A4B` (Roxo Escuro).
- **Elementos de UI:**
  - Cards/Listas Detalhadas: `#14212E`.
  - Inputs/Campos: `#1E2050` (`darkPurple`).
  - Cores Semânticas: `#FF0000` (Red), `#00FF4C` (Green), `#003569` (Blue).

### Tipografia
- **Fonte Principal:** `Rubik`.
- **Estilos:** Uso pesado de `FontWeight.w700` (Bold) para títulos e `LetterSpacing` (espaçamento entre letras) aumentado (1.5 a 2.0) para simular o estilo "Tech/Tactical" do jogo.

### Padrões de UI Recorrentes
- **State Management na UI:** Uso extensivo de `Obx(() => ...)` do GetX para reatividade.
- **Carregamento:** Skeletons personalizados (`CardSkeleton`, `AgentsGridSkeleton`, etc.) e Shimmer effects.
- **Imagens:** `CachedNetworkImage` para carregamento assíncrono com cache.
- **Layouts:** `Scaffold` padrão, mas frequentemente utilizando `NestedScrollView` ou `CustomScrollView` (implícito em `SingleChildScrollView` com Colunas complexas) para telas de detalhes.

---

## 2. Arquitetura de Navegação

O aplicativo utiliza o sistema de rotas nomeadas do `GetX`.

### Mapa de Navegação
1.  **Splash Screen** (`/splash`) -> Redireciona para Home.
2.  **Home** (`/home`) -> Hub Principal.
    *   **Tabs (TaskBar):** Alterna entre `Agentes`, `Mapas`, `Armas`.
    *   **Drawer:** Menu lateral (implimentado em `AppDrawer`, mas acionado via botão no AppBar).
    *   **FAB (Busca):** Abre Modal Bottom Sheet para busca de jogador -> Leva a `/player-details`.
3.  **Fluxos de Detalhes:**
    *   Home (Tab Agentes) -> `AgentDetailsView` (`/agent-details`).
    *   Home (Tab Mapas) -> `MapDetailsView` (`/map-details`).
    *   Home (Tab Armas) -> `WeaponDetailsView` (`/weapon-details`).
    *   Busca Jogador -> `PlayerDetailsView` (`/players`).
        *   Lista de Partidas -> `MatchPage` (`/match-details`).

---

## 3. Análise Detalhada por Módulo

### 3.1. Módulo Home (`HomeView`)
A tela principal funciona como um container para as três seções principais de conteúdo.
- **AppBar:** Transparente.
    - **Leading:** Ícone de Menu (hambúrguer) que abre o `Scaffold.drawer`.
    - **Title:** Logo SVG do Valorant centralizado (32x32).
- **Body:**
    - Título "ESCOLHA SEU AGENTE" (Texto fixo, muda com o tema).
    - **TaskBar (Widget Customizado):**
        - Atua como uma `TabBar` customizada.
        - Renderiza `AgentsView`, `MapsView` ou `WeaponsView` dependendo da seleção.
        - Indicadores de aba usam peso de fonte e cor para denotar seleção.
- **FloatingActionButton:**
    - Ícone do Valorant.
    - Ação: Abre `_showPlayerSearchDialog`.
- **Player Search Dialog (Modal):**
    - Inputs para "Nome" e "TAG" (Riot ID).
    - Validação simples (campos vazios).
    - Botão "Buscar" navega para `Routes.PLAYER_DETAILS` com argumentos.

### 3.2. Módulo Agentes (`AgentsView` e `AgentDetailsView`)

#### Lista (`AgentsView`)
- **Layout:** `GridView` com 2 colunas (`crossAxisCount: 2`).
- **Cards de Agente:**
    - **Forma Dinâmica:** `_getCardShape` alterna o raio das bordas (cantos arredondados vs retos) baseado no índice par/ímpar para criar um visual "quebrado"/dinâmico.
    - **Transformação 3D:** `Matrix4` aplica leve rotação (tilt) nos cards.
    - **Fundo:** Gradiente baseado nas cores do próprio agente (extraídas da API ou definidas).
    - **Conteúdo:** Imagem do agente (full portrait) sobrepondo levemente as bordas, Nome e Função (Role).

#### Detalhes (`AgentDetailsView`)
Uma tela de rolagem vertical rica em informações.
1.  **Top Image (Header):**
    - Altura fixa (320dp).
    - Gradiente de fundo complexo (3 cores baseadas no agente).
    - Imagem "Full Portrait" deslocada para a direita.
    - Nome e Ícone da Classe no canto superior esquerdo.
2.  **Biografia:** Card com borda sutil contendo descrição.
3.  **Classe (Role):** Card com ícone da classe grande e descrição da função.
4.  **Galeria:**
    - `PageView` com indicador de "bolinhas" customizado (barras que crescem ao serem selecionadas).
    - Mostra: Retrato, Busto, Arte de Fundo.
5.  **Habilidades:**
    - Lista vertical (`AbilityListTile`).
    - Ordenadas por slot (Passiva -> Granada -> Hab1 -> Hab2 -> Ult).
6.  **Agentes Relacionados:** Lista horizontal de outros agentes da mesma classe.

### 3.3. Módulo Armas (`WeaponsView` e `WeaponDetailsView`)

#### Lista (`WeaponsView`)
- **Layout:** `ListView` (lista vertical).
- **Cards de Arma:**
    - Altura fixa (130dp).
    - **Código de Cores:** Cores específicas por categoria (Sniper=Vermelho, Rifle=Roxo, Sidearm=Verde, etc.).
    - **Fundo:** Ícone da categoria gigante e transparente (marca d'água) no fundo.
    - **Dados:** Mostra Preço, Balas no pente e Fire Rate diretamente no card.

#### Detalhes (`WeaponDetailsView`)
Focado em estatísticas técnicas.
1.  **Banner:** Similar aos agentes, mas com ícone da categoria ao fundo. Mostra preço e categoria com "chips" (tags).
2.  **Estatísticas (Grid):** Cards quadrados (3 colunas) mostrando:
    - Fire Rate, Magazine, Reload Time, Equip Time, Penetração de Parede.
3.  **Boneco de Dano (`DamageMannequin`):**
    - Widget visual (provavelmente SVG ou Canvas customizado) que mostra o dano na Cabeça, Corpo e Pernas.
    - Destaque visual com a cor da categoria da arma.
4.  **Gráfico de Alcance (`DamageRangeChart`):** Visualização de como o dano cai com a distância.
5.  **Skins:**
    - Lista horizontal (`ListView.separated`).
    - Cards mostram ícone da skin.
    - Indicador visual se a skin possui vídeo ou wallpaper.
    - Clique abre `SkinDetailsDialog` (Zoom na skin/vídeo).
6.  **Armas Relacionadas:** Lista horizontal de armas da mesma categoria.

### 3.4. Módulo Mapas (`MapsView` e `MapDetailsView`)

#### Lista (`MapsView`)
- **Layout:** `GridView` (2 colunas).
- **Cards de Mapa:**
    - Transformação 3D similar aos Agentes.
    - Imagem "Splash" do mapa ocupando todo o card.
    - Gradiente preto na parte inferior para legibilidade do texto.
    - Nome do mapa e Coordenadas (texto pequeno).

#### Detalhes (`MapDetailsView`)
1.  **Banner:** Imagem Splash grande com Nome e Coordenadas.
2.  **Informações:** Card horizontal dividindo dados: "Tipo" (Bomb/TDM), "Callouts" (qtd), "Regiões" (qtd).
3.  **Galeria:** PageView com Splash, Minimapa, Arte Estilizada e Ícone.
4.  **Callouts (Pontos de Interesse):**
    - Agrupados por "Super Região" (Lado A, Lado B, Meio, Base Atacante, etc.).
    - Cada grupo tem uma cor temática (A=Verde, B=Azul, C=Laranja, Mid=Roxo).
    - Exibidos como "Chips" (tags) dentro de um container da região.

### 3.5. Módulo Jogadores e Partidas (`PlayersView` e `MatchPage`)

#### Detalhes do Jogador (`PlayerDetailsView`)
- **Header:** Card do Jogador (Banner) recuperado da API. Mostra Nome, Tag, Nível e Região.
- **Rank Competitivo (`RankBadge`):**
    - Exibe o ícone do elo (ex: Platina, Ascendente).
    - Mostra MMR atual.
- **Histórico de Partidas (`MatchHistoryCard`):**
    - Lista vertical.
    - Cada card resume: Resultado (Vitória/Derrota), Agente jogado, KDA, Mapa.
    - Clique leva para `MatchPage`.

#### Detalhes da Partida (`MatchPage`)
- **Header Complexo:** `SliverAppBar` expandível.
    - Fundo com gradiente e infos do mapa.
    - Placar central gigante (Ex: 13 X 11) colorido por time (Red vs Blue).
- **Tabs (`TabBar`):**
    1.  **SCOREBOARD:** Tabela com todos os jogadores, separados por time (Red/Blue). Mostra KDA, Pontuação média, Agente.
    2.  **ROUNDS:** Timeline (`RoundTimelineCard`) mostrando o que aconteceu round a round (quem ganhou, como ganhou).
    3.  **KILLS:** Feed de abates (`KillFeedCard`).

---

## 4. Componentes Visuais Específicos (Widgets)

- **`TaskBar`:** Substituto da AppBar padrão na Home. Gerencia o estado das abas principais e renderiza os títulos "Agentes", "Mapas", "Armas".
- **`AppDrawer`:** Menu lateral para navegação secundária ou configurações (temas).
- **`AbilityListTile`:** Card expansível ou fixo para mostrar ícone e texto de habilidade.
- **`DamageMannequin`:** Representação visual humana para exibir valores de dano por hitzone.
- **`RankBadge`:** Componente circular ou icônico para exibir o elo competitivo.
- **`MatchHistoryCard`:** Card denso com resumo de partida (Cor verde para vitória, vermelha para derrota nas bordas/detalhes).

## 5. Observações de UX

1.  **Feedback Visual:** O app usa muitos `Shimmers` (esqueletos animados) para loading, garantindo que a UI não "pule" quando os dados chegam.
2.  **Tratamento de Erro:** Telas de erro centralizadas ou mensagens "Nenhum item na lista" em quase todas as views.
3.  **Consistência:** O uso de "Section Titles" (Título com uma barra colorida vertical ao lado) é onipresente nas telas de detalhes, criando uma hierarquia de informação clara.
4.  **Imersão:** O uso de transformações 3D nos grids e parallax nos headers busca imitar a interface moderna e "tech" do jogo Valorant.

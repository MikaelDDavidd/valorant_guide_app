# Agent Details View Enhancements

## Overview

This plan documents the implementation of three new features for the Agent Details screen to make it more complete and informative.

## Features to Implement

### 1. Role Card (Card da Classe)

**Goal:** Display detailed information about the agent's role/class (Duelist, Sentinel, Controller, Initiator).

**Data Source:** `agent.role.description` from API

**UI Design:**
```
┌──────────────────────────────────────────────┐
│  [Role Icon]  DUELISTA                       │
│                                              │
│  "Duelistas são independentes e caçadores    │
│   de abates. São esperados para buscar       │
│   engajamentos e encontrar o primeiro        │
│   abate."                                    │
└──────────────────────────────────────────────┘
```

**Implementation:**
- New method `_buildRoleCard()` in `agent_details_view.dart`
- Uses `agent.role.displayIcon`, `agent.role.displayName`, `agent.role.description`
- Styled card with agent color accent
- Position: After biography section

---

### 2. Related Agents (Agentes Relacionados)

**Goal:** Show other agents that share the same role/class for easy navigation.

**Data Source:** Filter `controller.agents` by matching `role.uuid`

**UI Design:**
```
┌─ AGENTES RELACIONADOS ─────────────────────▸
│
│  ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐
│  │ img │  │ img │  │ img │  │ img │
│  │     │  │     │  │     │  │     │
│  └─────┘  └─────┘  └─────┘  └─────┘
│   Jett    Phoenix  Reyna    Raze
│
└──────────────────────────────────────────────
```

**Implementation:**
- New method `_buildRelatedAgents()` in `agent_details_view.dart`
- Horizontal scrollable list (`ListView` with `scrollDirection: Axis.horizontal`)
- Filter agents where `role.uuid == currentAgent.role.uuid` and exclude current agent
- Each item is a tappable card that navigates to that agent's details
- Uses `displayIcon` or `bustPortrait` for compact display
- Shows agent name below image
- Position: After abilities section

**Navigation:**
- `Navigator.pushReplacementNamed()` to replace current screen
- Prevents deep navigation stack

---

### 3. Image Gallery (Galeria de Imagens)

**Goal:** Showcase all available artwork for the agent in an interactive gallery.

**Data Source:** Multiple image fields from API:
- `fullPortrait` - Full body art
- `fullPortraitV2` - Alternative full body
- `bustPortrait` - Upper body portrait
- `killfeedPortrait` - Kill feed icon
- `displayIcon` - Standard icon
- `background` - Background art

**UI Design:**
```
┌─ GALERIA ──────────────────────────────────▸
│
│  ┌─────────────────────────────────────────┐
│  │                                         │
│  │          [Selected Image]               │
│  │                                         │
│  └─────────────────────────────────────────┘
│
│  ○ ○ ● ○ ○ ○  (page indicators)
│
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
│  │ 1 │ │ 2 │ │ 3 │ │ 4 │ │ 5 │ │ 6 │  (thumbnails)
│  └───┘ └───┘ └───┘ └───┘ └───┘ └───┘
│
└──────────────────────────────────────────────
```

**Implementation:**
- New method `_buildImageGallery()` in `agent_details_view.dart`
- `PageView` for main image display with swipe gestures
- Row of thumbnail images for quick selection
- Page indicator dots
- Labels for each image type (Portrait, Arte, Ícone, etc.)
- Full screen view on tap (optional - can be phase 2)
- Position: After role card, before abilities

**Image Labels (pt-BR):**
- fullPortrait → "Retrato"
- fullPortraitV2 → "Retrato V2"
- bustPortrait → "Busto"
- killfeedPortrait → "Ícone Abate"
- displayIcon → "Ícone"
- background → "Arte de Fundo"

---

## Section Order (Final Layout)

1. **Banner** (existing) - Hero image with gradient
2. **Biography** (existing) - Agent description
3. **Role Card** (new) - Class information
4. **Image Gallery** (new) - Art showcase
5. **Abilities** (existing) - Skills list
6. **Related Agents** (new) - Same-role agents

---

## Files to Modify

| File | Changes |
|------|---------|
| `agent_details_view.dart` | Add 3 new build methods, update Column children order |
| `agents_controller.dart` | Ensure agents list is accessible for related agents filter |

---

## Dependencies

- `cached_network_image` - Already in use
- `shimmer` - Already in use for loading states

No new dependencies required.

---

## Implementation Steps

1. [ ] Create `_buildRoleCard()` method
2. [ ] Create `_buildImageGallery()` method with PageView
3. [ ] Create `_buildRelatedAgents()` method with horizontal scroll
4. [ ] Update `build()` method to include new sections in correct order
5. [ ] Test navigation between related agents
6. [ ] Verify all image types load correctly

---

## Estimated Complexity

- Role Card: Low
- Image Gallery: Medium (PageView + state management for selection)
- Related Agents: Low-Medium (filtering + navigation)

Total: ~150-200 lines of new code

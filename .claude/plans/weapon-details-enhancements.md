# Weapon Details View Enhancements

## Overview

This plan documents the improvements needed for the Weapon Details screen to match the enhanced design patterns established in Agents and Maps details views.

## Current State

The current `weapon_details_view.dart` has:
- Basic banner with gradient background
- Fire rate stat
- Damage range chart
- Simple damage info display

## Target Improvements

### 1. Enhanced Banner

**Goal:** Match the visual style of agent/map banners with category-based colors.

**Implementation:**
- Use category color as gradient base (same colors from weapons list)
- Add gradient fade to background at bottom
- Show weapon image prominently
- Display name with shadow for readability
- Category badge with icon (same as list)
- Price badge (💰 credits)

**UI Design:**
```
┌─────────────────────────────────────────────┐
│  [gradient based on category color]         │
│                                             │
│  VANDAL              [weapon image]         │
│  [🎯 RIFLE]  [💰 2900]                      │
└─────────────────────────────────────────────┘
```

---

### 2. Stats Card Section

**Goal:** Display all weapon stats in organized, visually appealing cards.

**Data to display:**
- `fireRate` - Taxa de disparo
- `magazineSize` - Capacidade do magazine
- `reloadTimeSeconds` - Tempo de recarga
- `equipTimeSeconds` - Tempo para equipar
- `wallPenetration` - Penetração (Low/Medium/High)

**UI Design:**
```
┌─ ESTATÍSTICAS ──────────────────────────────┐
│                                             │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐       │
│  │ ⚡ 9.75 │ │ 📦 25   │ │ 🔄 2.5s │       │
│  │ Disparo │ │ Magazine│ │ Recarga │       │
│  └─────────┘ └─────────┘ └─────────┘       │
│                                             │
│  ┌─────────┐ ┌─────────┐                   │
│  │ ⏱ 1.0s │ │ 🎯 Alta │                   │
│  │ Equipar │ │ Penetra.│                   │
│  └─────────┘ └─────────┘                   │
│                                             │
└─────────────────────────────────────────────┘
```

---

### 3. Damage Info Section (Enhanced)

**Goal:** Show damage by distance ranges in expandable/organized cards.

**Data source:** `weaponStats.damageRanges[]`

Each range has:
- `rangeStartMeters` / `rangeEndMeters`
- `headDamage` / `bodyDamage` / `legDamage`

**UI Design:**
```
┌─ DANO POR DISTÂNCIA ────────────────────────┐
│                                             │
│  ┌─ 0-15m ─────────────────────────────────┐│
│  │ 🎯 Cabeça: 160  💪 Corpo: 40  🦵 Perna: 34││
│  └─────────────────────────────────────────┘│
│                                             │
│  ┌─ 15-30m ────────────────────────────────┐│
│  │ 🎯 Cabeça: 140  💪 Corpo: 35  🦵 Perna: 30││
│  └─────────────────────────────────────────┘│
│                                             │
│  ┌─ 30-50m ────────────────────────────────┐│
│  │ 🎯 Cabeça: 120  💪 Corpo: 30  🦵 Perna: 26││
│  └─────────────────────────────────────────┘│
│                                             │
└─────────────────────────────────────────────┘
```

**Color coding:**
- Head damage: Red/Orange (highest)
- Body damage: Yellow
- Leg damage: Gray (lowest)

---

### 4. Visual Damage Chart (Keep/Improve)

Keep the existing `DamageRangeChart` widget but ensure it uses category colors.

---

### 5. Related Weapons Section

**Goal:** Show other weapons in the same category.

**Implementation:**
- Filter weapons by same `category`
- Horizontal scrollable list
- Navigate on tap (same as related agents)

**UI Design:**
```
┌─ ARMAS RELACIONADAS ────────────────────────┐
│  Outros Rifles                              │
│                                             │
│  ┌───────┐ ┌───────┐ ┌───────┐ ┌───────┐   │
│  │Phantom│ │ Bulldog│ │Guardian│ │ Odin │   │
│  │ 2900  │ │  2050 │ │  2250 │ │  3200│   │
│  └───────┘ └───────┘ └───────┘ └───────┘   │
│                                             │
└─────────────────────────────────────────────┘
```

---

## Section Order (Final Layout)

1. **Banner** - Hero image with category gradient
2. **Stats Cards** - Quick stats in grid
3. **Damage Chart** - Visual chart (existing)
4. **Damage Ranges** - Detailed damage by distance
5. **Related Weapons** - Same category weapons

---

## Helper Functions Needed

```dart
Color _getCategoryColor(String category)
IconData _getCategoryIcon(String category)
String _getWallPenetrationText(String penetration)
Widget _buildSectionTitle(String title, Color color, int themeIndex)
```

Use same category color/icon functions from `weapons_view.dart`.

---

## Files to Modify

| File | Changes |
|------|---------|
| `weapon_details_view.dart` | Complete rewrite with new sections |
| `damage_range_chart.dart` | Optional: add category color support |

---

## Data Already Available in Entity

```dart
// WeaponEntity
- uuid
- displayName
- category
- displayIcon
- killStreamIcon
- weaponStats
- shopData

// ShopDataEntity
- cost
- category
- categoryText

// WeaponStatsEntity
- fireRate
- magazineSize
- reloadTimeSeconds
- equipTimeSeconds
- wallPenetration
- damageRanges[]

// DamageRangeEntity
- rangeStartMeters
- rangeEndMeters
- headDamage
- bodyDamage
- legDamage
```

All data is already parsed and available - no entity/model changes needed!

---

## Implementation Steps

1. [ ] Create `_getCategoryColor()` and `_getCategoryIcon()` methods (copy from weapons_view)
2. [ ] Implement `_buildSectionTitle()` method (copy pattern from agents/maps)
3. [ ] Rewrite `_buildTopImage()` as `_buildBanner()` with category gradient
4. [ ] Create `_buildStatsCards()` with grid layout
5. [ ] Enhance `_buildDamageInfo()` with range cards
6. [ ] Create `_buildRelatedWeapons()` with horizontal scroll
7. [ ] Update build() with new section order
8. [ ] Test all weapon categories

---

## Dependencies

No new dependencies required. Uses:
- `cached_network_image` - Already in use
- `shimmer` - Already in use

---

## Wall Penetration Translation

```dart
String _getWallPenetrationText(String penetration) {
  switch (penetration.toLowerCase()) {
    case 'low': return 'Baixa';
    case 'medium': return 'Média';
    case 'high': return 'Alta';
    default: return penetration;
  }
}
```

---

## Estimated Complexity

- Banner: Low (copy pattern from agents)
- Stats Cards: Medium (grid layout)
- Damage Ranges: Medium (cards with color coding)
- Related Weapons: Low (copy from agents)

Total: ~200-250 lines of new code

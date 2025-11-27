# Feature Expansion Roadmap

Based on the Valorant API analysis, here are the recommended features to make the app more complete.

## Current State

The app currently has:
- Agents (with abilities)
- Maps
- Weapons (with stats)

## Recommended New Features

### Priority 1 - High Value, Easy Implementation

#### 1. Ranks/Competitive Tiers
**Why:** Every player cares about ranks. Visual rank ladder is engaging.

**Features:**
- Visual rank progression (Iron → Radiant)
- Rank icons with official colors
- RR requirements explanation

**API:** `/competitivetiers`

**Effort:** Low (simple list view with icons)

---

#### 2. Game Modes
**Why:** New players need to understand different modes.

**Features:**
- All available game modes
- Rules and settings for each
- Queue status (if available)

**API:** `/gamemodes`

**Effort:** Low

---

#### 3. Player Cards Gallery
**Why:** Huge collection, very visual, players love to browse.

**Features:**
- Grid view with card previews
- Full-size art viewer
- Filter by theme/event
- Search functionality

**API:** `/playercards`

**Effort:** Medium (400+ items, needs good filtering)

---

### Priority 2 - Good Value, Medium Effort

#### 4. Weapon Skins Browser
**Why:** Skins are a huge part of Valorant culture.

**Features:**
- Browse all weapon skins
- View by weapon or by collection
- Show all chromas/variants
- Video previews where available
- Rarity tier indicators

**API:** `/weapons/skins`, `/contenttiers`, `/themes`

**Effort:** Medium-High (complex nested data)

---

#### 5. Sprays Collection
**Why:** Fun collectibles, many animated ones.

**Features:**
- Grid view of all sprays
- Animated GIF preview
- Category filtering

**API:** `/sprays`

**Effort:** Low-Medium

---

#### 6. Buddies (Weapon Charms)
**Why:** Popular collectibles.

**Features:**
- Grid view of all buddies
- Detail view with levels

**API:** `/buddies`

**Effort:** Low

---

### Priority 3 - Nice to Have

#### 7. Bundles Showcase
**Why:** Shows off premium collections.

**Features:**
- Gallery of all bundles
- Bundle descriptions
- Related items

**API:** `/bundles`

**Effort:** Medium

---

#### 8. Seasons Timeline
**Why:** Historical context for the game.

**Features:**
- Episode/Act timeline
- Current season highlight
- Duration of each season

**API:** `/seasons`

**Effort:** Low

---

#### 9. Agent Contracts
**Why:** Shows progression system.

**Features:**
- Contract rewards preview
- XP per level
- Reward types

**API:** `/contracts`

**Effort:** Medium (complex nested structure)

---

#### 10. Player Titles
**Why:** Completionists want to see all titles.

**Features:**
- Searchable list
- Filter by source

**API:** `/playertitles`

**Effort:** Low

---

## Implementation Phases

### Phase 1 (Quick Wins)
- [ ] Game Modes module
- [ ] Ranks module (Competitive Tiers)
- [ ] Player Titles module

### Phase 2 (Visual Content)
- [ ] Player Cards module
- [ ] Sprays module
- [ ] Buddies module

### Phase 3 (Advanced)
- [ ] Weapon Skins browser (extend weapons module)
- [ ] Bundles showcase
- [ ] Seasons timeline

### Phase 4 (Completeness)
- [ ] Agent Contracts
- [ ] Level Borders
- [ ] Ceremonies (achievements)

---

## App Navigation Suggestion

Current: `Agents | Maps | Weapons`

Proposed tabs:

```
Home | Agents | Weapons | Maps | More
                              └── Ranks
                                  Game Modes
                                  Skins
                                  Cosmetics (Cards, Sprays, Buddies, Titles)
                                  Bundles
                                  Seasons
```

Or bottom nav with drawer:

```
[Bottom Nav]
Agents | Weapons | Maps | Ranks | Menu

[Menu/Drawer]
- Game Modes
- Skins Gallery
- Player Cards
- Sprays
- Buddies
- Titles
- Bundles
- Seasons
- About/Settings
```

---

## Technical Considerations

### Caching Strategy
Most data is static. Implement aggressive caching:
- Cache for 24 hours minimum
- Manual refresh option
- Offline support

### Image Loading
Many endpoints return large image URLs:
- Use cached_network_image
- Implement lazy loading
- Consider image compression

### Search
With 400+ cards, 500+ titles, 700+ skins:
- Implement client-side search
- Consider debouncing
- Add filters (theme, rarity, etc)

### Localization
All endpoints support `?language=pt-BR`:
- Already implemented for agents/maps/weapons
- Apply to new endpoints consistently

---

## API Documentation Reference

Full API documentation available at: `.claude/api/`

| Document | Content |
|----------|---------|
| [README.md](../api/README.md) | All endpoints overview |
| [agents.md](../api/agents.md) | Agents endpoint |
| [maps.md](../api/maps.md) | Maps endpoint |
| [weapons.md](../api/weapons.md) | Weapons + skins |
| [cosmetics.md](../api/cosmetics.md) | Cards, Sprays, Buddies, Titles |
| [competitive.md](../api/competitive.md) | Ranks, Game Modes, Seasons |
| [economy.md](../api/economy.md) | Bundles, Contracts, Currencies |
| [misc.md](../api/misc.md) | Other endpoints |

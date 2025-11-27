# Features

## Current Features

### Agents Browser
- View all playable Valorant agents
- Agent details with full portrait
- Role information (Duelist, Initiator, Controller, Sentinel)
- Abilities list with descriptions and icons

### Weapons Browser
- View all weapons
- Weapon categories (Sidearms, SMGs, Rifles, Snipers, Shotguns, Machine Guns, Melee)
- Weapon stats (fire rate, magazine size, reload time)
- Damage range visualization (head/body/legs damage)

### Maps Browser
- View all game maps
- Map splash images
- Tactical descriptions
- Coordinates

### Theme Support
- Dark theme (default)
- Light theme
- Persistent theme preference

### Image Caching
- Cached network images for performance
- Placeholder loading states

## Roadmap

### Phase 1: Architecture Migration
- [ ] Migrate to Clean Architecture + GetX
- [ ] Implement proper error handling with Either
- [ ] Add base UseCase class
- [ ] Create proper entities and DTOs

### Phase 2: Enhanced Features
- [ ] Dynamic background colors based on agent/weapon
- [ ] Search functionality
- [ ] Favorites system
- [ ] Offline support with local cache

### Phase 3: Additional Content
- [ ] Player Cards
- [ ] Sprays
- [ ] Buddies (weapon charms)
- [ ] Competitive Tiers
- [ ] Game Modes

### Phase 4: Quality
- [ ] Widget testing
- [ ] Integration testing
- [ ] Localization (English, Spanish)
- [ ] Accessibility improvements

### Phase 5: Advanced Features
- [ ] Compare weapons
- [ ] Agent lineup guides
- [ ] Map callouts
- [ ] Settings page

## API Data Available (Not Yet Implemented)

The Valorant API provides additional data that could be integrated:

```
/playercards    - Player card cosmetics
/sprays         - Spray cosmetics
/buddies        - Gun buddies
/competitivetiers - Rank icons and info
/gamemodes      - Game mode information
/ceremonies     - Victory/defeat ceremonies
/contracts      - Agent contracts
/events         - In-game events
/seasons        - Competitive seasons
```

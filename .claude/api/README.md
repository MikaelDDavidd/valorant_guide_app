# Valorant API Documentation

Base URL: `https://valorant-api.com/v1`

## Query Parameters

All endpoints support:
- `?language=pt-BR` - Localized content (Portuguese Brazil)
- `?isPlayableCharacter=true` - Filter playable agents only

## Available Endpoints

| Endpoint | Description | Priority |
|----------|-------------|----------|
| `/agents` | Playable characters | Implemented |
| `/maps` | Game maps | Implemented |
| `/weapons` | All weapons with stats/skins | Implemented |
| `/buddies` | Weapon charms | High |
| `/playercards` | Player banners | High |
| `/sprays` | In-game sprays | High |
| `/playertitles` | Player titles | Medium |
| `/competitivetiers` | Ranked tiers/icons | High |
| `/bundles` | Store bundles | Medium |
| `/gamemodes` | Game modes info | High |
| `/seasons` | Episodes and acts | Medium |
| `/contracts` | Agent/battlepass contracts | Medium |
| `/currencies` | VP, Radianite, etc | Low |
| `/gear` | Shields (armor) | Medium |
| `/contenttiers` | Skin rarity tiers | Low |
| `/themes` | Skin collection themes | Low |
| `/levelborders` | Account level borders | Medium |
| `/ceremonies` | ACE, CLUTCH badges | Low |
| `/events` | Event passes | Low |
| `/flex` | Player totems | Low |
| `/version` | Game version info | Low |

## Detailed Documentation

- [agents.md](./agents.md) - Agents endpoint
- [maps.md](./maps.md) - Maps endpoint
- [weapons.md](./weapons.md) - Weapons endpoint
- [cosmetics.md](./cosmetics.md) - Buddies, Cards, Sprays, Titles
- [competitive.md](./competitive.md) - Ranks, Seasons, Game Modes
- [economy.md](./economy.md) - Bundles, Contracts, Currencies
- [misc.md](./misc.md) - Other endpoints

## Implementation Priority

### Phase 1 - Core Content (Current)
- Agents
- Maps
- Weapons

### Phase 2 - Cosmetics
- Player Cards
- Sprays
- Buddies
- Player Titles

### Phase 3 - Competitive
- Competitive Tiers (Ranks)
- Game Modes
- Seasons/Acts

### Phase 4 - Economy & Extras
- Bundles
- Contracts
- Gear (Shields)
- Level Borders
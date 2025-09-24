# FBNeo Spectator Plugin with Lua Integration

This plugin adds a “Spectate With LUA” option to Fightcade’s context menu, launching FBNeo with a Lua script that monitors player data in real time, and spits it out to a text file for stream integration.

## Contents

- `spectator.lua`: Lua script for FBNeo that reads and maps player data from memory.  
- `plugin.js`: Plugin for Fightcade Plugin Manager that injects the context menu and launches FBNeo.
## What the Lua Script Tracks

- Player character selection  
- Super Art selection  
- Color choice  
- Game phase (e.g. round start, KO screen)  
- Parry state (high and low parry flags)

### Memory Mappings

| Feature                | Address     | Notes |
|------------------------|-------------|-------|
| Player 1 Character     | `0x02011387`| Hex ID mapped to name |
| Player 2 Character     | `0x02011388`| Hex ID mapped to name |
| Player 1 Super Art     | `0x0201138B`| 0 = Super 1, 1 = Super 2, 2 = Super 3 |
| Player 2 Super Art     | `0x0201138C`| Same as above |
| Player 1 Color         | `0x02015683`| 0–5 = lp to hk, else "special" |
| Player 2 Color         | `0x02015684`| Same as above |
| Game Phase             | `0x020154A7`| 1 = Start, 2 = In-round, 6 = KO, 8 = Transition |
| High Parry (P1)        | `0x06202004`| Non-zero = high parry active |
| Low Parry (P1)         | `0x06202404`| Non-zero = low parry active |

## Installation Instructions (Plugin Manager)

### 1. Install Fightcade Plugin Manager

Follow instructions at [nmur/fightcade-plugin-manager](https://github.com/nmur/fightcade-plugin-manager) to install the framework.


### 2. Add Plugin Files

Place the following files inside `plugin/`:

- `spectateWithLua.js`  
- `spectator.lua`  

### 4. Configure FBNeo Path

Edit `config.json` to point to your FBNeo executable:

```json
{
  "fbneoPath": "C:\\Path\\To\\fbneo.exe"
}
```
## Usage

- Right-click a match in Fightcade → Select “Spectate With LUA”  

## Output Example (`mapped_values.txt`)

```
P1: Character: ken (0x0B), Super: Super 2 (1), Color: hp (2)  
P2: Character: chun li (0x10), Super: Super 1 (0), Color: mk (4)  
Game Phase: 0x02 (In-round)  
High Parry: 1  
Low Parry: 0
```

## Credits

Plugin authored by [nmur](https://github.com/nmur)  

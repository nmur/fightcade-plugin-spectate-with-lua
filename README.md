# fightcade-plugin-spectate-with-lua

Automatically run a Lua script when spectating an ongoing match in Fightcade. 

The most common script that this would be used for would be the `3rd_spectator.lua` script from the [Grouflon Training Mode repository](https://github.com/Grouflon/3rd_training_lua), which allows you to view player inputs in real time.

<img width="259" height="71" alt="image" src="https://github.com/user-attachments/assets/5df18d03-c09b-4dc8-98fc-af8a47691954" />
<img width="1773" height="1326" alt="image" src="https://github.com/user-attachments/assets/8602568b-6b48-462d-be8e-8447905f8049" />


## Installation

If you have not done so already, download and install the [fightcade-plugin-manager](https://github.com/nmur/fightcade-plugin-manager).

Download `spectateWithLua.js` from the latest [release](https://github.com/nmur/fightcade-plugin-spectate-with-lua/releases) and place it in your `Fightcade\fc2-electron\resources\app\inject\plugins` directory.

## Configuration
Update the relative paths of the `fcadefbneo.exe` executable as well as the desired spectate .lua file by adding and updating the following to the `plugins\config.json`:
```json
{
    "spectateWithLua": {
        "fbneoPath": "../../../../../emulator/fbneo/fcadefbneo.exe",
        "luaPath": "../../../../../emulator/fbneo/3rd_training_lua-master/3rd_spectator.lua"
    },
}
```

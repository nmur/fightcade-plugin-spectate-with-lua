const path = require('path');
const { exec } = require('child_process');
const config = require('./config.json');

module.exports = (FCADE) => { runPlugin(FCADE) };

const defaultConfig = {
    fbneoPath: "../../../../../emulator/fbneo/fcadefbneo.exe",
    luaPath: "../../../../../emulator/fbneo/3rd_training_lua-master/3rd_spectator.lua"
};

const runPlugin = (FCADE) => {
    if (!config.spectateWithLua) {
        config.spectateWithLua = defaultConfig
    }

    overridePlayingContextMenu(FCADE);
}

const overridePlayingContextMenu = (FCADE) => {
    FCADE.$options.components["Channel"].components.UsersList.methods.showMatchContextMenu = function (e, t, n) {
        this.channel.spectators && (this.contextMenuData = {
            user: e.player1,
            position: t,
            limitRect: n,
            callback: () => {
                spectateWithLua(this.channel.gameid, e.quarkId, e.port);
            },
            items: [{
                id: "spectate",
                text: "Spectate With LUA"
            }]
        },
        this.$emit("show-context-menu", this.contextMenuData));
    };
}

const spectateWithLua = (gameId, quarkId, port) => {
    exec(getSpectateCommandString(gameId, quarkId, port), (_error, _stdout, _stderr) => {});
};

const getSpectateCommandString = (gameId, quarkId, port) => {
    return [
        path.resolve(__dirname, config.spectateWithLua.fbneoPath),
        '--lua',
        path.resolve(__dirname, config.spectateWithLua.luaPath),
        `quark:stream,${gameId},${quarkId}.2,${port}`
    ].join(' ');
}

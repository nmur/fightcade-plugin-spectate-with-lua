const { exec } = require('child_process');
const config = require('./config.json');

module.exports = (FCADE) => { runPlugin(FCADE) };

const fbneoPath = config.fbneoPath;
const luaPath = "--lua "+ __dirname + "/spectator.lua";

const runPlugin = (FCADE) => {
    // Override the Playing context menu 
    FCADE.$options.components["Channel"].components.UsersList.methods.showMatchContextMenu = function(e, t, n) {
        this.channel.spectators && (this.contextMenuData = {
            user: e.player1,
            position: t,
            limitRect: n,
            callback: () => {
                spectateWithLua(this.channel.gameid, e.quarkId, e.port)
            },
            items: [{
                id: "spectate",
                text: "Spectate With LUA"
            }]
        },
        this.$emit("show-context-menu", this.contextMenuData))
    }

    document.addEventListener("keydown", (e) => {
        if (e.key === "F11") {
            exec(commandStr, (error, stdout, stderr) => {});
        }
    });
}

const spectateWithLua = (gameId, quarkId, port) => {
    const commandStr = fbneoPath + " " + luaPath + " " + "quark:stream," + gameId + "," + quarkId + ".2," + port;
    exec(commandStr, (error, stdout, stderr) => {});
}

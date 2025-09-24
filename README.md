# Fightcade Third Strike Stream Helper

This is a Lua script for Fightcade that provides real-time information about a Third Strike match, such as character selection, color, and parries. This is designed to be used for stream overlays and other cool effects.

There's a Third Strike tournament streamed every fortnight in Australia, and they use Fightcade to run everything. This plugin was developed to help with the stream production.

## Installation

This script is a plugin for the [Fightcade Plugin Manager](https://github.com/nmur/fightcade-plugin-manager). Please refer to their repository for instructions on how to install and use plugins.

Once the plugin manager is installed, you can install this plugin by following these steps:

1.  Download the latest release of this plugin.
2.  Place the plugin folder in the `fc2-electron/plugins` directory.
3.  Start Fightcade and the plugin should be active.

## Usage

The plugin will automatically start when you are spectating a Third Strike match. It will output a file named `mapped_values.txt` in the Fightcade directory, which contains the real-time match data. You can use this file to create your own stream overlays.

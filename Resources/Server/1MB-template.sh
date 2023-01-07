#!/usr/bin/env bash

# @Filename: 1MB-template.sh
# @Version: 1.0.1, build 003
# @Release: January 7th, 2023
# @Description: Helps us clone /template to /server
# @Contact: I am @floris on Twitter, and mrfloris in MineCraft.
# @Discord: floris#0233 on https://discord.gg/floris
# @Install: chmod a+x 1MB-template.sh
# @Syntax: ./1MB-template.sh
# @URL: Latest source, wiki, & support: https://scripts.1moreblock.com/

_debug=true # Set to false to minimize output.

Y="\\033[33m"; C="\\033[36m"; R="\\033[0m" # theme

function _output {
    case "$1" in
    oops)
        _args="${*:2}"; _prefix="(Script Halted!)";
        echo -e "\\n$B$Y$_prefix$X $_args $R" >&2; exit 1
    ;;
    okay)
        _args="${*:2}"; _prefix="(Info)";
        echo -e "\\n$B$Y$_prefix$C $_args $R" >&2; exit 1
    ;;
    debug)
        _args="${*:2}"; _prefix="(Debug)";
        [[ "$_debug" == true ]] && echo -e "$Y$_prefix$C $_args $R"
    ;;
    *)
        _args="${*:1}"; _prefix="(Info)";
        echo -e "\\n$_prefix $_args"
    ;;
    esac
}

_output debug "Okay, starting script.."

[ "$EUID" -eq 0 ] && _output oops "*!* This script should not be run using sudo, or as the root user!"

_output debug "Setting unique timestamp.."
now=$(date +"%m_%d_%Y_%H%M%S")

_output debug "Changing to working dir.."
cd /home/minecraft

_output debug "Creating server-$now.tar.gz, this might take a moment.."
tar -cpzf /home/minecraft/archive/server-$now.tar.gz -C /home/minecraft server

_output debug "Purging old /server/ dir.."
rm -rf /home/minecraft/server/

_output debug "Restoring /server/ from /templates/.."
cp -R /home/minecraft/templates/server/ /home/minecraft/server/

_output debug "Changing to /server/ dir.."
cd /home/minecraft/server/

_output okay "Done. You can start the server with ./1MB-start.sh, it will fork to the background."

#EOF Copyright (c) 2011-2023 - Floris Fiedeldij Dop - https://scripts.1moreblock.com

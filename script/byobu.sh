#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"


if [ -z "$(byobu-tmux list-sessions | grep 'dev-tfw-component-world-map')" ]
then
  byobu-tmux new-session -d -t 'dev-tfw-component-world-map' # creates a new detached byobu-tmux session

  byobu-tmux rename-window Main
  byobu-tmux send-keys -t 0 "cd '$DIR/..'" 'C-m'
  byobu-tmux send-keys -t 0 'atom .' 'C-m'
  byobu-tmux split-window -h
  byobu-tmux send-keys -t 1 "cd '$DIR/..'" 'C-m'
  byobu-tmux send-keys -t 1 'npm start' 'C-m'

  byobu-tmux new-window
  byobu-tmux rename-window Demo
  byobu-tmux send-keys -t 0 "cd '$DIR/../demo'" 'C-m'
  byobu-tmux send-keys -t 0 'npm run' 'C-m'
  byobu-tmux split-window -h
  byobu-tmux send-keys -t 1 "cd '$DIR/../demo'" 'C-m'
  byobu-tmux send-keys -t 1 'npm start' 'C-m'
fi
# Enter byobu-tmux
byobu-tmux attach -t 'dev-tfw-component-world-map'

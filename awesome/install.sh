#/usr/bin/env bash

AWESOME_DIR="$HOME/.config/awesome"
REPO_URL="https://github.com/dcalacci/powerarrow-solarized"

if [ -d $AWESOME_DIR ]; then
    mv $AWESOME_DIR $AWESOME_DIR.bak
fi

git clone $REPO_URL $AWESOME_DIR

# replace username
user=$(id -u -n) 
sed -i 's/dan/'$user'/g' $AWESOME_DIR/rc.lua{,.test}

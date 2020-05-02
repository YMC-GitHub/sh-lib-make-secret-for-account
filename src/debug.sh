#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)

echo "some sh cmd version:"
cat --version | grep "cat" | sed "s/(GNU coreutils) //g"
md5sum --version | grep "md5sum" | sed "s/(GNU coreutils) //g"
cut --version | grep "cut" | sed "s/(GNU coreutils) //g"

:<<note
echo "some sh cmd help:"
cat --help
md5sum --help
cut --help
note

# set project dir position
source $THIS_FILE_PATH/function-list.sh
THIS_PROJECT_PATH=$(path_resolve "$THIS_FILE_PATH" "..")
RUN_SCRIPT_PATH=$(pwd)

# include some file
source "$THIS_PROJECT_PATH/src/en_password.sh"
[ $? -eq 0 ] && echo "Generate Password List Complete."

# ./debug.sh
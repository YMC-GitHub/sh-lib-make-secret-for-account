#!/bin/sh

function en_password() {
   local TEXT=
  local FILE=
  local KEY=
  local VAL=
  local FILE_NAME=
  local FILE_PATH=

  FILE_NAME=password.txt
  KEY="ymc"
   if [ -n "${THIS_PROJECT_PATH}" ]; then
      FILE_PATH="$THIS_PROJECT_PATH/secret/"
    else
      FILE_PATH="./"
  fi
  if [ -n "${1}" ]; then
    KEY="${1}"
  fi
  if [ -n "${2}" ]; then
    FILE_PATH="${2}"
  fi
  if [ -n "${3}" ]; then
    FILE_NAME="${3}"
  fi
  FILE="${FILE_PATH}${FILE_NAME}"
  TEXT_LENGTH=16

  #echo "$KEY"
  # clear the old password
  #rm -rf $FILE
  # generate the new password
  # base64加密
  #echo  "$TEXT" | base64 >> $FILE
  # md5加密
  #KEY=registry.cn-hangzhou.aliyuncs.com/yemiancheng
  VAL=$(echo -n "$KEY" | md5sum | cut -d ' ' -f1)
  #cat --help
:<<note
  echo "VAL:${VAL:0:$TEXT_LENGTH}"
  echo "KEY:$KEY" >> $FILE
  echo "VAL:${VAL:0:$TEXT_LENGTH}" >> $FILE
  echo "file_out：$FILE"
note
  TEXT=$(cat <<EOF
KEY:$KEY
VAL:${VAL:0:$TEXT_LENGTH}
EOF
)
  #echo "$TEXT"
  #echo "$TEXT" >> $FILE
  cat >> $FILE << EOF
$TEXT
EOF
}
#en_password "hh"

:<<note
echo "some sh cmd version:"
cat --version | grep "cat" | sed "s/(GNU coreutils) //g"
md5sum --version | grep "md5sum" | sed "s/(GNU coreutils) //g"
cut --version | grep "cut" | sed "s/(GNU coreutils) //g"
note

function sample(){
KEY=111
echo -n "$KEY" | md5sum | cut -d ' ' -f1
VAL=$(echo -n "$KEY" | md5sum | cut -d ' ' -f1)
echo "$VAL"
}
#sample
#en_password

# ./src/en_password.sh
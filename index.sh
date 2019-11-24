#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)

# set project dir position
source $THIS_FILE_PATH/sh-lib-path-resolve.sh
THIS_PROJECT_PATH=$(path_resolve "$THIS_FILE_PATH" ".")
RUN_SCRIPT_PATH=$(pwd)

# include some file
#source "$THIS_PROJECT_PATH/src/en_password.sh"

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

function travor_list() {
  local KEY_VAL_MAP=
  local key=
  local val=
  local i=
  local KEY_VAL_ARR=
  local REG_SHELL_COMMOMENT_PATTERN=
  local path=
  local KEY_VAL_MAP=
  KEY_VAL_MAP=$(
    cat <<EOF
registry.cn-hangzhou.aliyuncs.com/yemiancheng
EOF
  )
  if [ -n "$1" ]; then
    KEY_VAL_MAP="$1"
  fi

  KEY_VAL_MAP=$(echo "$KEY_VAL_MAP" | sed "s/^ *#.*//g" | sed "/^ *$/d")
  REG_SHELL_COMMOMENT_PATTERN="^#"
  KEY_VAL_ARR=(${KEY_VAL_MAP//,/ })
  for i in "${KEY_VAL_ARR[@]}"; do
    # 获取键名
    key=$(echo $i | awk -F'=' '{print $1}')
    # 获取键值
    #val=$(echo $i | awk -F'=' '{print $2}')
    #echo "$key"
    en_password "$key"
  done
}

function main_fun() {
  travor_list
}
# for one
# en_password
# for many
# travor_le'choist
main_fun
#time_now=$( date "+%Y-%m-%d %H:%M:%S" | md5sum |cut -d ' ' -f1|cut -b 1-8)

[ $? -eq 0 ] && echo "Generate Password List Complete."

## file  usage
# ./index.sh
# sh ./index.sh

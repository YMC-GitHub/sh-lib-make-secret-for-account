#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)

# set project dir position
source $THIS_FILE_PATH/sh-lib-path-resolve.sh
THIS_PROJECT_PATH=$(path_resolve "$THIS_FILE_PATH" "..")
RUN_SCRIPT_PATH=$(pwd)

# include some file
source "$THIS_PROJECT_PATH/src/en_password.sh"


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
# ./src/index.sh
# sh ./src/index.sh

#!/bin/bash


if [ ! -f ./conf/.project.env.sh ] || [ ! -f $PRECISION100_FOLDER/conf/.env.sh ]; then
   echo "Misconfigured installation - missing files in conf directory or invalid Precision100 installation"
   exit 5
fi

source ./conf/.project.env.sh
source $PRECISION100_FOLDER/conf/.env.sh

DEFAULT_EXECUTION_NAME="mock1"
read -p "Enter Execution Name [$DEFAULT_EXECUTION_NAME] " INPUT_EXECUTION_NAME
PRECISION100_EXECUTION_NAME=${INPUT_EXECUTION_NAME:-$DEFAULT_EXECUTION_NAME}

EXECUTION_PID_FILE="$PRECISION100_PROJECT_CONF_FOLDER/.execution.pid"
echo $PRECISION100_EXECUTION_NAME > "$EXECUTION_PID_FILE"

PRECISION100_EXECUTION_CONF_FILE_NAME="$PRECISION100_PROJECT_CONF_FOLDER/$PRECISION100_EXECUTION_NAME.env.sh"

cat > "$PRECISION100_EXECUTION_CONF_FILE_NAME" << EOL
export PRECISION100_EXECUTION_NAME="$PRECISION100_EXECUTION_NAME"
export PRECISION100_EXECUTION_FOLDER="$PRECISION100_PROJECT_FOLDER/$PRECISION100_EXECUTION_NAME"
EOL
source "$PRECISION100_EXECUTION_CONF_FILE_NAME"

source "$PRECISION100_CONF_FOLDER/.execution.env.sh"

mkdir -p "$PRECISION100_EXECUTION_LOG_FOLDER"
log_file_name="$PRECISION100_EXECUTION_LOG_FOLDER/init-exec-$(date +%F-%H-%M-%S).out"
err_file_name="$PRECISION100_EXECUTION_LOG_FOLDER/init-exec-$(date +%F-%H-%M-%S).err"

$PRECISION100_FOLDER/bin/init-exec.sh 1> >(tee -a "$log_file_name") 2> >(tee -a "$err_file_name" >&2)

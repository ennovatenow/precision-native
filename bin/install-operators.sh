#!/bin/bash

source ./conf/.project.env.sh
source $PRECISION100_FOLDER/conf/.env.sh

$PRECISION100_BIN_FOLDER/install-operator.sh $1 $2


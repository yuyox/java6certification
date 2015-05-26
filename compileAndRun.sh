#!/bin/bash

BASE_DIR=$(dirname $0)
DEFAULT_TARGET_DIR=$BASE_DIR/target
TARGET_DIR=$DEFAULT_TARGET_DIR
DEFAULT_JAVA_OPTIONS="-g:none"

function printUsage
{
  if [ -n "$1" ]
  then
    echo "$(basename $0) - $1"
  fi
  echo "$(basename $0) - [OPTIONS]"
  echo " j <path/file.java>  : Java class to compile and run (REQUIRED)"
  echo " t <path>            : Target directory (deafult:$DEFAULT_TARGET_DIR)"
  echo " h                   : Usage"
}

while getopts j:t:h OPT
do
  case $OPT in
    (j)  JAVA_FILE="$OPTARG";;
    (t)  TARGET_DIR="$OPTARG";;
    (h)  printUsage;exit 0;; 
    (?)  printUsage;exit 1;; 
  esac
done

if [ -z "$JAVA_FILE" ]
then
  printUsage "Usage error - Option -j is required"
fi

CLASS_NAME=$(sed -r 's:([a-zA-Z0-9]+)\.java$:\1:' <<< "$JAVA_FILE" | tr '/' '.')

mkdir -p $TARGET_DIR

# Compile
javac -d $TARGET_DIR $JAVA_FILE 

if [ "$?" == 0 ]
then
  echo "########################"
  echo "#Compilation Successful#"
  echo "########################"
  # Run
  java -cp $TARGET_DIR $CLASS_NAME
  if [ "$?" != 0 ]
  then
    echo "########################"
    echo "#   Runtime Exception  #"
    echo "########################"
  fi
else
  echo "########################"
  echo "#   Compilation Error  #"
  echo "########################"
fi
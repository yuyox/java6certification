#!/bin/bash
#set -x

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
  echo " l                   : List all the available classes"
  echo " h                   : Usage"
}

function listClasses
{
  cd $BASE_DIR
  ls -1 */*.java
}

while getopts j:t:lh OPT
do
  case $OPT in
    (j)  JAVA_FILE="$OPTARG";;
    (t)  TARGET_DIR="$OPTARG";;
    (l)  listClasses;exit 0;;
    (h)  printUsage;exit 0;; 
    (?)  printUsage;exit 1;; 
  esac
done

if [ ! "$JAVA_FILE" ]
then
  printUsage "Usage error - Option -j is required" 1>&2
  exit 1
fi

JAVA_FILE=$(find $JAVA_FILE -maxdepth 1 -type f)

for FILE in $JAVA_FILE
do
  CLASS_NAME+="$(sed -r 's:([a-zA-Z0-9]+)\.java$:\1:g' <<< "$FILE" | tr '/' '.') "
done

if [ $(grep -o " " <<< "$CLASS_NAME" | wc -l) -gt 1 ]
then
  CLASS_NAME=$(egrep -o '[a-zA-Z0-9.]*Main' <<< "$CLASS_NAME")
fi

if [ ! "$CLASS_NAME" ]
then
  printUsage "No Main class found, please refer to the README.md" 1>&2
  exit 1
fi

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

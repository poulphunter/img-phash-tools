#!/bin/bash
set -o pipefail
#set -euxo pipefail
#trap 'cd ${PWD}' EXIT

#./scripts/demo/show_qsimg_sort.sh $(pwd)"/tests/datas" $(pwd)"/tests/datasSort" --reference $(pwd)"/tests/datas/imageBlackCircle1.png" --mode averageHash --max-files 3 --max-dist 30


IFS='' read -r -d '' HELP <<"EOF"
Usage: show_qsimg_sort [OPTIONS] [DIRECTORY_IN] [DIRECTORY_OUT]

Find similar images of a reference image with perceptual hash algorithms
 and sort the nearest into an other folder.

-c/--copy : copy files (default use of symbolic links only)
-m [MODE]/--mode [MODE] : See qsimg's help : qsimg --help
-r/--recurse : See qsimg's help : qsimg --help
-fv/--flip-v : See qsimg's help : qsimg --help
-fh/--flip-h : See qsimg's help : qsimg --help
--block-mean-hash-mode [VALUE]: See qsimg's help : qsimg --help
--marr-hildreth-hash-alpha [VALUE] : See qsimg's help : qsimg --help
--marr-hildreth-hash-scale [VALUE] : See qsimg's help : qsimg --help
--radial-variance-hash-sigma [VALUE] : See qsimg's help : qsimg --help
--radial-variance-hash-num-of-angle-line [VALUE] : See qsimg's help : qsimg --help
EOF

COPY=0
POSITIONAL_ARGS=()
QSIMG_ARGS=""
MAX_FILES=""
MAX_DIST=""
while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--copy)
      COPY=1
      shift # past argument
      ;;
    --max-dist)
      MAX_DIST=$2
      shift # past argument
      shift # past argument
      ;;
    --max-files)
      MAX_FILES=$2
      shift # past argument
      shift # past argument
      ;;
    -fv|--flip-v)
      QSIMG_ARGS="${QSIMG_ARGS} --flip-v"
      shift # past argument
      ;;
    -fh|--flip-h)
      QSIMG_ARGS="${QSIMG_ARGS} --flip-h"
      shift # past argument
      ;;
    -r|--recurse)
      QSIMG_ARGS="${QSIMG_ARGS} --recurse"
      shift # past argument
      ;;
    --block-mean-hash-mode|--marr-hildreth-hash-alpha|--marr-hildreth-hash-scale|--radial-variance-hash-sigma|--radial-variance-hash-num-of-angle-line)
      QSIMG_ARGS="${QSIMG_ARGS} $1 $2"
      shift # past argument
      shift # past argument
      ;;
    -m|--mode)
      QSIMG_ARGS="${QSIMG_ARGS} --mode $2"
      shift # past argument
      shift # past argument
      ;;
    -m=*|--mode=*)
      MODE="${1#*=}"
      QSIMG_ARGS="${QSIMG_ARGS} --mode $MODE"
      shift # past argument
      ;;
    -ref|--reference)
      QSIMG_ARGS="${QSIMG_ARGS} $2"
      shift # past argument
      shift # past argument
      ;;
    -ref=*|--reference=*)
      REFERENCE="${1#*=}"
      # shellcheck disable=SC2089
      QSIMG_ARGS="${QSIMG_ARGS} --reference \"$REFERENCE\""
      shift # past argument
      ;;
    -h|--help)
      echo -en "$HELP"
      exit 0
      ;;
    -*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      echo "ARG=$1"
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [[ $# -ne 2 ]]; then
    echo "$0: Need 2 non optional arguments: input and output directory."
    exit 4
fi

echo "DIRECTORY_IN  = ${1}"
echo "DIRECTORY_OUT  = ${2}"
echo "MAX_FILES  = ${MAX_FILES}"
echo "MAX_DIST  = ${MAX_DIST}"
echo "COPY  = ${COPY}"
echo "QSIMG_ARGS  = $QSIMG_ARGS"

# shellcheck source=/dev/null
source ./.venv/bin/activate

DIR_IN=$(pwd)"/tests/datas"
DIR_OUT=$(pwd)"/tests/datasSort"
rm "${DIR_OUT}"/*
mkdir -p "${DIR_OUT}"

# averageHash, blockMeanHash, marrHildrethHash, pHash, radialVarianceHash
# shellcheck disable=SC2090,SC2086
FILE_LIST=$(qsimg "${DIR_IN}" $QSIMG_ARGS --verbose)
#echo "$FILE_LIST" > filelist.txt
# FILE_LIST=$(cat filelist.txt)

COUNTER=0
while read -r F
do
	COUNTER=$(( COUNTER + 1 ))
	F=${F//[$'\t\r\n']}
	F2=$(echo "$F" | cut -d';' -f1)
	DIST=$(echo "$F" | cut -d';' -f2)
	DIST=$((DIST))
	if [ "$MAX_DIST" != "" ] && [ "$DIST" -gt "$MAX_DIST" ]; then
		echo -en "prison\r      \r";break
	fi
	if [ "$MAX_FILES" != "" ] && [ "$COUNTER" -gt "$MAX_FILES" ]; then
		echo -en "prison\r      \r";break
	fi
	F="$F2"
	CNT_STRING=$(printf "%08d\n" $DIST)
	if [ "$OSTYPE" == "win32" ] || [ "$OSTYPE" == "msys" ]; then
		# Win to Unix format
		F=$(echo "$F"  | sed -e 's#\\#/#g' -e 's#\$#/\\$#g' -e 's#^\([a-zA-Z]\):#/\L\1#')
    # Unix to Win
    # echo "$F" | sed -e 's/^\///' -e 's/\//\\/g' -e 's/^./\0:/'
	fi
	filename=$(basename -- "$F")
	echo "${CNT_STRING}_${filename}"

	if [ "$COPY" -eq 1 ]; then
		cp "$F" "${DIR_OUT}/${CNT_STRING}_${filename}"
  else
    ln -s "$F" "${DIR_OUT}/${CNT_STRING}_${filename}"
	fi

done < <(echo "$FILE_LIST")

echo "🎉 Done !"

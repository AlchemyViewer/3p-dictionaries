#!/usr/bin/env bash

# turn on verbose debugging output for parabuild logs.
exec 4>&1; export BASH_XTRACEFD=4; set -x
# make errors fatal
set -e
# complain about unset env variables
set -u

if [ -z "$AUTOBUILD" ] ; then 
    exit 1
fi

if [ "$OSTYPE" = "cygwin" ] ; then
    autobuild="$(cygpath -u $AUTOBUILD)"
else
    autobuild="$AUTOBUILD"
fi

STAGING_DIR="$(pwd)"
TOP_DIR="$(dirname "$0")"
SRC_DIR="${TOP_DIR}/src"

# load autobuild provided shell functions and variables
source_environment_tempfile="$STAGING_DIR/source_environment.sh"
"$autobuild" source_environment > "$source_environment_tempfile"
. "$source_environment_tempfile"

LICENSE_DIR="${STAGING_DIR}/LICENSES"
test -d ${LICENSE_DIR} || mkdir ${LICENSE_DIR}
echo "See *-dictionary-license.txt" > "${LICENSE_DIR}/dictionaries.txt"

dictionaries_version=1.0.0
echo "${dictionaries_version}" > "${STAGING_DIR}/VERSION.txt"

DICT_DIR="${STAGING_DIR}/dictionaries"
test -d ${DICT_DIR} || mkdir ${DICT_DIR}

# Dictionary meta-data
cp -v "${SRC_DIR}/dictionaries.xml" "${DICT_DIR}/"

# Second Life
cp -v "${SRC_DIR}/sl.dic" "${DICT_DIR}/sl.dic"

# English
cp -v ${SRC_DIR}/en/*.{aff,dic} "${DICT_DIR}/"
cp -v ${SRC_DIR}/en/*.txt ${LICENSE_DIR}

# Spanish
cp -v ${SRC_DIR}/es/*.{aff,dic} "${DICT_DIR}/"
cp -v ${SRC_DIR}/es/*.txt ${LICENSE_DIR}

# German
cp -v ${SRC_DIR}/de/*.{aff,dic} "${DICT_DIR}/"
cp -v ${SRC_DIR}/de/*.txt ${LICENSE_DIR}

# French
cp -v ${SRC_DIR}/fr/*.{aff,dic} "${DICT_DIR}/"
cp -v ${SRC_DIR}/fr/*.txt ${LICENSE_DIR}

# Brazilian Portugese
cp -v ${SRC_DIR}/pt_br/*.{aff,dic} "${DICT_DIR}/"
cp -v ${SRC_DIR}/pt_br/*.txt ${LICENSE_DIR}

# Russian
cp -v ${SRC_DIR}/ru/*.{aff,dic} "${DICT_DIR}/"
cp -v ${SRC_DIR}/ru/*.txt ${LICENSE_DIR}

# Ukrainian
cp -v ${SRC_DIR}/uk/*.{aff,dic} "${DICT_DIR}/"
cp -v ${SRC_DIR}/uk/*.txt ${LICENSE_DIR}

#!/bin/sh

#
# Usage.
#

usage () {
cat << EOF

  Usage: shortcut [options] <replace> <with>

  Options:

    -h, --help     output usage information
    -v, --version  output version

  Examples:

    $ shortcut "omw" "on my way"

  See also: man 1 shortcut
EOF
}

#
# Version.
#

version () {
  echo "1.0.1"
}

#
# Options.
#

case $1 in
  "")           usage; exit 1 ;;
  -h|--help)    usage; exit ;;
  -v|--version) version; exit ;;
  *)            readonly replace=$1 ; readonly with=$2 ;;
esac

#
# Find SQLite database.
#

database=$(find ~/Library/Dictionaries/CoreDataUbiquitySupport/$USER~*/UserDictionary/*/store/UserDictionary.db | head -1)

if [[ "$database" == "" ]]; then
  echo
  echo "Could not find database."
  echo "osx-shortcut requires Mavericks or higher."
  echo "If you are on Mavericks or higher, please raise an issue:"
  echo
  echo "  https://github.com/wooorm/osx-shortcut/issues/new"
  exit 1
fi

#
# Find primary key.
#

typeset -i primary=$(sqlite3 "$database" 'SELECT Z_MAX from "Z_PRIMARYKEY"')

#
# Get current time.
#

now=$(date +%s)

#
# Insert a shortcut to replace `$1` with `$2`.
#
# @param $1 - Replace.
# @param $2 - With.
#
insert() {
  let primary+=1
  sqlite3 "$database" "INSERT INTO \"ZUSERDICTIONARYENTRY\" VALUES($primary,1,1,0,0,0,0,$now,NULL,NULL,NULL,NULL,NULL,'$2','$1',NULL)"
}

#
# Insert.
#

insert "$replace" "$with"

#
# Update primary key in `Z_PRIMARYKEY` table.
#

sqlite3 "$database" "UPDATE 'Z_PRIMARYKEY' SET Z_MAX = $primary"

#
# Restart AppleSpell.
#

killall -e AppleSpell &> /dev/null

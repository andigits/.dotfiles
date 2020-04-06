#!/bin/bash
#
# setwm.sh
# Usage: setwm.sh <window-manager>
# Update window manager settings

SCRIPT=${0##*/}

I3="i3"
GF="gnome-flashback"

update_i3 () {
  echo "Update settings for $I3"
  rm ~/.config/autostart/plank.desktop
}

update_gf () {
  echo "Update settings for $GF"
  cp ~/settings/plank.desktop ~/.config/autostart/
}

print_usage () {
  echo "Usage: $SCRIPT <window-manager>"
 }

print_help () {
  print_usage
  echo
  echo "Copy nasbackup to <window-manager>"
  echo
  echo "Required arguments:"
  echo "  <window-manager>  -i or --i3 for '$I3' '"
  echo "  <window-manager>  -g or --flashback for '$GF'"
}

parse_args() {
  # Parse input args with getopts
  while getopts :hig-: opt; do
    # ----- long options
    if [ "$opt" = "-" ]; then
      opt=$OPTARG
      [ -z "$opt" ] && break # "--" terminates argument processing
    fi
    case $opt in
      h | help)
        print_help
        exit
        ;;
      i | i3)
        update_i3
        exit
        ;;
      g | flashback)
        update_gf
        exit
        ;;
      \?) if [ "$OPTARG" != "?" ] ; then echo "Unknown option -$OPTARG, see -h for help."; fi
        print_usage
        exit
        ;;
      *) echo "Unknown option --$opt, see -h for help."
        exit 2
        ;;
    esac
  done
  shift $((OPTIND-1))  # remove parsed options and args from $@ list
}

parse_args "${@}"

if [ "${#}" -lt "1" ]; then
  echo "<window-manager> is required. See -h for help."
  exit 1
else
  echo "Parameter not supported. See -h for help."
  exit 1
fi




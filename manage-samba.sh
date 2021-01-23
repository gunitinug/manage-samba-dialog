#!/bin/bash

# MANAGE SAMBA SCRIPT
# Description: Facilitates adding/removing samba share folders using dialog interface
# Author: Logan Won-Ki Lee
# Version: 1.01
# Date: 23 January 2021

function display_output() {
    dialog --backtitle "" --title "" --clear --msgbox "$1" 10 90
}

function list_shares() {
    display_output "$(net usershare info)"
}

function execute() {
    # debug
    #echo "cmd: $@" >&2
    
    local output status

    output=$(exec 2>&1; "$@")
    status=$?

    # display error if there is one. otherwise display "Success"
    [[ $status -ne 0 ]] && display_output "$output" || display_output "Success."
    return "$status"
}

function yesno() {
    dialog --title "Confirm" \
       --backtitle "Confirm command" \
       --yesno "$*" 7 90

    [[ $? -eq 0 ]] && execute "$@" || return 1
}

function create_share() {
    local share_folder
    local -a values

    share_folder=$(dialog --stdout --title "Use space to select and enter to finalize" --dselect ~/ 14 70) || return

    # Store data to values array
    mapfile -t values < <(
        dialog --quoted --ok-label "Submit" \
              --backtitle "Linux Samba Management" \
              --title "Add usershare" \
              --form "Create a shared folder. Share name must not include space." \
        15 90 0 \
            "Share name:" 1 1   ""  1 15 10 0 \
            "Share folder:"    2 1  "$share_folder"     2 15 100 0 \
            "Comments:"    3 1  ""      3 15 50 0 \
        2>&1 >/dev/tty)

    # return if form is cancelled
    #wait $! || return
    [[ $? -ne 0 ]] && return

    # get rid of \ from "$share_folder"
    values[1]=$(echo $share_folder | sed 's/\\//g')
    
    case $1 in
        PUBW) yesno net usershare add "${values[@]}" Everyone:F guest_ok=y; yesno chmod 777 "${values[1]}" ;;
        PUBR) yesno net usershare add "${values[@]}" Everyone:R guest_ok=y ;;
        PRVW) yesno net usershare add "${values[@]}" Everyone:F guest_ok=n; yesno chmod 777 "${values[1]}" ;;
        PRVR) yesno net usershare add "${values[@]}" Everyone:R guest_ok=n ;;
    esac
}

# DELETE SHARE SECTION START
function find_dir() {
    declare -A config=(); 

    while IFS=$' \t=:' read -r key value; do 
	case $key in 
	    "["*"]") section=${key#"["} section=${section%"]"} ;; 
	    [!\;]*) config[$section;$key]=$value ;; 
	esac; 
    done < <(net usershare info)

    # $1 is section
    echo ${config["$1";"path"]}
}

function delete_share() {
     share_del=$(dialog --quoted --ok-label "Submit" \
		   --backtitle "Linux Samba Management" \
		   --title "Delete usershare" \
		   --form "Delete a shared folder" \
	    15 90 0 \
		   "Share name:" 1 1 "" 1 15 10 0 \
	    2>&1 >/dev/tty)

     # return to main menu if form is cancelled
     #wait $! || return
     [[ $? -ne 0 ]] && return

     # scan info to find corresponding share dir
     share_dir=$(find_dir "$share_del")
     
     yesno net usershare delete $share_del
     yesno chmod 755 "$share_dir"
}
# DELETE SHARE SECTION END

# try out main menu
# the main menu is in an infinite loop

while true; do
    menuitem=$(dialog --clear --backtitle "Linux Shell Script Tutorial" \
        --title "Samba shares tasks" \
        --menu "Choose your task" 50 100 10 \
        PUBW "Create a public writable shared folder" \
        PUBR "Create a public read-only shared folder" \
        PRVW "Create a private writable shared folder" \
        PRVR "Create a private read-only shared folder" \
        LIST "List shares" \
        DEL "Delete a share" \
        EXIT "Exit to the shell" \
        2>&1 >/dev/tty)

    # make decision
    case $menuitem in
        PUB[WR]|PRV[WR]) create_share "$menuitem" ;;
        LIST) list_shares ;;
        DEL) delete_share ;;
        EXIT) break ;;
    esac
done

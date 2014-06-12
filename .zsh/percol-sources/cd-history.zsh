typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history
function chpwd-record-history () {
	echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd-record-history)

function percol-get-destination-from-history () {
	sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
		sed -e 's/^[ ]*[0-9]*[ ]*//' | \
		sed -e s"/^${HOME//\//\\/}/~/" | \
		percol | xargs echo
}

function percol-cd-history () {
	local destination=$(percol-get-destination-from-history)
	[ -n $destination ] && cd ${destination/#\~/${HOME}}
	zle reset-prompt
}
zle -N percol-cd-history

function percol-insert-cd-history () {
	local destination=$(percol-get-destination-from-history)
	if [ $? -eq 0 ]; then
		local new_left="${LBUFFER} ${destination} "
		BUFFER=${new_left}${RBUFFER}
		CURSOR=${#new_left}
	fi
	zle reset-prompt
}
zle -N percol-insert-cd-history
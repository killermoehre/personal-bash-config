# Ansible managed

# bash-generics

## debug bash scripts
alias debug_enable="export PS4='+${BASH_SOURCE}:${LINENO}:${FUNCNAME[0]}: '"
alias debug_disable="export PS4=''"

# CCEE

## ccloud_multitool
cld() {
    exec {fd_ccloud}>>/dev/stdout
    . <(ccloud-multitool --stdout-fd $fd_ccloud "$@")
    exec {fd_ccloud}>&-
}
source <(cld completion bash --prog-name cld)
alias ccm="cld"
alias cls="cld clear"
alias cll="cld last"

## info for stale NAT
staleNAT() {
    export ROUTER_ID=$1
    XTOKEN="$(openstack token issue -f value -c id)"
    ASR1K_HOST_ID="$(openstack network agent list --router "$ROUTER_ID" -c Host -f value)"
    curl -H "X-Auth-Token: ${XTOKEN}" "https://network-3.${OS_REGION_NAME}.cloud.sap/v2.0/asr1k/devices/${ASR1K_HOST_ID}"
    echo "show run vrf ${ROUTER_ID//-/}"
    echo "configure terminal"
}

## check for NetworkNamespaceProbesFailed
## usage: probesfailed $ROUTER_ID $NETWORK_ID
probesfailed() {
    export ROUTER_ID=$1
    export NETWORK_ID=$2
    VRF="${ROUTER_ID//-/}"
    XTOKEN="$(openstack token issue -f value -c id)"
    echo "checking for staleNAT"
    if hammer asr find-stale-nat | grep -q "$VRF"; then
        ASR1K_HOST_ID="$(openstack network agent list --router "$ROUTER_ID" -c Host -f value)"
        curl -H "X-Auth-Token: ${XTOKEN}" -s -X GET "https://network-3.${OS_REGION_NAME}.cloud.sap/v2.0/asr1k/devices/${ASR1K_HOST_ID}" | jq -r '.[] | ."host"'
        echo ""
        echo "show run vrf $VRF"
        echo "show ip nat translations vrf $VRF"
        echo "configure terminal"
    else
        echo "no staleNAT"
        echo "checking for broken dynamic NAT"
        hammer asr find-broken-dynamic-nat

        echo "checking diffs on router "
        SYNC="$(curl -s -H "X-Auth-Token: ${XTOKEN}" -X GET "https://network-3.${OS_REGION_NAME}.cloud.sap/v2.0/asr1k/routers/${ROUTER_ID}")"
        CHECK="$(echo "$SYNC" | grep ": {}}")"
        if [ "$CHECK" ]; then
            echo "router has no diffs"
        else
            echo "router not in sync - syncing"
            curl -H "X-Auth-Token: ${XTOKEN}" -X PUT "https://network-3.${OS_REGION_NAME}.cloud.sap/v2.0/asr1k/routers/${ROUTER_ID}"
            echo -e "\nplease check diffs again"
        fi
        STATE="$(openstack router show "${ROUTER_ID}" -c status -f value | grep -v ACTIVE)"
        if [ "$STATE" ]; then
            printf "router is in error state\nchecking subnet cidr\n"
            openstack subnet show "$(openstack router show "${ROUTER_ID}" -c interfaces_info -f value | jq ".[0].subnet_id" | sed s/\"//g)" -c cidr -f value
        else
            echo "router is not in error state"
        fi
    fi
    if test -n "$NETWORK_ID"; then
        echo "hammer aci epg $NETWORK_ID"
        hammer aci epg "$NETWORK_ID"
    else
        echo "no network given"
    fi
}
# Ansible managed

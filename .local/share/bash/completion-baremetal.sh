_baremetal()
{
  local cur prev words
  COMPREPLY=()
  _get_comp_words_by_ref -n : cur prev words

  # Command data:
  cmds='allocation chassis complete conductor create deploy driver help node port volume'
  cmds_allocation='create delete list set show unset'
  cmds_allocation_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --resource-class --trait --candidate-node --name --uuid --owner --extra --wait --node'
  cmds_allocation_delete='-h --help'
  cmds_allocation_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --limit --marker --sort --node --resource-class --state --owner --long --fields'
  cmds_allocation_set='-h --help --name --extra'
  cmds_allocation_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --fields'
  cmds_allocation_unset='-h --help --name --extra'
  cmds_chassis='create delete list set show unset'
  cmds_chassis_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --description --extra --uuid'
  cmds_chassis_delete='-h --help'
  cmds_chassis_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --fields --limit --long --marker --sort'
  cmds_chassis_set='-h --help --description --extra'
  cmds_chassis_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --fields'
  cmds_chassis_unset='-h --help --description --extra'
  cmds_complete='-h --help --name --shell'
  cmds_conductor='list show'
  cmds_conductor_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --limit --marker --sort --long --fields'
  cmds_conductor_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --fields'
  cmds_create='-h --help'
  cmds_deploy='template'
  cmds_deploy_template='create delete list set show unset'
  cmds_deploy_template_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --uuid --extra --steps'
  cmds_deploy_template_delete='-h --help'
  cmds_deploy_template_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --limit --marker --sort --long --fields'
  cmds_deploy_template_set='-h --help --name --steps --extra'
  cmds_deploy_template_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --fields'
  cmds_deploy_template_unset='-h --help --extra'
  cmds_driver='list passthru property raid show'
  cmds_driver_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --type --long'
  cmds_driver_passthru='call list'
  cmds_driver_passthru_call='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --arg --http-method'
  cmds_driver_passthru_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_driver_property='list'
  cmds_driver_property_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_driver_raid='property'
  cmds_driver_raid_property='list'
  cmds_driver_raid_property_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_driver_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty'
  cmds_help='-h --help'
  cmds_node='abort add adopt bios boot clean console create delete deploy inject inspect list maintenance manage passthru power provide reboot rebuild remove rescue set show trait undeploy unrescue unset validate vif'
  cmds_node_abort='-h --help --provision-state'
  cmds_node_add='trait'
  cmds_node_add_trait='-h --help'
  cmds_node_adopt='-h --help --provision-state --wait'
  cmds_node_bios='setting'
  cmds_node_bios_setting='list show'
  cmds_node_bios_setting_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_node_bios_setting_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty'
  cmds_node_boot='device'
  cmds_node_boot_device='set show'
  cmds_node_boot_device_set='-h --help --persistent'
  cmds_node_boot_device_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --supported'
  cmds_node_clean='-h --help --provision-state --wait --clean-steps'
  cmds_node_console='disable enable show'
  cmds_node_console_disable='-h --help'
  cmds_node_console_enable='-h --help'
  cmds_node_console_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty'
  cmds_node_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --chassis-uuid --driver --driver-info --property --extra --uuid --name --bios-interface --boot-interface --console-interface --deploy-interface --inspect-interface --management-interface --network-data --network-interface --power-interface --raid-interface --rescue-interface --storage-interface --vendor-interface --resource-class --conductor-group --automated-clean --owner --lessee --description'
  cmds_node_delete='-h --help'
  cmds_node_deploy='-h --help --provision-state --wait --config-drive'
  cmds_node_inject='nmi'
  cmds_node_inject_nmi='-h --help'
  cmds_node_inspect='-h --help --provision-state --wait'
  cmds_node_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --limit --marker --sort --maintenance --no-maintenance --retired --no-retired --fault --associated --unassociated --provision-state --driver --resource-class --conductor-group --conductor --chassis --owner --lessee --description-contains --long --fields'
  cmds_node_maintenance='set unset'
  cmds_node_maintenance_set='-h --help --reason'
  cmds_node_maintenance_unset='-h --help'
  cmds_node_manage='-h --help --provision-state --wait'
  cmds_node_passthru='call list'
  cmds_node_passthru_call='-h --help --arg --http-method'
  cmds_node_passthru_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_node_power='off on'
  cmds_node_power_off='-h --help --power-timeout --soft'
  cmds_node_power_on='-h --help --power-timeout'
  cmds_node_provide='-h --help --provision-state --wait'
  cmds_node_reboot='-h --help --soft --power-timeout'
  cmds_node_rebuild='-h --help --provision-state --wait --config-drive'
  cmds_node_remove='trait'
  cmds_node_remove_trait='-h --help --all'
  cmds_node_rescue='-h --help --provision-state --wait --rescue-password'
  cmds_node_set='-h --help --instance-uuid --name --chassis-uuid --driver --bios-interface --reset-bios-interface --boot-interface --reset-boot-interface --console-interface --reset-console-interface --deploy-interface --reset-deploy-interface --inspect-interface --reset-inspect-interface --management-interface --reset-management-interface --network-interface --reset-network-interface --network-data --power-interface --reset-power-interface --raid-interface --reset-raid-interface --rescue-interface --reset-rescue-interface --storage-interface --reset-storage-interface --vendor-interface --reset-vendor-interface --reset-interfaces --resource-class --conductor-group --automated-clean --protected --protected-reason --retired --retired-reason --target-raid-config --property --extra --driver-info --instance-info --owner --lessee --description'
  cmds_node_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --instance --fields'
  cmds_node_trait='list'
  cmds_node_trait_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_node_undeploy='-h --help --provision-state --wait'
  cmds_node_unrescue='-h --help --provision-state --wait'
  cmds_node_unset='-h --help --instance-uuid --name --resource-class --target-raid-config --property --extra --driver-info --instance-info --chassis-uuid --bios-interface --boot-interface --console-interface --deploy-interface --inspect-interface --network-data --management-interface --network-interface --power-interface --raid-interface --rescue-interface --storage-interface --vendor-interface --conductor-group --automated-clean --protected --protected-reason --retired --retired-reason --owner --lessee --description'
  cmds_node_validate='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_node_vif='attach detach list'
  cmds_node_vif_attach='-h --help --vif-info'
  cmds_node_vif_detach='-h --help'
  cmds_node_vif_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column'
  cmds_port='create delete group list set show unset'
  cmds_port_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --node --uuid --extra --local-link-connection -l --pxe-enabled --port-group --physical-network --is-smartnic'
  cmds_port_delete='-h --help'
  cmds_port_group='create delete list set show unset'
  cmds_port_group_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --node --address --name --uuid --extra --mode --property --support-standalone-ports --unsupport-standalone-ports'
  cmds_port_group_delete='-h --help'
  cmds_port_group_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --limit --marker --sort --address --node --long --fields'
  cmds_port_group_set='-h --help --node --address --name --extra --mode --property --support-standalone-ports --unsupport-standalone-ports'
  cmds_port_group_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --address --fields'
  cmds_port_group_unset='-h --help --name --address --extra --property'
  cmds_port_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --address --node --port-group --limit --marker --sort --long --fields'
  cmds_port_set='-h --help --node --address --extra --port-group --local-link-connection --pxe-enabled --pxe-disabled --physical-network --is-smartnic'
  cmds_port_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --address --fields'
  cmds_port_unset='-h --help --extra --port-group --physical-network --is-smartnic'
  cmds_volume='connector target'
  cmds_volume_connector='create delete list set show unset'
  cmds_volume_connector_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --node --type --connector-id --uuid --extra'
  cmds_volume_connector_delete='-h --help'
  cmds_volume_connector_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --node --limit --marker --sort --long --fields'
  cmds_volume_connector_set='-h --help --node --type --connector-id --extra'
  cmds_volume_connector_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --fields'
  cmds_volume_connector_unset='-h --help --extra'
  cmds_volume_target='create delete list set show unset'
  cmds_volume_target_create='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --node --type --property --boot-index --volume-id --uuid --extra'
  cmds_volume_target_delete='-h --help'
  cmds_volume_target_list='-h --help -f --format -c --column --quote --noindent --max-width --fit-width --print-empty --sort-column --node --limit --marker --sort --long --fields'
  cmds_volume_target_set='-h --help --node --type --property --boot-index --volume-id --extra'
  cmds_volume_target_show='-h --help -f --format -c --column --noindent --variable --prefix --max-width --fit-width --print-empty --fields'
  cmds_volume_target_unset='-h --help --extra --property'

  dash=-
  underscore=_
  cmd=""
  words[0]=""
  completed="${cmds}"
  for var in "${words[@]:1}"
  do
    if [[ ${var} == -* ]] ; then
      break
    fi
    if [ -z "${cmd}" ] ; then
      proposed="${var}"
    else
      proposed="${cmd}_${var}"
    fi
    local i="cmds_${proposed}"
    i=${i//$dash/$underscore}
    local comp="${!i}"
    if [ -z "${comp}" ] ; then
      break
    fi
    if [[ ${comp} == -* ]] ; then
      if [[ ${cur} != -* ]] ; then
        completed=""
        break
      fi
    fi
    cmd="${proposed}"
    completed="${comp}"
  done

  if [ -z "${completed}" ] ; then
    COMPREPLY=( $( compgen -f -- "$cur" ) $( compgen -d -- "$cur" ) )
  else
    COMPREPLY=( $(compgen -W "${completed}" -- ${cur}) )
  fi
  return 0
}
complete -F _baremetal baremetal

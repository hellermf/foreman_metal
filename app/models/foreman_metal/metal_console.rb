module ForemanMetal
  module MetalConsole
    def console(uuid)
      Foreman::Logging.logger('foreman_metal').debug "Starting VNC console..."
      vm = find_vm_by_uuid(uuid)
      WsProxy.start(:host => 'cave.vampire', :host_port => 5901, :password => 'quxxquux').merge(
	      :name => vm.name, :type => 'vnc'
      )
    end
  end
end

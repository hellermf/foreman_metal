module ForemanMetal
  class Metal < ComputeResource
    include MetalConsole

    validates :wrapper, :presence => true

    def wrapper
      attrs[:wrapper]
    end

    def wrapper=(value)
      attrs[:wrapper] = value
    end

    def self.provider_friendly_name
      'Bare metal pseudo provider'
    end

    def self.model_name
      ComputeResource.model_name
    end

    def vms(opts = {})
      vms = []
      # TODO
      ForemanMetal::Vms.new(vms)
    end

    def associated_host(vm)
      associate_by('mac', vm.mac)
    end
  end
end

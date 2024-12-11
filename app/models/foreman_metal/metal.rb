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

    def initialize
      @fakevms = []
      @fakevms << ForemanMetal::FakeVM.new("fake-one", 7, "11:22:33:44:55:66")
      @fakevms << ForemanMetal::FakeVM.new("fake-two", 42, "33:44:55:66:77:88")
      @fakevms << ForemanMetal::FakeVM.new("fake-1601", 1601, "2c:ea:7f:db:04:67")
    end

    def vms(opts = {})
      # TODO
      ForemanMetal::Vms.new(@fakevms)
    end

    def associated_host(vm)
      associate_by('mac', vm.mac)
    end
  end
end

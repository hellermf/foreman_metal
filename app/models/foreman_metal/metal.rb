module ForemanMetal
  class Metal < ComputeResource
    include MetalConsole

    def self.provider_friendly_name
      'Bare metal psuedo provider'
    end

  end
end

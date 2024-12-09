module ForemanMetal
  class Metal < ComputeResource
    include MetalConsole

    def self.provider_friendly_name
      'Bare metal pseudo provider'
    end

    def self.model_name
      ComputeResource.model_name
    end
  end
end

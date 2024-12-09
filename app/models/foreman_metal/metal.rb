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
  end
end

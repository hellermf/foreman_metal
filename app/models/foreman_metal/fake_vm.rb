module ForemanMetal
  class FakeVM
    attr_accessor :name, :node_id, :mac

    def initialize(name, node_id, mac)
      @name = name
      @node_id = node_id
      @mac = mac
    end

    def unique_cluster_identity(compute_resource)
      compute_resource.id.to_s + '_' + @node_id.to_s
    end

    def identity
      @node_id.to_s
    end

    def ready?
      true
    end

    def state
      'RUNNING'
    end
  end
end

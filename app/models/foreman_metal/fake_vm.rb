module ForemanMetal
  class FakeVM
    attr_accessor :name, :node_id, :ip

    def initialize(name, node_id, ipv4)
      @name = name
      @node_id = node_id
      @ip = ipv4
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

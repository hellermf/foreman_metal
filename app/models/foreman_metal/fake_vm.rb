module ForemanMetal
  class FakeVM
    attr_accessor :name, :node_id, :mac

    def initialize(name, node_id, mac)
      @name = name
      @node_id = node_id
      @mac = mac
    end
  end
end

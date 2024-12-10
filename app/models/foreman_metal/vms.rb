# GPLv3, borrowed from ForemanFogProxmox.
module ForemanMetal
  class Vms
    attr_reader :items

    def each(&block)
      @items.each(&block)
    end

    # TODO: Pagination with filters
    def all(_filters = {})
      items
    end

    def initialize(items = [])
      @items = items
    end
  end
end

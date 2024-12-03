module InnerPlan
  class NamedList
    def initialize
      @list = []
    end

    def add(id, value)
      @list << [id.to_sym, value]
    end

    def add_after(after_id, id, value)

    end
  end
end

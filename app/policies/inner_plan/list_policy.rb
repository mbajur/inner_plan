module InnerPlan
  class ListPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def edit?
      true
    end

    def update?
      edit?
    end

    def new?
      true
    end

    def create?
      new?
    end

    def update_position?
      update?
    end
  end
end

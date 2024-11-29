# frozen_string_literal: true

module InnerPlan
  class Configuration
    attr_accessor :user_class_name

    def initialize
      @user_class_name = 'User'
    end
  end
end

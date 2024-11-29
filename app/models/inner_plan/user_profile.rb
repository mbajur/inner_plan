module InnerPlan
  class UserProfile < ApplicationRecord
    belongs_to :user, class_name: InnerPlan.configuration.user_class_name

    def avatar_url
      hash = Digest::SHA256.hexdigest(user.email.downcase)
      "https://gravatar.com/avatar/#{hash}?s=100&default=mp"
    end

    def to_s
      user.email.split('@').first
    end
  end
end

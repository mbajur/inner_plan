module InnerPlan
  class UserWithAvatarComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ImageTag

    def initialize(user, avatar_size: 20)
      @user = user
      @avatar_size = avatar_size
    end

    def template
      image_tag(@user.profile.avatar_url, size: @avatar_size,
                                          class: 'rounded-circle me-1',
                                          style: 'margin-top:-0.1rem')
      plain @user.profile.to_s
    end
  end
end

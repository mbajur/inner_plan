module InnerPlan
  class UserWithAvatarComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ImageTag

    def initialize(user, avatar_size: 20)
      @user = user
      @avatar_size = avatar_size
    end

    def template
      image_tag(@user.inner_plan_avatar_url, size: @avatar_size,
                                             class: 'rounded-circle me-1',
                                             style: 'margin-top:-0.1rem')
      plain @user.inner_plan_to_s
    end
  end
end

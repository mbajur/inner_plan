module InnerPlan::Tasks::Row
  class AssigneesAddonComponent < BaseAddonComponent
    include Phlex::Rails::Helpers::ImageTag

    def render?
      !task.completed? && task.assigned_user_ids.any?
    end

    def template
      task.assigned_users.map do |user|
        small(class: "text-nowrap opacity-50 ms-1") {
          image_tag(user.profile.avatar_url, size: 20,
                                             class: 'rounded-circle me-1',
                                             style: '')
          plain(user.profile.to_s)
        }
      end
    end
  end
end

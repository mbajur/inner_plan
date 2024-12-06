module InnerPlan
  class Task < ApplicationRecord
    belongs_to :list
    belongs_to :user, class_name: InnerPlan.configuration.user_class_name,
                      optional: true

    positioned on: :list

    scope :ongoing, ->{ where(completed_at: nil) }
    scope :completed, ->{ where.not(completed_at: nil).order(completed_at: :desc) }
    scope :ordered_by_position, ->{ order(position: :asc) }
    scope :recently_completed_first, -> { order(completed_at: :desc) }

    validates :title, presence: true

    def ongoing?
      !completed?
    end

    def completed?
      completed_at.present?
    end

    def complete!
      touch(:completed_at)
    end

    def reopen!
      update(completed_at: nil)
    end

    def to_param
      [id.to_s, title.first(20).to_url].join('-')
    end
  end
end

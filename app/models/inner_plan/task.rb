module InnerPlan
  class Task < ApplicationRecord
    belongs_to :group, counter_cache: true
    has_one :list, through: :group

    positioned on: :group

    scope :ongoing, ->{ where(completed_at: nil) }
    scope :completed, ->{ where.not(completed_at: nil).order(completed_at: :desc) }
    scope :ordered_by_position, ->{ order(position: :asc) }

    validates :title, presence: true

    after_create :increment_list_counter_cache

    def ongoing?
      !completed?
    end

    def completed?
      completed_at.present?
    end

    def complete!
      touch(:completed_at)
      list.increment!(:completed_tasks_count)
    end

    def reopen!
      update(completed_at: nil)
      list.decrement!(:completed_tasks_count)
    end

    private

    def increment_list_counter_cache
      list.increment!(:tasks_count)
      list.increment!(:completed_tasks_count) if completed?
    end
  end
end

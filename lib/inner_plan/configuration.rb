# frozen_string_literal: true

module InnerPlan
  class Configuration
    attr_accessor :user_class_name
    attr_accessor :task_edit_view_rows
    attr_accessor :task_show_view_rows
    attr_accessor :task_row_addons

    def initialize
      @user_class_name = 'User'

      # Tasks::EditView rows
      due_on_item = proc { |context:, form:|
        InnerPlan::Tasks::Form::ItemComponent.new(icon: Phlex::Icons::Tabler::CalendarDue, title: 'Due on') do
          context.plain form.date_field :due_on,
                                        class: "form-control",
                                        autofocus: (context.focus == :due_on)
        end
      }

      description_item = proc { |context:, form:|
        InnerPlan::Tasks::Form::ItemComponent.new(icon: Phlex::Icons::Tabler::FileText, title: 'Description') do
          context.plain form.text_area(:description, class: 'form-control', autofocus: (context.focus == :description))
        end
      }

      @task_edit_view_rows = InnerPlan::SmartArray.new([
        InnerPlan::SmartArray::Item.new(:primary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:due_on, { span: 6 }, due_on_item),
        ])),

        InnerPlan::SmartArray::Item.new(:secondary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:description, { span: 12 }, description_item)
        ]))
      ])

      # Tasks::ShowView rows
      due_on_item = proc { |context:|
        InnerPlan::Tasks::Show::ItemComponent.new(icon: Phlex::Icons::Tabler::CalendarDue, title: 'Due on') do
          context.a(
            href: (context.helpers.edit_task_path(context.task, focus: :due_on)),
            class:
              (
                context.class_names(
                  "text-decoration-none",
                  "text-body-tertiary" => context.task.due_on.blank?,
                  "text-reset" => context.task.due_on.present?
                )
              )
          ) do
            if context.task.due_on
              context.plain context.task.due_on.strftime("%a, %b %e, %Y")
            else
              context.plain " Select a date... "
            end
          end
        end
      }

      description_item = proc { |context:|
        InnerPlan::Tasks::Show::ItemComponent.new(icon: Phlex::Icons::Tabler::FileText, title: 'Description') do
          if context.task.description.present?
            context.plain context.description.to_s
          else
            context.a(
              href: (context.helpers.edit_task_path(context.task, focus: :description)),
              class:
                (
                  context.class_names(
                    "text-decoration-none",
                    "text-body-tertiary" => context.task.description.blank?,
                    "text-reset" => context.task.description.present?
                  )
                )
            ) { " Click to add description... " }
          end
        end
      }

      created_by_item = proc { |context:|
        InnerPlan::Tasks::Show::ItemComponent.new(icon: Phlex::Icons::Tabler::CirclePlus, title: 'Created By') do
          context.div(class: "text-body-tertiary") do
            context.render(InnerPlan::UserWithAvatarComponent.new(context.task.user))
            context.plain " on "
            context.plain context.task.created_at.strftime("%a, %b %e, %Y")
          end
        end
      }

      @task_show_view_rows = InnerPlan::SmartArray.new([
        InnerPlan::SmartArray::Item.new(:primary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:due_on, { span: 6 }, due_on_item),
        ])),

        InnerPlan::SmartArray::Item.new(:secondary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:description, { span: 12 }, description_item)
        ])),

        InnerPlan::SmartArray::Item.new(:tertiary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:created_by, { span: 12 }, created_by_item)
        ]))
      ])

      @task_row_addons = InnerPlan::SmartArray.new([
        InnerPlan::SmartArray::Item.new(:group, {}, InnerPlan::Tasks::Row::GroupAddonComponent),
        InnerPlan::SmartArray::Item.new(:group, {}, InnerPlan::Tasks::Row::DescriptionAddonComponent),
        InnerPlan::SmartArray::Item.new(:group, {}, InnerPlan::Tasks::Row::DueOnAddonComponent),
      ])
    end
  end
end

# frozen_string_literal: true

module InnerPlan
  class Configuration
    attr_accessor :user_class_name,
                  :current_user_method,
                  :task_edit_view_rows,
                  :task_show_view_rows,
                  :list_edit_view_rows,
                  :task_row_addons,
                  :additional_importmap_modules

    def initialize
      @user_class_name = 'User'
      @current_user_method = :current_user
      @additional_importmap_modules = []

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
      @task_show_view_rows = InnerPlan::SmartArray.new([
        InnerPlan::SmartArray::Item.new(:primary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:due_on, { span: 6 }, 'InnerPlan::Tasks::Show::Items::DueOnComponent'),
        ])),

        InnerPlan::SmartArray::Item.new(:secondary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:description, { span: 12 }, 'InnerPlan::Tasks::Show::Items::DescriptionComponent'),
        ])),

        InnerPlan::SmartArray::Item.new(:tertiary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:created_by, { span: 6 }, 'InnerPlan::Tasks::Show::Items::CreatedByComponent'),
        ])),
      ])

      @list_edit_view_rows = InnerPlan::SmartArray.new([
        InnerPlan::SmartArray::Item.new(:primary_row, {}, InnerPlan::SmartArray.new([
          InnerPlan::SmartArray::Item.new(:description, { span: 12 }, 'InnerPlan::Lists::Edit::Items::DescriptionComponent'),
        ])),
      ])

      @task_row_addons = InnerPlan::SmartArray.new([
        ::InnerPlan::SmartArray::Item.new(:group, {}, 'InnerPlan::Tasks::Row::GroupAddonComponent'),
        ::InnerPlan::SmartArray::Item.new(:description, {}, 'InnerPlan::Tasks::Row::DescriptionAddonComponent'),
        ::InnerPlan::SmartArray::Item.new(:due_on, {}, 'InnerPlan::Tasks::Row::DueOnAddonComponent'),
      ])
    end
  end
end

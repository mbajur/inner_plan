list = InnerPlan::List.create! title: 'Work and such'
group = InnerPlan::Group.create! list: list, title: 'Default', default: true

InnerPlan::Task.create! group: group, title: 'Duplikowanie produktów nie kopiuje cen'
InnerPlan::Task.create! group: group, title: 'na android rozwala fotki - maja zły wymiar'
InnerPlan::Task.create! group: group, title: 'wymuszenie w formularzu adresu wpisania numeru ulicy osobno'
InnerPlan::Task.create! group: group, title: 'Masowe promocje nie odejmują tylko dodają do cen'
InnerPlan::Task.create! group: group, title: 'Duplikowanie produktów nie kopiuje cen', completed_at: Time.current
InnerPlan::Task.create! group: group, title: 'Kiedy stan na minusie a desired na zero, nie dodawać produktu do raportu dla szwalni', completed_at: Time.current
InnerPlan::Task.create! group: group, title: 'Dodatki do koszyka', completed_at: Time.current
InnerPlan::Task.create! group: group, title: 'zliczanie na home tylko zamówień opłaconych i odejmowanie anulowanych', completed_at: Time.current

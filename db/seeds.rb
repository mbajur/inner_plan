user = User.create! email: 'email@example.com', password: 'ChangeMe666'
InnerPlan::Profile.create! user: user

list = InnerPlan::List.create! title: 'Work and such', user: user
sub = InnerPlan::sub.create! list: list, title: 'Default', default: true, user: user

InnerPlan::Task.create! sub: sub, title: 'Duplikowanie produktów nie kopiuje cen', user: user
InnerPlan::Task.create! sub: sub, title: 'na android rozwala fotki - maja zły wymiar', user: user
InnerPlan::Task.create! sub: sub, title: 'wymuszenie w formularzu adresu wpisania numeru ulicy osobno', user: user
InnerPlan::Task.create! sub: sub, title: 'Masowe promocje nie odejmują tylko dodają do cen', user: user
InnerPlan::Task.create! sub: sub, title: 'Duplikowanie produktów nie kopiuje cen', completed_at: Time.current, user: user
InnerPlan::Task.create! sub: sub, title: 'Kiedy stan na minusie a desired na zero, nie dodawać produktu do raportu dla szwalni', completed_at: Time.current, user: user
InnerPlan::Task.create! sub: sub, title: 'Dodatki do koszyka', completed_at: Time.current
InnerPlan::Task.create! sub: sub, title: 'zliczanie na home tylko zamówień opłaconych i odejmowanie anulowanych', completed_at: Time.current, user: user

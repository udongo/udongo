require File.join(Udongo::PATH, 'lib/tasks/task_extras.rb')

namespace :udongo do
  include TaskExtras

  namespace :sortable do
    desc 'Generates new positions for a given model.'
    task :generate_positions_for_model do
      class_name = user_input 'What model needs the positions?'
      class_name.to_s.camelcase.constantize.all.each_with_index do |o, index|
        o.update_attribute(:position, index + 1)
      end
    end
  end
end

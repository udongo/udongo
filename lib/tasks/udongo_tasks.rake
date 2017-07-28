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

  namespace :queue do
    desc 'Checks the queue for tasks and executes at most 3 of them'
    task process: :environment do

      # This code will process at most 3 records from the queue. The attempts
      # are done 1 by 1, because if you would fetch all the 5 tasks at once you
      # might risk another process already completed the task which leaves only
      # some already executed task.
      3.times do
        QueuedTask.not_locked.limit(1).each { |t| t.process! }
      end
    end
  end
end

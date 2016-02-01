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

  namespace :content_images do
    desc 'Regenerate all the image versions.'
    task regenerate: :environment do
      ::ContentImage.find_each do |i|
        if i.file?
          i.file.recreate_versions!
          i.save!
        end
      end
    end
  end

  namespace :queue do
    desc 'Check the queue for tasks and execute 1 and then dequeue it.'
    task process: :environment do

      QueuedTask.not_locked.limit(5).each do |t|
        t.lock!

        begin
          t.run!
          t.dequeue!
        rescue
          raise
        ensure
          t.unlock! unless t.destroyed?
        end
      end
    end
  end
end

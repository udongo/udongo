[![Code Climate](https://codeclimate.com/repos/55225453e30ba0015300479e/badges/6cdc017255ce2cab1336/gpa.svg)](https://codeclimate.com/repos/55225453e30ba0015300479e/feed)

# Concerns
## Storable concern
### Possible field types
* string
* integer
* date
* date_time
* boolean
* array

### Example

    class User < ActiveRecord::Base
      include Concerns::Storable

      storable_field :gender, :string, default: 'male'
      storable_field :age, :integer
      storable_field :last_login_at, :date_time
      storable_field :cool_dude, :boolean, default: true
      storable_field :locales, :array, default: %w(nl)
      storable_field :birthday, :date
    end

### Default values for each type
* string => nil
* integer => nil
* date => nil
* date_time => nil
* boolean => false
* array => nil

# Queue
## Add tasks to the queue
You can add tasks to the queue by executing:

    QueuedTask.queue('SomeClass', id: 37, foo: bar)

The first paramter specifiecs the string of the class you want to execute the run method from. The second parameter is a hash that contains most scalar values.


## Example of a task

    class SomeClass
      def initialize(data)
        @id = data[:id]
        @foo = data[:foo]
      end

      def run
        # add code to run
      end
    end


## Rake task to run as a cronjob
    rake udongo:queueu:process

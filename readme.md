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

[![Code Climate](https://codeclimate.com/repos/55225453e30ba0015300479e/badges/6cdc017255ce2cab1336/gpa.svg)](https://codeclimate.com/repos/55225453e30ba0015300479e/feed)

# Concerns
## Storable concern
If you want to make model storable, all you have to do is include the Storable concern. From then on you can add fields using the **storable_field** method.

storable_field takes 3 parameters.
* field name
* type
* default value (optional)

The possible types are:
* string
* integer
* date
* date_time
* boolean
* array

An example of how you could use this.

    class User < ActiveRecord::Base
      include Concerns::Storable

      storable_field :gender, :string, default: 'male'
      storable_field :age, :integer
      storable_field :last_login_at, :date_time
      storable_field :cool_dude, :boolean, default: true
      storable_field :locales, :array, default: %w(nl)
      storable_field :birthday, :date
    end

If you don't set a default, the following defaults apply for each type:
* string => nil
* integer => nil
* date => nil
* date_time => nil
* boolean => false
* array => nil

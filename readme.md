[![Code Climate](https://codeclimate.com/github/udongo/udongo/badges/gpa.svg)](https://codeclimate.com/github/udongo/udongo)

# Concerns
## Storable concern
### Possible field types
* String
* Integer
* Date
* DateTime
* Boolean
* Array
* Float

### Setup
```ruby
class User < ActiveRecord::Base
  include Concerns::Storable

  storable_field :gender, String, 'male'
  storable_field :age, Integer
  storable_field :last_login_at, DateTime
  storable_field :cool_dude, Boolean, true
  storable_field :locales, Array, %w(nl)
  storable_field :birthday, Date
end
```

### Reading values
```ruby
u = User.first
u.gender

# Which is equal to
u.store(:default).gender
```

### Writing values
```ruby
u = User.first
u.gender = 'female'
```

Which is equal to

```ruby
u.store(:default).gender = 'female'
```

### Saving values
```ruby
u = User.first
u.gender = 'female'
u.save

u.store(:custom).gender = 'unknown'
u.store(:custom).save
```

When you save the parent object (user), all the store collections will
automatically be saved.


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

      def run!
        # add code to run
      end
    end

## Rake task to run as a cronjob
    rake udongo:queue:process

# Validators
## E-mail validator
    validates :email, email: true

## URL validator
    validates :url, url: true


# Cryptography
```Udongo::Cryptography``` is a module you can include in any class to provide you with functionality to encrypt and decrypt values. It is a wrapper that currently uses ```ActiveSupport::MessageEncryptor```, which in turns uses the Rails secret key to encrypt keys.

By default, it is included in ```BackendController```.

## Configuration
Include the Udongo::Cryptography module in the class where you wish to encrypt/decrypt:
```ruby
def YourClass
  include Udongo::Cryptography
end
```

## Syntax
### encrypt
    crypt.encrypt('foo')
    => "azZiS1lPVU8zV1ljOTdjM2tIM2hTdz09LS1PODc5OEprRmxlMFVMU1lqaDdXK25RPT0=--77983f6f21e31117ac15011fed52dac3fdf776a8"
    crypt.encrypt('foo')
    => "bEFwVHVDV1hVc29UUmhJK1RQcllYUT09LS03WkZVYTdkOVhIQnloa1czUkE3L1V3PT0=--3fcc73bd6c11874966bb23811ad48980a44e40e7"

### decrypt
    crypt.decrypt('azZiS1lPVU8zV1ljOTdjM2tIM2hTdz09LS1PODc5OEprRmxlMFVMU1lqaDdXK25RPT0=--77983f6f21e31117ac15011fed52dac3fdf776a8')
    => "foo"
    crypt.decrypt('bEFwVHVDV1hVc29UUmhJK1RQcllYUT09LS03WkZVYTdkOVhIQnloa1czUkE3L1V3PT0=--3fcc73bd6c11874966bb23811ad48980a44e40e7')
    => "foo"

As the examples above illustrate, each subsequent encrypt always returns a different, decryptable hash.

### What if I don't want to use Rails.configuration.secret_key_base as the secret?
You can pass a different secret to ```crypt```:
```ruby
def Example
  def foo
    crypt('1234567890123456789012345678901234567890').encrypt('foo')
  end
end
```

You can also roll your own Udongo::Cryptography module, for example in Rails 3.2 the secret token is named differently:
```ruby
# lib/udongo/cryptography.rb
def Udongo::Cryptography
  def crypt
    @crypt ||= Udongo::Crypt.new(secret: Rails.configuration.secret_token)
  end
end
```

    crypt = Udongo::Crypt.new(secret: '1234567890123456789012345678901234567890')
    => #<Udongo::Crypt:0x007fcb1a0f3b50 @options={:secret=>"1234567890123456789012345678901234567890"}>
    crypt.encrypt('foo')
    => "YXhsZDV4RlZLTnljclhvM3pKbmV3Zz09LS1ycVR4bEtZemh2UUVKVlBQRnhlcjZRPT0=--f23e37ef7fb94e94cfa8a509f93bdb94e4bc5552"

# Datepickers
There are two custom inputs in Udongo to help handles dates. ```DatePickerInput``` and ```DateRangePickerInput```. Both make use of the [bootstrap-datepicker](http://bootstrap-datepicker.readthedocs.io/en/stable/) JS plugin. You can set/override its defaults through data-attributes, as explained in the docs.

## Usage
### DatePickerInput
Applying ```as: :date_picker``` to a simple_form input will bind a datepicker with all the default events bound:
```erb
<%= f.input :date, as: :date_picker %>
```
### DateRangePickerInput
You can combine two datepicker input fields into a range picker by applying ```as: :date_range_picker``` to 2 different simple_form input fields.

This will link a datepicker to each input with its relevant change listeners bound to prevent you from selecting a start date past the stop date, and vice versa:
```erb
<%= f.input :start_date, as: :date_range_picker, start: 'foo' %>
<%= f.input :stop_date, as: :date_range_picker, stop: 'foo' %>
```
The value used in the ```start``` and ```stop``` attributes needs to be the same for two datepicker fields to be combined into a range picker. **If these values don't match, your pickers won't display the intended behaviour.**

# Notifications
The ```Udongo::Notification``` class provides a generic way to parse action notices without directly interacting with ```I18n```. Its ```translate``` method can be used in a number of ways:

## Without parameters
```yaml
nl:
  b:
    msg:
      refreshed: De pagina werd opnieuw ingeladen.
```
```ruby
irb(main):001:0> Udongo::Notification.new(:refreshed).translate
=> "De pagina werd opnieuw ingeladen."
```

## A string as parameter
```yaml
nl:
  b:
    admin: Beheerder
    msg:
      added: '%{actor} werd toegevoegd.'
```
```ruby
irb(main):001:0> Udongo::Notification.new(:added).translate(:admin)
=> "Beheerder werd toegevoegd."
```

## Parameter hash
```yaml
nl:
  b:
    msg:
      added: '%{name} werd toegevoegd met %{pies} taarten.'
```
```ruby
irb(main):001:0> Udongo::Notification.new(:added).translate(name: 'Dave', pies: 10)
=> "Dave werd toegevoegd met 10 taarten."
```

## Notifications in controllers
```BackendController#translate_notice``` uses ```Udongo::Notification``` to output translated notices. Typically this is used in tandem with redirects. For example in the admins module:

```ruby
class Backend::AdminsController < BackendController
  def create
    redirect_to backend_admins_path, notice: translate_notice(:added, :admin)
  end
end
```


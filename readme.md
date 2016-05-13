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
```irb
irb(main):007:0> crypt.encrypt('foo')
=> "azZiS1lPVU8zV1ljOTdjM2tIM2hTdz09LS1PODc5OEprRmxlMFVMU1lqaDdXK25RPT0=--77983f6f21e31117ac15011fed52dac3fdf776a8"
irb(main):007:0> crypt.encrypt('foo')
=> "bEFwVHVDV1hVc29UUmhJK1RQcllYUT09LS03WkZVYTdkOVhIQnloa1czUkE3L1V3PT0=--3fcc73bd6c11874966bb23811ad48980a44e40e7"
```

### decrypt
```irb
irb(main):007:0> crypt.decrypt('azZiS1lPVU8zV1ljOTdjM2tIM2hTdz09LS1PODc5OEprRmxlMFVMU1lqaDdXK25RPT0=--77983f6f21e31117ac15011fed52dac3fdf776a8')
=> "foo"
irb(main):007:0> crypt.decrypt('bEFwVHVDV1hVc29UUmhJK1RQcllYUT09LS03WkZVYTdkOVhIQnloa1czUkE3L1V3PT0=--3fcc73bd6c11874966bb23811ad48980a44e40e7')
=> "foo"
```

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
```irb
irb(main):023:0> crypt = Udongo::Crypt.new(secret: '1234567890123456789012345678901234567890')
=> #<Udongo::Crypt:0x007fcb1a0f3b50 @options={:secret=>"1234567890123456789012345678901234567890"}>
irb(main):024:0> crypt.encrypt('foo')
=> "YXhsZDV4RlZLTnljclhvM3pKbmV3Zz09LS1ycVR4bEtZemh2UUVKVlBQRnhlcjZRPT0=--f23e37ef7fb94e94cfa8a509f93bdb94e4bc5552"
```

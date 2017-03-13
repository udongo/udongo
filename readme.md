[![Code Climate](https://codeclimate.com/github/udongo/udongo/badges/gpa.svg)](https://codeclimate.com/github/udongo/udongo)
[![CircleCI](https://circleci.com/gh/udongo/udongo/tree/master.svg?style=svg)](https://circleci.com/gh/udongo/udongo/tree/master)

# Configuration settings
Every configuration setting has been moved in groups within separate classes.
The syntax is always ```Udongo.config.[namespace].[setting]```

## Base
### host 
```ruby
Udongo.config.base.host = 'udongo.dev'
```

### project_name
```ruby
Udongo.config.base.project_name = 'Udongo'
```

### time_zone
```ruby
Udongo.config.base.time_zone = 'Brussels'
```

## Tags
### allow_new
```ruby
Udongo.config.tags.allow_new = false
```

## I18n
### app
#### default_locale
```ruby
Udongo.config.i18n.app.default_locale = :nl
```

### locales
```ruby
Udongo.config.i18n.app.locales = %w(nl)
```

### cms
#### default_interface_locale
```ruby
Udongo.config.i18n.app.default_interface_locale = 'nl'
```

#### interface_locales
```ruby
Udongo.config.i18n.app.interface_locales = %w(nl en)
```

## Forms
### Dirty inputs
Sometimes a user enters some data in a form and assumes that everything is
magically saved without submitting said form.

To warn a user that this is not default behaviour, you can trigger a warning
to show up whenever a user has changed input contents and clicks on any
```<a>``` element on the page.

Simply call the following helper method within your form tags:

```erb
<%= simple_form_for([:backend, @your_model]) do |f| %>
	<%= trigger_dirty_inputs_warning %>
  ...
<% end %>
```

This renders the following HTML:

```html
<form class="simple_form" id="edit_your_model_1" action="/backend/your_models/1/edit" accept-charset="UTF-8" method="post">
  ...
  <span data-dirty="true"></span>
  ...
</form>
```

## Flexible content
### types
```ruby
Udongo.config.flexible_content.types = %w(text image)
```

### allowed_breakpoints
```ruby
Udongo.config.flexible_content.allowed_breakpoints = %w(xs sm md lg xl)
```

## Assets
### image_white_list
```ruby
Udongo.config.image_white_list = %w(gif jpeg jpg png)
```

### file_white_list
```ruby
Udongo.config.file_white_list = %w(doc docx pdf txt xls xlsx)
```

## Articles
### allow_html_in_title
```ruby
Udongo.config.articles.allow_html_in_title = false
```

### allow_html_in_summary
```ruby
Udongo.config.articles.allow_html_in_summary = false
```

### editor_for_summary
```ruby
Udongo.config.articles.editor_for_summary = false
```

### images
```ruby
Udongo.config.articles.images = true
```

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

```ruby
class User < ApplicationRecord
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

# Which is equal to
u.store(:default).gender = 'female'
```

### Saving values
```ruby
u = User.first
u.gender = 'female'
u.save

u.store(:custom).gender = 'unknown'
u.save
```

When you save the parent object (user), all the store collections will automatically be saved.

## Translatable concern
This concern is actually the storable concern with some predefined settings. In order to use this concern your model needs to have a database text field named ```locales```.

```ruby
class Document < ApplicationRecord
  include Concerns::Translatable
  
  # One field
  translatable_field :name
 
  # Multiple fields
  translatable_fields :description, :summary 
end
```

## Searchable concern
Include this in your model if you want its records to appear in search autocompletes.

```ruby
class Document < ApplicationRecord
  include Concerns::Searchable

  # One field
  searchable_field :title

  # Multiple fields
  searchable_fields :title, :description, :summary
end
```

### Reading values
When reading values the current ```I18n.locale``` is used. If you want to specify the locale, you need to use the longer syntax.

```ruby
d = Document.first
d.name

# Which is equal to
d.translation(:nl).name
```

### Writing values
```ruby
d = Document.first
d.name = 'foo'

# Which is equal to
d.translation(:nl).name = 'foo'
```

### Saving values
Make sure to always call the ```#save``` method on your model. You can call the one on the translation, but this will not trigger an update for the ```locales``` field.
```ruby
d = Document.first
d.name = 'foo'
d.save

d.translation(:nl).foo
d.save
```

When you save the parent object (document), all the translations will automatically be saved.

### .by_locale scope
This concern adds a scope to your model which makes it easy to fetch the models that have translations within a certain locale.

```ruby
documents = Document.by_locale(:nl)
```

## Addressable concern
This concern makes it easy to have multiple addresses with a category linked to a model.

```ruby
class User < ApplicationRecord
  include Concerns::Addressable
  configure_address %w(personal billing), default: 'personal'
end
```

If you don't provide a default, we will use the first one in the list.

### Usage
If you request an address that's not initialized this will be done for you. So calling ```#address```, with or without category, will always return an address model.

```ruby
u = User.first
u.address

# Which is equal to
u.address(:personal)
```

# Queue
## Add tasks to the queue
You can add tasks to the queue by executing:

```ruby
QueuedTask.queue('SomeClass', id: 37, foo: bar)
```

The first paramter specifiecs the string of the class you want to execute the run method from. The second parameter is a hash that contains most scalar values.

## Example of a task

```ruby
class SomeClass
  def initialize(data)
    @id = data[:id]
    @foo = data[:foo]
  end

  def run!
    # add code to run
  end
end
```

## Rake task to run as a cronjob
```ruby
rake udongo:queue:process
```

# Validators
## E-mail validator
```ruby
validates :email, email: true
```

## URL validator
```ruby
validates :url, url: true
```

# Search engine
4.0 introduced a rough structure to build a search autocomplete upon through ```Concerns::Searchable```. 

## How does it work?
Included in Udongo by default is the backend search, which makes Page records accessible through an autocomplete. In order to build search support for a model, we have to make it include the concern:

```ruby
# app/models/page.rb
class Page
  include Concerns::Searchable
  searchable_fields :title, :subtitle, :flexible_content
end
```

```Concerns::Searchable``` saves ```SearchIndex``` records to our database whenever a model gets saved. Support for both ```Concern::Translatable``` and ```Concern::FlexibleContent``` is built in, meaning that translatable fields can also be searchable fields.

By including ```:flexible_content``` as a searchable field, we flag it to build search indices for all flexible content of the ```ContentText``` type.

```Backend::SearchController#index``` contains a call to ```Udongo::Search::Backend```. That class is responsible for matching a search term against the available search indices:

```ruby
# app/controllers/backend/search_controller.rb
class Backend::SearchController < Backend::BaseController
  def query
    @results = Udongo::Search::Backend.new(params[:term], controller: self).search
    render json: @results
  end
end
```

```Udongo::Search::Backend#search``` in turn translates those indices in a format that jQueryUI's autocomplete understands: ```{ label: 'foo', value: 'bar' }```.
```ruby
# lib/udongo/search/backend.rb
module Udongo::Search
  class Backend < Udongo::Search::Base
    def search
      indices.map do |index|
        result = result_object(index)
        { label: result.build_html, value: result.url }
      end
    end
  end
end
```

By default the ```#result_object``` is an instance of ```Udongo::Search::ResultObjects::Base```. You can define your own result object class, which in this example is done for the ```Page``` model:
```ruby
# lib/udongo/search/result_objects/page.rb
module Udongo::Search::ResultObjects
  class Page < Udongo::Search::ResultObjects::Base
    def url
      if namespace == :backend
        controller.edit_backend_page_path(index.searchable)
      end
    end
  end
end
````
This gives devs a way to extend the data for use in jQueryUI's autocomplete, or simply to mutate the index data. In the example above, we check what namespace we reside in in order to generate an edit link to the relevant page in the pages module. If one were to build a search for the frontend that includes pages, you could build the required URL for it here.

### HTML labels in autocomplete
Support for HTML labels is automatically included through ```vendor/assets/javascripts/jquery-ui.autocomplete.html.js`. The labels should reside in partial files and be rendered with ```Udongo::Search::ResultObjects::Base#build_html```. This provide support for funkier autocomplete result structures:

```erb
<!-- app/views/backend/search/_page.html.erb -->
<%= t('b.page') %> — <%= page.title %><br />
<small>
  <%= truncate(page.description, length: 40) %>
</small>
```

# Cryptography
```Udongo::Cryptography``` is a module you can include in any class to provide you with functionality to encrypt and decrypt values. It is a wrapper that currently uses ```ActiveSupport::MessageEncryptor```, which in turns uses the Rails secret key to encrypt keys.

By default, it is included in ```Backend::BaseController```.

## Configuration
Include the Udongo::Cryptography module in the class where you wish to encrypt/decrypt:
```ruby
def YourClass
  include Udongo::Cryptography
end
```

## Syntax
### encrypt
```ruby
crypt.encrypt('foo')
=> "azZiS1lPVU8zV1ljOTdjM2tIM2hTdz09LS1PODc5OEprRmxlMFVMU1lqaDdXK25RPT0=--77983f6f21e31117ac15011fed52dac3fdf776a8"
crypt.encrypt('foo')
=> "bEFwVHVDV1hVc29UUmhJK1RQcllYUT09LS03WkZVYTdkOVhIQnloa1czUkE3L1V3PT0=--3fcc73bd6c11874966bb23811ad48980a44e40e7"
```

### decrypt
```ruby
crypt.decrypt('azZiS1lPVU8zV1ljOTdjM2tIM2hTdz09LS1PODc5OEprRmxlMFVMU1lqaDdXK25RPT0=--77983f6f21e31117ac15011fed52dac3fdf776a8')
=> "foo"
crypt.decrypt('bEFwVHVDV1hVc29UUmhJK1RQcllYUT09LS03WkZVYTdkOVhIQnloa1czUkE3L1V3PT0=--3fcc73bd6c11874966bb23811ad48980a44e40e7')
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

```ruby
crypt = Udongo::Crypt.new(secret: '1234567890123456789012345678901234567890')
=> #<Udongo::Crypt:0x007fcb1a0f3b50 @options={:secret=>"1234567890123456789012345678901234567890"}>
crypt.encrypt('foo')
=> "YXhsZDV4RlZLTnljclhvM3pKbmV3Zz09LS1ycVR4bEtZemh2UUVKVlBQRnhlcjZRPT0=--f23e37ef7fb94e94cfa8a509f93bdb94e4bc5552"
```

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

```
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
```Backend::BaseController#translate_notice``` uses ```Udongo::Notification``` to output translated notices. Typically this is used in tandem with redirects. For example in the admins module:

```ruby
class Backend::AdminsController < Backend::BaseController
  def create
    redirect_to backend_admins_path, notice: translate_notice(:added, :admin)
  end
end
```

# Javascript libs
## Select2
This library is loaded by default in the backend.
See https://select2.github.io

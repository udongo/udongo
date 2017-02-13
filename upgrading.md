# Upgrade guide
## From 5.0.0 to 5.0.1
No backwards incompatible changes.

## From 4.0.0 to 5.0.0
# User model
We added a ```User``` model. If your application used to have one, make sure to
use the Udongo one and migrate your data accordingly.


## From 3.0.0 to 4.0.0
No backwards incompatible changes.

## From 2.0.4 to 3.0.0
### Forms
Everything related to the form models has been deleted. So if you use any of 
these classes, you're in for a rough ride.
* Form
* FormDecorator
* FormField
* FormFieldValidation
* FormSubmission
* FormSubmissionData
* FormSubmissionDecorator

### Configuration
You can now choose which breakpoints you want to show in the interface when 
editing flexible content. See the docs.

### BackendController renamed to Backend::BaseController
You need to change each occurence of ```BackendController``` with ```Backend::Basecontroller```

### Spec support/factories
You can now again require spec/support and spec/factories in your specs. This
way you can easily test shared examples eg for translatable.

### I18n configuration
Change every instance of ```Udongo.config.i18n.locales``` with
```Udongo.config.i18n.app.locales``` and ```Udongo.config.i18n.default_locale```
with ```Udongo.config.i18n.app.default_locale```

### Backend default_locale helper renamed
In the backend you used to have a helper ```default_locale```. You need to 
rename each occurence to ```default_app_locale```

### Removed the setting `prefix_with_locale`
Make sure to remove this setting from your Udongo config.
```Udongo.config.routes.prefix_with_locale = true```

### Webserver restart
The button to manually restart the webserver has been removed. If you want to
keep this behaviour, below is the old code.

```ruby
class Backend::WebserverController < Backend::BaseController
  def restart
    `touch tmp/restart.txt`
    redirect_to backend_path, notice: t('b.msg.webserver.restarted')
  end
end
```


### Backend::TranslationForm
This form object was added and can be used to simplify your existing translation
forms (except for those that use SEO). To stay up-to-date, you should check your
translation form objects and if they can benefit from this new class.


## From 2.0.1 to 2.0.4
No actions required.


## From 2.0.0 to 2.0.1
* Reform gem is no longer used. Make sure to add this gem to your gemfile if you
wish to continue using this.


## From 1.0.4 to 2.0.0
### Configuration
Configuration options have been placed in subclasses that are autoloaded. Consult
the documentation about which settings there are.

### Translations
A new nl/en_general.yml file was added which will hold all translations that may
be used both in the frontend and backend.

# Upgrade guide
## from 2.0.4 to 3.0.0
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

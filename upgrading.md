# Upgrade guide
## From 6.4.1 to 6.5
### Flexible content
There's a new setting ```no_gutters``` added to content rows. If enabled the
```no-gutters``` class is added to the row. Make sure your row classes in the
frontend are set by using the ```ContentRowDecorator#classes``` method. If so,
no need to do anything.

Video's now can also have a caption. By default this caption has no editor, but
you can enable this with the following setting
```Udongo.config.flexible_content.video_caption_editor = true```


## From 6.3 to 6.4
### Flexible content
When you have created your own flexible content types, you need to update the
```edit.html.erb``` file. There you have to change this
```ruby
render 'backend/form_actions', cancel_url: cancel_url
```

to this
```ruby
render 'backend/form_actions', cancel_url: '#lity-close'
```

You've probably also added translations to ```nl_backend.yml``` for edit_[type].
These may be removed, because they're no longer used. They can be found in the
'nl.b.msg.flexible_content' namespace.

It's now also possible to add margin/padding top/bottom and a background color
to content rows. If your project has a whitespace widget, it can be removed by
using these settings.


### ImageCollection
A new module 'image collections' has been added. You need to add this to your
top_navigation.html.erb if you've overwritten the udongo one.


## From 6.2.1 to 6.3
### Tags module
A new module was added that allows you see which tags are currently in the
system. You can also add/edit/delete tags and see if they're being used.

A bug was fixed for the relation between an object and its tagged items. This
is now dependent: destroy. If your project uses tags, check to see if the
tagged_items table doesn't contain links to objects that no longer exist.

### Assets module
You can now see which models an asset is linked to. Because of a missing
dependent: destroy, some imageable_types still remain. Check the Image model and
spot non existing linked models.

## From 6.2.0 to 6.2.1
### Formbuilder
You can now use the ```tel``` and ```email``` type for form fields.

## From 6.1.0 to 6.2.0
### CollectionHelper
You can now easily create collections to be used with SimpleForm by using
```options_for_collection``` and placing your translations in ```[locale]_general.yml```
If you've created this function yourself, use the Udongo one instead.

### Form widget
A new form widget has been added. Don't forget to add ```form``` to the list of
widgets in case you override them in your project config.

## From 6.0.0 to 6.1.0
### Pages
A new setting ```sitemap``` has been added to ```Page```. If you've manually
constructed your sitemap, it might be a good idea to incorporate this setting.

### Person#short_name
A new method #short_name was added to the ```Person``` concern.
```Davy Hellemans``` becomes ```Davy H.``` when you use it.

### Flexible content
You can now determine whether or not the picture caption uses an editor. This 
setting ```Udongo.config.flexible_content.picture_caption_editor``` is false by
default. When using this, don't forgot to update your ```_picture.html.erb``` in
the frontend of your application.

## From 5.9.0 to 6.0.0
### Flexible content
There no longer are allowed/disallowed breakpoints.
The setting ```Udongo.config.flexible_content.allowed_breakpoints``` has been
removed.

Since you can now define the width and the alignment options for each row, you
will need to adjust the frontend rendering to actually use these features.

### Youtube / vimeo content widget
A new widget was added to easily insert a youtube/vimeo video by providing the
full URL to the video. If you want to enable this widget you need to make sure
it's enabled in the list of flexible content types.

### Bootstrap alpha v4 to v6
We're now using the latest bootstrap alpha v6. Because of some changes you will
need to check your _top_navigation.html.erb file.

## From 5.8.0 to 5.9.0
### LinkHelper
The link helper methods have been refined so they can work with a string or an
object. This means you can use link_to_show/edit/delete in these two ways.

```ruby
link_to_show [:backend, object]
link_to_show some_custom_path(object)
```

Another method that has been added is ```link_to_edit_translations(object, default_locale)```.
This can only be used with an object and uses the default app locale.

```ruby
link_to_edit_translation [:backend, object]
link_to_edit_translation [:backend, object], :fr
```

## From 5.7.0 to 5.8.0
### Flexible content
The ```ContentImage``` model has been deprecated. Use ```ContentPicture```
instead. In version 6.0 we will remove the deprecated widget.

## From 5.6.0 to 5.7.0
### NavigationHelper
A new module has been added to make it easier to fetch navigations. You can now
use do something like ```navigation(:footer).items```

## From 5.5.0 to 5.6.0
### Translations
The general translations no longer exists. If you use something like this
```I18n.t 'g.save'``` in your views, replace that with your own translations.

## From 5.4.0 to 5.5.0
No actions required.

## From 5.3.0 to 5.4.0
### Articles
The ```Udongo.config.articles.images``` setting now defaults to true instead of
false.

## From 5.2.0 to 5.3.0
### Articles
A new ```Article``` model has been added. If you already have that in your project,
you need to delete it and use the Udongo one.

## From 5.1.0 to 5.2.0
This release adds the ```Asset``` and ```Image``` model. If you have one of 
those in your project, you need to delete them and use the ones Udongo provides.

A new config object ```Udongo.config.assets``` has been added. Here you can set
which image/file extensions are allowed.
The following images are allowed by default: gif, jpeg, jpg and png.
The following files are allowed by default: doc, docx, pdf, txt, xls and xlsx.

## From 5.0.1 to 5.1.0
### Users
A user now has an 'active' (boolean) field. If you already have that, you need
to remove it and let it be added by the Udongo migrations after which you
migrate your data.

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

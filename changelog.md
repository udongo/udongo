7.1.0 - 2017-10-19
--
* make the SEO title and description mandatory for Backend::TranslationWithSeoForm


7.0.4 - 2017-10-05
--
* Bugfix: make sure the tag autocomplete is locale specific.


7.0.3 - 2017-10-03
--
* Bugfix: the list of seo_locales now only contains locales that actually have
  a slug.
* Bugfix: the list of locales now only contains locales that actually have some
  sort of translation value.


7.0.2 - 2017-09-21
--
* Fix issue with the locale duplication class not being found.


7.0.1 - 2017-09-21
--
* Removed some unused translations.
* The backend/seo_form partial now accepts a hard slug value so prefills are
  possible on other locations.
* Cleanup the #flexible_content? check to be an instance method instead of a
  class method.
* Make sure the SEO concern saves when you save its parent object.
* You can import the flexible content from another locale.


7.0.0 - 2017-07-28
--
* It's now possible to use the scope .with_seo(:nl) to fetch models that actually
  have a slug in that locale. You used to have to do some nasty manual things to
  work around this issue, but no more!
* After being deprecated for some time, ```ContentImage``` has finally been
  removed from the system.


6.6.3 - 2017-07-27
--
* Bugfix: the cacheable concern #find_in_cache method has been tweaked to make
  sure there are no rare instances where dev cache is used in test.


6.6.2 - 2017-07-25
--
* Bugfix: using models with multiple words like 'LandingPage' no longer break
  the flexible content.
* Ehancement: show the newest form submissions on top in the backend.


6.6.1 - 2017-07-04
--
* Enhancement: show the submission date in the overview of form submissions.


6.6.0 - 2017-07-04
--
* When enabled, you can add images to pages from the assets module.


6.5.2 - 2016-06-26
--
* Bugfix: remove frontend/forms.js include in flexible content.


6.5.1 - 2017-06-26
--
* Bugfix: don't assume #searchable? is a method that exists on every model.


6.5.0 - 2017-06-25
--
* It's now possible to disable the flexible content row gutters.
* Video's can now have a caption. You can configure whether or not this caption
  uses an editor.
* For each flexible content type, we now provide a placeholder as default. In
  most cases this will be ok. If you want something different, you can simply
  override this partial. We don't provide a default for 'image' because that's
  actually discontinued and you should stop using that.


6.4.1 - 2017-06-16
--
* Make it easier to fetch all the content row styles as a hash.


6.4.0 - 2017-06-16
--
* Add the ImageCollection model with a module. This allows you to put certain
  assets in one or more collections. These can then be used in the future to
  create slideshows, photo albums and even file lists.
* Bugfix: reworked to Udongo::Search::Frontend visible/publishable check tests
  to help fix a test that failed Sometimes™.
* Flexible content rows can now have a background color and padding/margin for
  the bottom/top.
* All flexible content actions are now shown in popups.
* Add field 'external_reference' to form fields.


6.3.2 - 2017-06-07
--
* Bugfix: there was an issue with the has_many :addresses relation in the
  addressable concern.


6.3.1 - 2017-06-06
--
* Removes the Udongo::Search::ResultObjects::Frontend::Page class so projects
  building Frontend search have an easier time doing so.


6.3.0 - 2017-06-05
--
* The tagbox autocomplete now orders its results alphabetically.
* A general tag module was added. This allows you to see which tags have been
  used throughout the system and add new ones.
* Bugfix: when a taggable item is deleted, it's tagged items are now destroyed.
* When checking the overview of files, you can now see if those assets are used.
* Bugfix: the images relation was not dependent destroy.


6.2.1 - 2017-06-04
--
* Added email and tel as valid form types for FormField.


6.2.0 - 2017-06-02
--
* Removed the bootstrap source mapping reference in backend/bootstrap.scss.
* Upgraded jquery-ui-rails to 6.0.1 to fix autocomplete issues with jquery3.
* Add the ```CollectionHelper``` which allows you to use ```options_for_collection```
  to easily create collections for simple form.
* The form field types are now a dropdown instead of a text field.
* A form widget has been added. This makes it possible to include a form on a
  specific location in the flexible content.


6.1.0 - 2017-05-16
--
* The obsolete top navigation markup has been cleaned up.
* Add setting 'sitemap' to pages. These can be used to easily see which pages
  are to be included in the sitemap.
* Rename Concerns::Addressable#configure_adress to configure_address
* Add method Person#short_name which uses the first name and first letter of the
  last name.
* A new setting ```Udongo.config.flexible_content.picture_caption_editor``` was
  added. This allows you to use an editor for picture captions.
* Tweaked some bottom margins related to the media module.
* Linking an image via de media module now only suggests 30 pictures.


6.0.0 - 2017-05-08
--
* When adding/editing flexible content columns, you now only see the medium
  breakpoint by default.
* Upgrade bootstrap v4 from alpha 4 to alpha 6.
* The last item in the list of breadcrumbs will never be a link.
* Flexible content now allows you to align columns within a row vertically or
  horizontally. You can also define a row to be full width instead of the
  default container.
* A new widget has been added to easily insert youtube/vimeo video's.


5.9.0 - 2017-05-04
--
* Fixes issue in pages module that prevented you from clicking the context
  menu items.
* Make the link_to_show/edit/delete methods a bit more flexible.
* Clicking the snippet edit link now goes directly to the default app locale.


5.8.0 - 2017-04-12
--
* Add missing ```author``` key to form translations.
* The ContentImage/Text decorators have been simplified.
* Fixed bug where you couldn't include ```Concerns::Searchable``` on models
  without flexible content without getting an unknown method error.
* The column widths for flexible content are displayed in percentages.
* An extra widget ```ContentPicture``` has been added. This is the replacement
  for the ```ContentImage``` which has now been deprecated.


5.7.0 - 2017-03-22
--
* The ```Navigation``` model now includes the cacheable concern.
* A ```NavigationHelper``` module was added which makes it easier to fetch a
  navigation by identifier.
* You can now include ```Concerns::Searchable``` on models without flexible
  content and not receive errors as a result.
* You can now toggle Bootstrap tooltips through data-toggle="tooltip" and 
  specifying a value in the title field.
* Added a backend module to create and manage forms.


5.6.0 - 2017-03-18
--
* The article title is truncated to 40 chars in the overview and breadcrumbs.
* Add the PageHelper which contains ```#page(identifier)``` to easily fetch a
  page from cache.
* The files nl_backend.yml and en_backend.yml have been synced.
* The files nl_general.yml and en_general.yml have been removed.
* Update the font-awesome icons from 4.6.1 to 4.7.0.
* You can now disable the snippet title/content so it won't show up in the
  translation edit form (which sometimes confused people).
* Added PageDecorator#url because the ```only_path: false``` option seems to be
  borked at this moment.


5.5.0 - 2017-03-13
--
* When an SEO form has a slug, it's automatically calculated based on the title.
* Trigger a generic warning when trying to leave a page through an anchor when
  the form contains unsaved changes.
* The dirty-inputs warning is now triggered on a form by calling the
  ```trigger_dirty_inputs_warning``` helper method.
* The sluggable autofill now plays nice when immediately hitting enter after
  typing your title.
* Trigger a generic warning when trying to leave a page through an anchor when
  the form contains unsaved changes.
* The dirty-inputs warning is now triggered on a form by calling the
  ```trigger_dirty_inputs_warning``` helper method.


5.4.0 - 2017-03-08
--
* When enabled, you can add images to articles from the assets module.
* Bugfix: the sortable scope for the ```Image``` wasn't properly set.
* Images are now enabled by default for articles.
* Fixed a missing image reference triggered by Tagit.


5.3.1 - 2017-03-07
--
* Bugfix: there was an issue with loading the base module for the image
  manipulation.


5.3.0 - 2017-03-07
--
* Refactor the asset image resizer(s).
* Add a basic articles module.
* You can configure the article module with some settings. See the readme.


5.2.0 - 2017-03-02
--
* Add an assets module to manage all kinds of files.
* Backend now loads jQuery 3 by default.
* You can now mark a model as 'Imageable', which makes it possible to link one
  or more images (assets) to it. These assets can be reused for other modules
  as well.


5.1.0 - 2017-02-15
--
* The users module now orders by last/first name.
* The default number of items per page is now 10 instead of 30.
* A user now has an active/inactive state that you can manage.
* You can now filter users by their first name, last name and email address.
* Next to the ```Backend::TranslationForm``` we now added the ```Backend::TranslationWithSeoForm```
  which makes those forms great again.
* Add fix for a collection of checkboxes rendered by SimpleForm to show on
  multiple lines.
* Set a max width for the cell containing the sortable handle.


5.0.2 - 2017-02-13
--
* Fix bug in the SEO form of b/pages#edit_translation that prevented you from
  saving SEO data.


5.0.1 - 2017-02-13
--
* Make sure the search field in the top navigation doesn't steal the focus.
* Add missing class for vertical file inputs for Simple Form.
* Remove the search partial file checks.


5.0.0 - 2017-02-12
--
* Added a general ```User``` model which you can extend in your own app.


4.0.0 - 2017-02-12
--
* Added Concerns::Searchable. This lets model instances automatically save 
  SearchIndex records to the database as they are changed.
* Added functionality to Concerns::FlexibleContent so it can play nice with
  Concerns::Searchable.
* Added a search input to the backend's top navigation bar. Autocompleted search
  works through Udongo::Search::Backend.
* Provided a raw infrastructure to allow for Udongo::Search::Frontend or other
  namespaced search classes.


3.0.0 - 2017-01-13
--
* Because of the complex structure and no actual necessity, the form models and
  their related code have been cut.
* You can now set the list of breakpoints you want to have visible for the 
  flexible content. In most cases the xs and xl don't need to clutter the 
  interface, so now you can hide them.
* Added specs for all routes.
* Add concern to easily use multiple addresses for a single model.
* The BackendController has been renamed and moved to Backend::BaseController.
* Update Bootstrap to v4.0.0-alpha.4
* Tweak the styles for the simple form initializer.
* Pages marked as invisible are now visibly distinguished from visible pages. Fixes #9
* Add spec/support and spec/factories to the gem.
* The i18n configuration has been split in 'app' and 'cms'. You can now
  configure the cms interface locale(s) indepent of the app locale(s).
* An admin can now choose his interface locale.
* Add cc/bcc to the email templates and sent emails.
* The general mailer has been expanded so it's easier to override the headers.
* Added new contextmenu options for making pages (in)visible through the tree.
* Add (and load) the select2 js lib in the backend.
* After adding or editing content in a certain locale, redirect to the correct
  locale.
* The dashboard template no longer contains dashboard#show.
* You can now add your custom css to app/assets/stylesheets/backend/custom.scss
* When a backend form has 1 or more errors, you will now see a general error.
* The `prefix_with_locale` setting has been removed because it's always true.
* The webserver restart button/action has been removed.
* The following form objects have been removed in favor of the model:
  - EmailTemplateForm
  - NavigationItemForm
  - PageForm
  - SnippetForm
* A `Backend::TranslationForm` has been added. This makes it a whole lot easier
  to create translation forms for your models.
* Feature tests have been added for most of the basic functionality.


2.0.4 - 2016-08-15
--
* Fix issue with resizing pictures in the CKEditor picture uploader.


2.0.3 - 2016-08-15
--
* Revert CKEditor from 4.2.0 to 4.1.6 because of breaking changes related to
  browsing attachments.


2.0.2 - 2016-08-15
--
* CKEditor has some breaking changes and apparently they didn't find it
  necessary to use the version numbers as intended.


2.0.1 - 2016-08-02
--
* Upgrade bootstrap v4 from alpha 2 to alpha 3.
* The reform gem is no longer used. We now use the Udongo form objects created
  with Virtus.


2.0.0 - 2016-07-29
--
* The system for setting config variables has changed. Every setting has moved
  into separate namespaced classes. See the docs configuration section
* Fix the form settings subclasses.
* Upgrade to rails 5.
* Add nl_general.
* Add the spec directory to the gem so you can use its factories and concerns.


1.0.4 - 2016-07-23
--
* Add spec for the SnippetForm class.
* Add Udongo::Notification and use it in BackendController#translate_notice.
* Fix issue with storable config fields that are present in the DB, but are no
  longer in the storable class.
* Flexible image preview no longer makes the URL previewable.
* Classes in lib/udongo/**/* are now loaded automatically.
* Restyled flexible content widget.
* You now get a suggested width when adding a new content column in the
  flexible content widget. Values are based on previously set column widths.
* The codebase had a lot of useless double semicolons, which have been removed.


1.0.3 - 2016-06-06
--
* Bugfix: fix link to non existing css file.


1.0.2 - 2016-06-06
--
* Bugfix: add the vendor directory to the list of gem files. This makes sure the
  assets in the vendor dir are loaded correctly.


1.0.1 - 2016-06-06
--
* Get rid of the rakismet and marked-rails gems, beacuse they're not being used.
* Move mysql2 to the development dependencies in the gemspec.
* Rename the minified bootstrap datepicker scss file to a css file.


1.0.0 - 2016-06-05
--
* Complete overhaul of the Storable concern. It's now internally using Virtus to
  handle reading/writing attributes. You can now also have storable fields
  within different categories.
* Translatable has been revamped to leverage the strenghts of the Storable
  concern.
* Add the English translation files.


0.1.0 - 2016-05-31
--
* Add LinkHelper to provide shorthands for show/edit/destroy links.
* Add DatePickerInput to be used with Simple Form inputs (as: :date_picker)
* Fix the sortable js to show the correct font-awesome icon.
* Let Udongo::EmailVarsParser#replace_vars handle unlimited nested collections
  as var values.
* Cleanup the layout of the following modules: email, email templates, flexible
  content.
* Make it possible to disable the first input field focus for an entire form by
  adding the 'no-focus' class to that form.
* Add Udongo::Cryptography to make encrypting/decrypting values secure and easy.
  See readme.md for more information.
* Make it possible to set the content column width for each responsive
  breakpoint.
* Add the email validator and cleanup the URL validator.
* Add DatePicker and DateRangerPicker to use with simple form.
* Order logs by created_at descending AND by ID descending.
* Fix nasty bug in the storable concern which made it impossible to work with
  the << operator for strings and arrays.
* Bugfix: the link helpers can now also work with decorated objects.


0.0.13 - 2016-05-02
--
* FormSubmission#data_object
* Adds support for Spring in engine development
* Expands Concerns::PaginationController with a method that handles both arrays
  and AR collections.
* Allow page_number/per_page overrides through an options hash for
  Concerns::PaginationController#paginate
* Add module for e-mail templates.
* Add some styles for unordered lists in tables.
* Add the Email model which holds all the sent/unsent e-mails.
* Add very basic module to show the items in the email table.
* Add Concerns::Emailable
* Expands FormSubmission to be emailable
* Use the project_name config var for the backend template title.
* Show the list of available email template vars.
* Make the Address model emailable.
* Switch plain/html content in the email template translation form.
* Don't make the meta slug required.
* Hide the search in the backend navigation for now.
* Tweak css for the search filter panels.
* Add QueuedTask.queue_unless_already_queued which speaks for itself.
* Add .icons class for the <td> which contains icons.
* Add 'data' field to Log which contains a an optional hash.
* Use the bootstrap/fontawesome css files instead of the gems.
* Upgrade the reform gem to v2.1.0


0.0.12 - 2016-01-22
--
* Bugfix: navigation item wasn't using the sortable scope.
* Bugfix: make sure content widgets can have camelcased model names.
* Order redirects based on the times they've been used.
* Add a catch all route with a basic controller that checks for 404's
* The tagbox no longer triggers tagged item creation errors.
* The cacheable concern now flushes the cache when the after_touch callback
  happens.
* Add the storable concern v2 which allows you to save arbitrary data in the db
  according to certain types (array, boolean, date, date_time, float, integer
  and string)
* Add generator to create a new form


0.0.11 - 2015-12-05
--
* Add 'external reference' to tags. This allows you to integrate tags from third
  party systems.
* Make it possible to disallow the creation of new tags.
* Don't limit the ckeditor locales to just nl, fr and en.
* Add MetaInfo class which can be used to hold the frontend meta info.
* Save more image formats for the ContentImage image.
* Added rake task to regenerate all the ContentImage files in all the versions.
* Make the list of flexible content types dynamic so you can write your own.
* Optimize the backend flexible content previews.
* You can now set the project name, which will be used in the backend navigation.
* Make the content rows/columns movable.


0.0.10 - 2015-11-12
--
* Stop using a sidebar for the navigation.
* Introduce the redirects module with support for short URLs /go/foo
* Snippet titles have changed from text to string type.
* Make sure find_in_cache lets you know when something hasn't been found.
* Order snippets by their description.
* Get rid of FrontendController since it's content is not relevant.
* Make it possible to disable the page content.
* Add setting 'prefix_routes_with_locale' which defaults to true.
* Make the navigation items positionable.
* Make find_in_cache aware of translatable models and caches all the fields in
  all the configured locales.
* Add functionality to restart the webserver.


0.0.9 - 2015-08-21
--
* Introduce the configurable caching concern.
* Update backend/sortable.js for Foundation
* Add missing Concerns::Backend::PositionableController
* Add udongo:sortable:generate_positions_for_model rake task


0.0.8 - 2015-08-17
--
* Revert the apparently not so elegant caching mechnism for translations.


0.0.7 - 2015-08-14
--
* Provide elegant caching mechanism for translations.


0.0.6 - 2015-08-03
--
* Filter out all (s)css to-precompiled-files beginning with an underscore.


0.0.5 - 2015-07-30
--
* Add will_paginate gem.
* Add custom will_paginate renderer for the backend using foundation.


0.0.4 - 2015-07-30
--
* Fix issue with precompiler not loading .scss files
* Fix issue with backend/seo.js pointing to the wrong help text span
* Fix <%= %> output calls used with javascript/stylesheet view helpers resulting
  in "true" in the templates
* Fix issue with simple_form_for#input not loading data attributes


0.0.3 - 2015-07-13
--
* Changelog added
* Fix wrong extension check to include the dot for Udongo::Assets::Precompiler


0.0.2 - 2015-07-09
--
* Added Udongo::Assets::Precompiler
* Added Udongo::Assets::Loader

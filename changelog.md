0.0.13 - xxxx-xx-xx
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

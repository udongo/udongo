0.0.10 - xxxx-xx-xx
--
* Stop using a sidebar for the navigation.
* Introduce the redirects module with support for short URLs /go/foo
* Snippet titles have changed from text to string type.
* Make sure find_in_cache lets you know when something hasn't been found.


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
easy listening
==============

Sitting on the couch listening to Frank's best songs - Sinatra web application with CouchDB backend

Usage
-----

Clone or fork this project

    git clone git://github.com/lennart/easy-listening.git

Edit the `Rakefile` task for `:setup` to match your needed environments, title of your app and the author (e.g. you)  
Run
    gem bundle
To get all needed gems for getting started
Setup all needed folders

    rake setup

When something is wonky, use
    rake reset
to remove all generated files like `config/environment.rb`


Add your application specific files in `app/`,   
tests in `spec/` and feature test (cucumber) in `features/`

There is also a simple irb-wrapper in `script/console` which takes an environment as the first argument (default development)

For duck-typed models I added a module you can include into your models to achieve truly ducktyped views and documents.

    class HelloWorld < CouchRest::ExtendedDocument
      use_database ::SiteConfig.database
      include DuckTypedDesignDoc
      ducktype_traits :message
      property :message
    end

This way CouchRest doesn't add the "couchrest-type" column to your Documents. The `ducktype_traits`-method defines the properties that are sufficient to qualify as a Document of this class.


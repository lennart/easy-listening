class HelloWorld < CouchRest::ExtendedDocument
  use_database ::SiteConfig.database
  include DuckTypedDesignDoc

  ducktype_traits :message
end

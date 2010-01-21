require 'couchrest/mixins/design_doc'
module DuckTypedDesignDoc 
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      def initialize(passed_keys = {}) 
        super
        self.delete("couchrest-type")
      end
    end
  end

  module ClassMethods 
    include CouchRest::Mixins::DesignDoc::ClassMethods

    def ducktype_traits(*traits)
      @traits = traits.map { |t| t.to_sym }
    end

    def ducktype_traits_js(other_traits = [])
      (other_traits + @traits).map {|t| "doc['#{t.to_s}']"}.join " && "
    end

    def view_by(*keys)
      opts = keys.pop if keys.last.is_a?(Hash)
      opts ||= {:ducktype => true}
      unless opts[:map]
        opts[:guards] ||= []
        opts[:guards].push "(#{ducktype_traits_js})"
      end
      keys.push opts
      self.design_doc.view_by(*keys)
      self.design_doc_fresh = false
    end


    def default_design_doc
      if @traits.respond_to? :map
        {
          "language" => "javascript",
          "views" => {
            'all' => {
              'map' => <<-MAP
function(doc) {
  if (#{ducktype_traits_js}) {
    emit(doc['_id'],1);
  }
}
              MAP
            }
          }
        }

      else
        raise RuntimeError.new(
          <<-CODE 
Please specify some Traits by which you can Ducktype these Documents.
Use e.g.: ducktype_traits :can_be_seen_at_night, :colour
          CODE
        )
      end
    end
  end
end

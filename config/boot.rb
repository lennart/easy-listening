unless Object.const_defined? :SINATRA_ROOT
  $LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), *%w{.. lib}))
  SINATRA_ROOT=::File.expand_path(::File.join(::File.dirname(__FILE__),"..")) 

  class String
    def blank?
      self.nil? || self.strip == ""
    end

    def camelize first_letter_in_uppercase = true
      if first_letter_in_uppercase
        self.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      else
        self.first.downcase + camelize(self)[1..-1]
      end
    end
  end

  class NilClass
    def blank?
      self.nil? || self == ""
    end
  end
  
  def sinatra(*path_components)
    ::File.join(SINATRA_ROOT,*path_components)
  end

  require File.expand_path(File.join(File.dirname(__FILE__),%w{.. vendor gems environment}))

  if ENV["RACK_ENV"]
    Bundler.require_env ENV["RACK_ENV"].to_sym
  else
    Bundler.require_env
  end
end

Dir[File.join(File.dirname(__FILE__),%w{.. app ** *.rb})].each do |path|
  klass = File.basename(path,File.extname(path)).camelize.to_sym
  autoload klass, path
end

Dir[File.join(File.dirname(__FILE__),%w{.. lib ** *.rb})].each do |path|
  klass = File.basename(path,File.extname(path)).camelize.to_sym
  autoload klass, path
end

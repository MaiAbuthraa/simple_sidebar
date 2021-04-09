require "simple_sidebar/version"
require "simple_sidebar/process"
require "simple_sidebar/builder"
require "simple_sidebar/helpers/view"

module SimpleSidebar
  class << self
    attr_accessor :config_path, :locale_scope, :translate, :current_path

    ACCESSOR_METHODS  = [:config_path, :locale_scope, :translate, :current_path]

    def configure
      yield self if block_given?
    end
  end

  class Error < StandardError; end
end

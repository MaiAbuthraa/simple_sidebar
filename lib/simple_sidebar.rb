require "simple_sidebar/version"
require "simple_sidebar/builder"

module SimpleSidebar
  class << self
    attr_accessor :config_path, :locale_scope

    ACCESSOR_METHODS  = [:config_path, :locale_scope]

    def configure
      yield self if block_given?
    end
  end

  class Error < StandardError; end
end

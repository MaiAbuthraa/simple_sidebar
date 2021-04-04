# frozen_string_literal: true

require 'rails/generators/base'

module SimpleSidebar
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Creates copy locale files to your application."

      def copy_locale
        directory "config/locales"
      end

      def copy_config
        template  "config/initializers/simple_sidebar.rb"
        template  "config/simple_sidebar.yml"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end

module SimpleSidebar
  module Builder
    class Build
      def initialize()
        @sidebar_structure ||= YAML.load_file(Rails.root.join(*SimpleSidebar.config_path))
      end

      def call
      end

      private
      attr_reader :sidebar_structure
    end
  end
end

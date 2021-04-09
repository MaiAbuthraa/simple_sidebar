module SimpleSidebar
  module Helpers
    module View
      def build_simple_sidebar(scope = :default)
        SimpleSidebar::Process.new(scope.to_sym).call
      end
    end

    if Object.const_defined?("ActionView::Base")
      ActionView::Base.send :include, SimpleSidebar::Helpers::View
    end
  end
end

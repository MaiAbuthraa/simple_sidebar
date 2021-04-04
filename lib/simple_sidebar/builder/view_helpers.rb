module SimpleSidebar
  module Builder
    module ViewHelpers
      def build_simple_sidebar
        Build.new.call
      end
    end

    if Object.const_defined?("ActionView::Base")
      ActionView::Base.send :include, SimpleSidebar::Builder::ViewHelpers
    end
  end
end

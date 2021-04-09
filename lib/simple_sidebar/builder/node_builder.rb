module SimpleSidebar
  module Builder
    class NodeBuilder
      include ActionView::Context
      include ActionView::Helpers::TranslationHelper

      def initialize(node, style, scope)
        @node = node
        @style = style
        @scope = scope
      end

      def call
        content_tag node_tag, **node_options do
          link
        end
      end

      attr_reader :style, :scope, :node

      private
      def link
        content_tag :a, **link_options do
          (icon + label).html_safe
        end
      end

      def link_options
        {
          href: node[:path] || "#",
          method: node[:method],
          target: node[:target],
          class: node[:class],
          title: label
        }.compact
      end

      def node_options
        {}.tap do |option|
          option[:class] = active_class if is_active?
        end
      end

      def is_active?
        if node[:active_pattern].present?
          return eval(node[:active_pattern]) =~ SimpleSidebar.current_path
        end

        node[:path] == SimpleSidebar.current_path
      end

      def active_class
        style[:active_class] || 'active'
      end

      def icon
        return "" if node[:icon].blank?

        content_tag icon_tag, '', class: node[:icon]
      end

      def label
        SimpleSidebar.translate ? translate_label : node[:label]
      end

      def translate_label
        t("%s.%s.%s" % [SimpleSidebar.locale_scope, scope, node[:label]])
      end

      def node_tag
        style[:node_tag].to_sym || :li
      end

      def icon_tag
        style[:icon_tag].to_sym || :i
      end
    end
  end
end

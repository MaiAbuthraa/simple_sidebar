module SimpleSidebar
  module Builder
    class NodeBuilder
      include ActionView::Context
      include ActionView::Helpers::TranslationHelper

      def initialize(node, style, scope, parent)
        @node = node
        @style = style
        @scope = scope
        @parent = parent
      end

      def call
        content_tag node_tag, **node_options do
          link
        end
      end

      attr_reader :style, :scope, :node, :parent

      private
      def link
        content_tag :a, **link_options do
          (icon + label).html_safe
        end
      end

      def link_options
        {
          href: link_path,
          method: node[:method],
          target: node[:target],
          class: node[:link_class],
          title: label
        }.compact
      end

      def link_path
        return "#" unless node[:path].present?

        @link_path ||= eval("Rails.application.routes.url_helpers.#{node[:path]}")
      rescue  => e
        puts e
      end

      def node_options
        node[:node_class] = node_class
        parent_node_class

        {}.tap do |option|
          option[:class] = node[:node_class]

          if is_active?
            option[:class] << active_class
            parent[:node_class] << active_class unless parent.nil?
          end

          option[:class].join
        end
      end

      def node_class
        return node[:node_class] if node[:node_class].is_a? Array

        (node[:node_class] || "").split
      end

      def parent_node_class
        return if parent.nil?

        unless parent[:node_class].is_a? Array
          parent[:node_class] = (parent[:node_class] || "").split
        end
      end

      def is_active?
        if node[:active_pattern].present?
          return eval(node[:active_pattern]) =~ SimpleSidebar.current_path
        end

        link_path == SimpleSidebar.current_path
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

module SimpleSidebar
  module Builder
    class NodesBuilder
      include ActionView::Context
      include ActionView::Helpers::TranslationHelper

      def initialize(nodes, style, scope)
        @nodes = nodes
        @style = style
        @scope = scope
      end

      def call
        build_nodes(@nodes, -1)
      end

      attr_reader :style, :scope

      private
      def build_nodes(nodes, level)
        level += 1

        content_tag(nodes_tag, class: node_class_level(level)) do
          nodes.map do |_, node|
            NodeBuilder.new(node, style, scope).call + children(node, level)
          end.reduce(&:+)
        end.html_safe
      end

      def node_class_level(level)
        style["node_level_#{level}".to_sym]
      end

      def children(node, level)
        return "" if node[:children].blank?

        build_nodes(node[:children], level)
      end

      def nodes_tag
        style[:nodes_tag].to_sym || :ul
      end
    end
  end
end

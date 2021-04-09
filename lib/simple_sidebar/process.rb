module SimpleSidebar
  class Process
    def initialize(scope)
      @scope = scope
    end

    def call
      SimpleSidebar::Builder::NodesBuilder.new(nodes, style, scope).call
    end

    attr_reader :scope

    private
    def nodes
      @nodes ||= structure[:nodes]
    end

    def style
      @style ||= structure[:style]
    end

    def structure
      @structure ||= YAML.load_file(config_path).deep_symbolize_keys[scope]
    end

    def config_path
      @config_path ||= Rails.root.join(*SimpleSidebar.config_path)
    end
  end
end

require "tempfile"
module GrassGraph::Store
  class File
    def initialize(config)
      @config = config
    end

    def save(svg)
      @config.empty_check(:github_id, :png_path)
      Tempfile.create(["tmp", ".svg"]) do |tmp|
        tmp.puts svg
        GrassGraph::Image.convert(tmp.path, @config.png_path)
      end
    end
  end
end

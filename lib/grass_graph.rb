require "nokogiri"
require "open-uri"
require "ostruct"

require "grass_graph/image"
require "grass_graph/store"
require "grass_graph/version"

module GrassGraph
  class ConfigurationError < StandardError
    def initialize(name)
      super("`#{name}` is not specified.")
    end
  end

  class Configuration
    attr_accessor :github_id, :png_path, :dropbox, :s3

    def initialize
      self.dropbox = OpenStruct.new(enabled: false, access_token: "", path: "")
      self.s3 = OpenStruct.new(enabled: false, access_key: "",
        secret_access_key: "", bucket_name: "", path: "", acl: "")
    end

    def empty_check(*configs)
      configs.each do |conf|
        val = conf.is_a?(Array) ? conf.inject(self) { |o, c| o.send(c) } : send(conf)
        fail(ConfigurationError.new(conf)) if val.to_s.empty?
      end
    end
  end

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end

    def save_png
      Store::File.new(config).save(scrape)
      Store::Dropbox.new(config, config.dropbox).save if config.dropbox.enabled
      Store::AwsS3.new(config, config.s3).save if config.s3.enabled
    end

    private
      def scrape
        url = "https://github.com/#{config.github_id}"
        doc = Nokogiri::HTML.parse(open(url))
        svg = doc.css("svg.js-calendar-graph-svg")
        svg.first["xmlns"] = "http://www.w3.org/2000/svg"
        svg.css('[style="display: none;"]').each { |node| node.content = "" }
        svg
      end
  end
end

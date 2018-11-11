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
        secret_access_key: "", region: "ap-northeast-1",
        bucket_name: "", path: "", acl: "", cache_control: "")
    end

    def empty_check(*configs)
      configs.each do |conf|
        val = conf.is_a?(Array) ? conf.inject(self) { |o, c| o.send(c) } : send(conf)
        fail(ConfigurationError.new(conf)) if val.to_s.empty?
      end
    end
  end
end

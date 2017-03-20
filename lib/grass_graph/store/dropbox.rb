require "dropbox_api"
module GrassGraph::Store
  class Dropbox
    def initialize(config, base_info)
      @config = config
      @base_info = base_info
    end

    def save
      @config.empty_check([:dropbox, :access_token], [:dropbox, :path], :png_path)
      client = DropboxApi::Client.new(@base_info.access_token)
      file_content = IO.read(@config.png_path)
      client.upload(@base_info.path, file_content, mode: :overwrite)
    end
  end
end

require "aws-sdk"
module GrassGraph::Store
  class AwsS3
    def initialize(config, base_info)
      @config = config
      @base_info = base_info
    end

    def save
      @config.empty_check(
        [:s3, :access_key_id], [:s3, :secret_access_key], [:s3, :bucket_name],
        [:s3, :path], :png_path
      )
      Aws.config.update(
        credentials: Aws::Credentials.new(@config.s3.access_key_id, @config.s3.secret_access_key)
      )
      s3 = Aws::S3::Resource.new
      obj = s3.bucket(@config.s3.bucket_name).object(@config.s3.path)
      opts = {}
      opts[:acl] = @base_info.acl unless @base_info.acl.to_s.empty?
      obj.upload_file(@config.png_path, opts)
    end
  end
end

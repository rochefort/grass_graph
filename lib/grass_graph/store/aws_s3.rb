require "aws-sdk"
module GrassGraph::Store
  class AwsS3
    def initialize(config, base_info)
      @config = config
      @base_info = base_info
    end

    def save
      @config.empty_check(
        [:s3, :access_key_id], [:s3, :secret_access_key], [:s3, :region],
        [:s3, :bucket_name], [:s3, :path], :png_path
      )
      Aws.config.update(
        region: @base_info.region,
        credentials: Aws::Credentials.new(@base_info.access_key_id, @base_info.secret_access_key)
      )
      s3 = Aws::S3::Resource.new
      obj = s3.bucket(@base_info.bucket_name).object(@base_info.path)
      opts = {}
      opts[:acl] = @base_info.acl unless @base_info.acl.to_s.empty?
      opts[:cache_control] = @base_info.cache_control unless @base_info.cache_control.to_s.empty?
      obj.upload_file(@config.png_path, opts)
    end
  end
end

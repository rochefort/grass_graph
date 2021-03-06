# grass_graph

Save a PNG image of the specified GitHub grass-graph and upload it to s3 and dropbox.  

I inspired this web service:  
[Grass-Graph / Imaging your GitHub Contributions Graph](https://grass-graph.shitemil.works/)


## Requirements
- Ruby 2.0+
- Imagemagick
- Ghostscript


## Installation
```sh
git clone https://github.com/rochefort/grass_graph
cd grass_graph
bundle install
bundle exec rake install
```

## Usage
```ruby
require "grass_graph"

GrassGraph.configure do |config|
  config.github_id = "rochefort"
  config.png_path = "grass-graph.png"

  # Dropbox settings
  # enabled: default false
  config.dropbox.enabled = true
  config.dropbox.access_token = "YOUR_DROPBOX_ACCESS_TOKEN"
  config.dropbox.path = "/grass-graph.png"

  # AWS S3 settings
  # enabled: default false
  # region: default ap-northeast-1
  # acl: accepts private, public-read, public-read-write, authenticated-read
  # cache_control: optional
  config.s3.enabled = true
  config.s3.access_key_id = "YOUR_AWS_ACCESS_ID"
  config.s3.secret_access_key = "YOUR_AWS_SECRET_ACCESS_KEY"
  config.s3.region = "ap-northeast-1"
  config.s3.bucket_name = "YOUR_BUCKET_NAME"
  config.s3.path = "grass-graph.png"
  config.s3.acl = "public-read"
  config.s3.cache_control = "max-age=86400"
end

GrassGraph.save_png
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rochefort/grass_graph.


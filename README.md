# grass_graph

Save a PNG image of the specified GitHub grass-graph and upload s3 and dropbox.


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
  # acl: accepts private, public-read, public-read-write, authenticated-read
  config.s3.enabled = true
  config.s3.access_key_id = "YOUR_AWS_ACCESS_ID"
  config.s3.secret_access_key = "YOUR_AWS_SECRET_ACCESS_KEY"
  config.s3.bucket_name = "YOUR_BUCKET_NAME"
  config.s3.path = "grass-graph.png"
  config.s3.acl = "public-read"
end

GrassGraph.save_png
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rochefort/grass_graph.


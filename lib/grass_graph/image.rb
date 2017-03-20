require "mini_magick"

module GrassGraph
  class Image
    def self.convert(from, to)
      MiniMagick::Tool::Convert.new do |convert|
        convert.background("none")
        convert.merge! ["-pointsize", "11"]
        convert << from
        convert << to
      end
    end
  end
end

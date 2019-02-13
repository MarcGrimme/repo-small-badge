# frozen_string_literal: true

require 'mini_magick'

ImageMagickError = Class.new(StandardError)

module RepoSmallBadge
  # :nodoc:
  class Image
    # Create new instance.
    # @config is a Hash of configurables. Keys are symbols.
    def initialize(config = {})
      raise ImageMagicError, 'Imagemagick is not installed on this system.' \
        unless MiniMagick.imagemagick?

      @config = config
      MiniMagick.logger = Logger.new($stdout, level:
                                     @config.fetch(:log_level, 'info')
        .to_sym)
    end

    # Creates the badge.
    # @name the suffix for the filename (badge_#{name})
    # @title the title of the badge.
    # @value is the overall value to be written to the right side of the badge.
    # @state can be either good, bad, unknown
    #        (background color is determined from it.)
    def badge(name, title, value, state)
      MiniMagick::Tool::Convert.new do |convert|
        convert.gravity('center')
        convert.background(@config.fetch(:background, 'transparent'))
        convert.pango(pango(title, value, state))
        rounded_border? &&
          rounded_border(convert,
                         @config.fetch(:rounded_edge_radius, 3))
        convert << filename(name)
      end
      true
    end

    private

    # rubocop:disable Lint/Void, Metrics/LineLength, Metrics/MethodLength, Metrics/AbcSize
    def rounded_border(convert, radius = 3)
      convert.stack do |stack|
        stack.clone.+
        stack.alpha('extract')
        stack.draw("fill black polygon 0,0 0,#{radius} #{radius},0 fill white circle #{radius},#{radius} #{radius},0")
        stack.stack do |stack1|
          stack1.clone.+
          stack1.flip
        end
        stack.compose('Multiply')
        stack.composite
        stack.stack do |stack1|
          stack1.clone.+
          stack1.flop
        end
        stack.compose('Multiply')
        stack.composite
      end
      convert.alpha('off')
      convert.compose('CopyOpacity')
      convert.composite
    end
    # rubocop:enable Lint/Void, Metrics/LineLength, Metrics/MethodLength, Metrics/AbcSize

    def rounded_border?
      @config.fetch(:rounded_border, true)
    end

    def pango(title, value, state)
      "#{pango_title(title)}#{pango_value(value, state)}"
    end

    def pango_title(suffix)
      pango_text(title(suffix), @config.fetch(:title_font, 'Helvetica'),
                 @config.fetch(:title_font_color, 'white'),
                 @config.fetch(:title_font_size, '16'),
                 @config.fetch(:title_background, '#595959'))
    end

    def pango_value(value, state)
      pango_text " #{value} ",
                 @config.fetch(:value_font, 'Helvetica-Narrow-Bold'),
                 @config.fetch(:coverage_font_color, 'white'),
                 @config.fetch(:coverage_font_size, '16'),
                 state_background(state)
    end

    def pango_text(text, font, font_color, font_size, background)
      "<span foreground=\"#{font_color}\"
             background=\"#{background}\"\
             size=\"#{font_size.to_i * 1000}\"\
             font=\"#{font}\"\
        >#{text}</span>"
    end

    def state_background(state)
      @config.fetch(:"value_background_#{state}", 'yellow')
    end

    def filename(suffix = '')
      prefix = @config.fetch(:filename_prefix, 'badge')
      format = @config.fetch(:format, 'svg')
      "#{output_path}/#{prefix}_#{suffix}.#{format}"
    end

    def title(suffix)
      " #{@config.fetch(:title_prefix, 'badge')} #{suffix} "
    end

    def output_path
      @config.fetch(:output_path, '.')
    end
  end
end

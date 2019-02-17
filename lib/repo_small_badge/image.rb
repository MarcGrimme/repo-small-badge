# frozen_string_literal: true

require 'victor'

module RepoSmallBadge
  # :nodoc:
  # rubocop:disable Metrics/ClassLength
  class Image < Victor::SVGBase
    # Create new instance.
    # @config is a Hash of configurables. Keys are symbols.
    def initialize(config = {})
      @config = config
      super(template: :html, contentScriptType: 'text/ecmascript',
            contentStyleType: 'text/css', preserveAspectRatio: 'xMidYMid meet',
            'xmlns:xlink': 'http://www.w3.org/1999/xlink',
            xmlns: 'http://www.w3.org/2000/svg', version: '1.0',
            height: badge_height)
    end

    # Creates the badge.
    # @name the suffix for the filename (badge_#{name})
    # @title the title of the badge.
    # @value is the overall value to be written to the right side of the badge.
    def badge(name, title, value)
      svg_header
      svg_boxes
      svg_texts(title, value)
      save(filename(name))
    end

    # Updates the configuration settings and overwrites existing ones.
    # @config the hash that has to be merged.
    def config_merge(config)
      @config.merge(config)
    end

    private

    def svg_header
      element :linearGradient, id: 'smooth', x2: '0', y2: '100%' do
        element :stop, offset: '0', 'stop-color': '#bbb', 'stop-opacity': '.1'
        element :stop, offset: '1', 'stop-opacity': '.1'
      end
    end

    def svg_boxes
      middle = badge_width / 2
      svg_rounded_box

      element :g, 'clip-path' => 'url(#round)' do
        element :rect, height: badge_height, width: middle,
                       fill: title_background
        element :rect, x: middle, height: badge_height,
                       width: middle, fill: value_background
        element :rect, height: badge_height,
                       width: badge_width, fill: 'url(#smooth)'
      end
    end

    def svg_rounded_box
      element :clipPath, id: 'round' do
        element :rect, height: badge_height, width: badge_width,
                       rx: rounded_edge_radius, fill: background
      end
    end

    # rubocop:disable Metrics/AbcSize
    def svg_texts(title, value)
      middle = badge_width / 2
      element :g, fill: title_color, 'text-anchor': 'middle',
                  'font-family': font, size: font_size do |_svg|
        element :text, title(title), x: middle / 2, y: badge_height - 5,
                                     fill: '#010101', 'fill-opacity': '0.3'
        element :text, title(title), x: middle / 2, y: badge_height - 6
        element :text, value, x: middle / 2 + middle, y: badge_height - 5,
                              fill: '#010101', 'fill-opacity': '0.3'
        element :text, value, x: middle / 2 + middle, y: badge_height - 6
      end
    end
    # rubocop:enable Metrics/AbcSize

    def value_background
      @config.fetch(:value_background, '#4c1')
    end

    def title_background
      @config.fetch(:title_background, '#555')
    end

    def background
      @config.fetch(:background, '#fff')
    end

    def title_color
      @config.fetch(:title_color, '#fff')
    end

    def font
      @config.fetch(:font, 'Verdana,sans-serif')
    end

    def font_size
      @config.fetch(:font_size, 11).to_s
    end

    def rounded_edge_radius
      if @config.fetch(:rounded_border, true)
        @config.fetch(:rounded_edge_radius, '3')
      else
        0
      end
    end

    def badge_width
      @config.fetch(:badge_width, 120).to_i
    end

    def badge_height
      @config.fetch(:badge_height, 20).to_i
    end

    def filename(suffix = '')
      prefix = @config.fetch(:filename_prefix, 'badge')
      format = @config.fetch(:format, 'svg')
      "#{output_path}/#{prefix}_#{suffix}.#{format}"
    end

    def title(suffix)
      prefix = @config.fetch(:title_prefix, '')
      if prefix.to_s.empty?
        suffix
      else
        "#{@config.fetch(:title_prefix, '')} #{suffix}"
      end
    end

    def output_path
      @config.fetch(:output_path, '.')
    end
  end
  # rubocop:enable Metrics/ClassLength
end

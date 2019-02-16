# frozen_string_literal: true

module TestRepoSmallBadge
  # rubocop:disable Metrics/MethodLength, Metrics/LineLength, Layout/TrailingWhitespace
  def default_svg_string
    %(<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

<svg height="20" width="100%" 
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink">


<linearGradient id="smooth" x2="0" y2="100%">
<stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
<stop offset="1" stop-opacity=".1"/>
</linearGradient>
<clipPath id="round">
<rect height="20" width="120" rx="3" fill="#fff"/>
</clipPath>
<g clip-path="url(#round)">
<rect height="20" width="60" fill="#555"/>
<rect x="60" height="20" width="60" fill="#4c1"/>
<rect height="20" width="120" fill="url(#smooth)"/>
</g>
<g fill="#fff" text-anchor="middle" font-family="Verdana,sans-serif" size="11">
<text x="30" y="15" fill="#010101" fill-opacity="0.3">
Total
</text>
<text x="30" y="14">
Total
</text>
<text x="90" y="15" fill="#010101" fill-opacity="0.3">
100%
</text>
<text x="90" y="14">
100%
</text>
</g>

</svg>)
  end

  def not_rounded_svg_string
    %(<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

<svg height="20" width="100%" 
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink">


<linearGradient id="smooth" x2="0" y2="100%">
<stop offset="0" stop-color="#bbb" stop-opacity=".1"/>
<stop offset="1" stop-opacity=".1"/>
</linearGradient>
<clipPath id="round">
<rect height="20" width="200" rx="0" fill="#fff"/>
</clipPath>
<g clip-path="url(#round)">
<rect height="20" width="100" fill="#555"/>
<rect x="100" height="20" width="100" fill="#4c1"/>
<rect height="20" width="200" fill="url(#smooth)"/>
</g>
<g fill="#fff" text-anchor="middle" font-family="Verdana,sans-serif" size="11">
<text x="50" y="15" fill="#010101" fill-opacity="0.3">
badge Total
</text>
<text x="50" y="14">
badge Total
</text>
<text x="150" y="15" fill="#010101" fill-opacity="0.3">
100%
</text>
<text x="150" y="14">
100%
</text>
</g>

</svg>)
  end
  # rubocop:enable Metrics/MethodLength, Metrics/LineLength, Layout/TrailingWhitespace
end

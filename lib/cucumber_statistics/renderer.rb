require 'haml'
require 'tilt/haml'
require 'cucumber_statistics/renderer_helper'

module CucumberStatistics
  class Renderer

    class << self

      $renderer_helper ||=

      def render_step_statistics(step_statistics, overall_statistics)
        template = Tilt::HamlTemplate.new(File.expand_path('../view/step_statistics.html.haml', __FILE__))
        rendered_content = template.render(RendererHelper.new, step_statistics: step_statistics, overall_statistics: overall_statistics)

        absolute_file_name = Configuration.result_step_statistics
        File.open(absolute_file_name, 'w') do |f|
          f.write rendered_content
        end

        absolute_file_name
      end
    end
  end
end
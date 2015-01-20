require 'cucumber_statistics'

AfterConfiguration do |configuration|
  configuration.formats << ['CucumberStatistics::Formatter', nil]
end
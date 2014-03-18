AfterConfiguration do |configuration|
  configuration.options[:formats] << ['CucumberStatistics::Formatter', nil]
end
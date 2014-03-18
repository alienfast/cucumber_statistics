# Cucumber Statistics

A cucumber formatter that will gather statistics and generate a single page showing step time metrics.

## Usage

1. For always-on use, add it to your `cucumber.yml` by adding `--format CucumberStatistics::Formatter` i.e.

    std_opts = "-r features/support/ -r features/step_definitions --quiet --format CucumberStatistics::Formatter --format progress --format junit -o test-reports --strict --tags ~@wip --tags ~@todo"

2. Or, use it via command line with the `--format CucumberStatistics::Formatter` option.


Look in the `./tmp/cucumber_statistics` for the generated html documents.

## Contributing

Please contribute!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits
Credit to [Ryan Boucher](https://github.com/distributedlife) [cucumber_timing_presenter](https://github.com/distributedlife/cucumber_timing_presenter) for the raw material used to gather statistics.

## Copyright

Copyright (c) 2014 AlienFast. See [LICENSE.txt](https://github.com/alienfast/cucumber_statistics/blob/master/LICENSE.txt) for further details.
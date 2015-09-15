# Cucumber Statistics

Tracks cucumber timing and displays results in a single html page with outliers highlighted in a table sortable by various metrics.

## Installation

1. Add `gem 'cucumber_statistics'` to your `Gemfile`

2. Or `gem install 'cucumber_statistics`

## Configuration

1. For always-on automatic loading (recommended), add `require 'cucumber_statistics/autoload'` to `features/support/env.rb` or other support file.

2. Or, add it to your `cucumber.yml` by adding `--format CucumberStatistics::Formatter` i.e.

    `std_opts = "-r features/support/ -r features/step_definitions --quiet --format CucumberStatistics::Formatter --format progress --format junit -o test-reports --strict --tags ~@wip --tags ~@todo"`

3. Or, use it via command line with the `--format CucumberStatistics::Formatter` option.

## Results

Look in the `./target/cucumber_statistics` for the generated html document.

## Why?

It should be fast and easy to find long running steps.  This generates a bootstrap styled page with a sortable table, where the outliers are clearly identified.  It should be fast and easy to diagnose problems.

## Contributing

Please contribute!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits
Credit to Ryan Boucher [cucumber_timing_presenter](https://github.com/distributedlife/cucumber_timing_presenter) for the original code used to gather statistics.

## Copyright

Copyright (c) 2014 AlienFast. See [LICENSE.txt](https://github.com/alienfast/cucumber_statistics/blob/master/LICENSE.txt) for further details.
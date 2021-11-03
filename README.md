# EntrisionReports

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/entrision_reports`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'entrision_reports'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install entrision_reports

## Usage

Make sure to install the active_admin reports page.

```bash
bunde exec rails g entrision_reports:install

```

This generate a report with

```bash
bundle exec rails g entrision_reports:report name_of_report
```

This will create a definition file in lib/reports/name_of_report.rb

Valid Formats are:

Hidden, Percentage, Link, DateTime, Email, Money, Date, Integer, TextBox, Javascript

Valid Charts are:

line, bar, column, pie, geo

the **generate_data** method needs to return an array of rows for example

```ruby
def generate_data
  [['10/1/2001', 1,2,3], ['10/2/2001', 4,5,6]]
end

```

the **chart** method needs to return either false for no chart or a hash

```ruby
def chart
  data = [['10/1/2001', 3], ['10/2/2001', 6]]
  { title: 'A chart title', type: 'area', data: data }
end
```

In development charts will generate in real time so that errors are easier to see. In production and staging,
chart data is generated in a worker process. This creates a slightly different behavior in dev then in production.

To use reports outside of active admin, make sure to add a route like

```ruby
  get '/reports' => 'reports#index', as: 'reports'
  get '/reports/clear' => 'reports#clear_cache', as: 'reports_clear_cache'
  get '/reports/sample' => 'reports#show', report: 'sample', viewer: 'single', as: 'reports_sample'
```

The default views are based on bootstrap. But can be overridden.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

When working with the gem in a project locally (to speed up testing), include the gem in the gemfile normall, then

```bash
bundle config local.entrision_reports /path/to/local/git/repository
```

When you run bundle you should see something like:

```plain
Using entrision_reports 0.1.1 from https://github.com/entrision/entrision_reports.git (at /home/coteyr/Projects/entrision_reports@6ac05ed)
```

To go back to the git version

```bash
bundle config --delete local.entrision_reports
```

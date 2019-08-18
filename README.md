# NewsCollator

NewsCollator will visit any website presented in the menu list and return every news tile requested.  Each news tile
will contain a headline, description, url, comments and views.
User will have menu options for viewing and displaying all retrieved information

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'news_collator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install news_collator
 and run
    $ bundle install

## Usage

    $ CLI.new.run

or

    $ yourCLI = CLI.new
    $ yourCLI.run

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'rohanphillips'/news_collator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NewsCollator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'rohanphillips'/news_collator/blob/master/CODE_OF_CONDUCT.md).

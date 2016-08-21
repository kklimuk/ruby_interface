# RubyInterface

When a class is interpreted and does not have the required methods, it throws an error.

Caveats:
- creating anonymous classes will not work with this gem as they use an alternate mechanism.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_interface'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_interface

## Usage

```ruby
class SpaceShip
  include RubyInterface

  defines :engine, :computer
end

class Enterprise < SpaceShip
end
# => NotImplementedError, 'Expected Enterprise to define #engine, #computer'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kklimuk/ruby_interface.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


# RubyInterface [![Build Status](https://travis-ci.org/kklimuk/ruby_interface.svg?branch=master)](https://travis-ci.org/kklimuk/ruby_interface)

Allows you to create abstract classes and interfaces in Ruby.

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

### Named Classes

```ruby
class SpaceShip
  include RubyInterface

  defines :engine, :computer
end

class Enterprise < SpaceShip
end
# => NotImplementedError, 'Expected Enterprise to define #engine, #computer'
``` 

### Anonymous classes

```ruby
class SpaceShip
  include RubyInterface

  defines :engine, :computer
end

# If the block is passed in to Class::new
space_ship = Class.new(SpaceShip) { }
# => NotImplementedError, 'Expected Enterprise to define #engine, #computer'

# If the block is not passed in to Class::new
space_ship = Class.new(SpaceShip)
space_ship.class_eval { }

# => NotImplementedError, 'Expected Enterprise to define #engine, #computer'
# NOTE: After the first `class_eval`, the rest of the calls to it will not check whether methods are defined.
# NOTE: `class_exec` may also be used instead of `class_eval`
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kklimuk/ruby_interface.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


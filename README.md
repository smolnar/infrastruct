# Infrastruct
[![Build Status](https://travis-ci.org/smolnar/infrastruct.svg?branch=master)](https://travis-ci.org/smolnar/infrastruct)

Process and distribute asynchronous tasks and merge their results.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'infrastruct'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install infrastruct

## Usage

Define your worker with task as `perform` and merge results with `collect`.

```ruby
class SquaredNumbersCollector
  extend Infrastruct

  def perform(number)
    number ** 2
  end

  def collect(numbers)
    numbers.inject(&:+)
  end
end
```

Create worker.

```ruby
worker = SquaredNumbersCollector.create
```

Enqueue attributes for tasks.

```
worker.enqueue(1)
worker.enqueue(2)
worker.enqueue(3)
```

Run worker and wait for merge results.

```
sum = worker.run # => 1 ^ 2 + 2 ^ 2 + 3 ^ 2 = 14
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smolnar/infrastruct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

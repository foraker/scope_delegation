# ScopeDelegation

Every application needs to be able to scope data, and every developer hates
writing boilerplate code.

With `ScopeDelegation`, you can easily define scopes
in one model that rely on scopes that are defined on an associated model.

## Usage

Let's look at an example.

```ruby
class Whole < ActiveRecord::Base
  extend ScopeDelegation

  has_many :parts

  delegate_scope :named, to: :parts, prefix: :part
end

class Part < ActiveRecord::Base
  belongs_to :whole

  def self.named(name)
    where(name: name)
  end
end
```

This now enables you to call `Whole.part_named("some name")` to easily scope
your `Whole`s.

The `prefix` option is optional, and you can also specify the `scope` on the
associated model if it does not match the first parameter.

## Explanation

In a previous life, you might have been tempted to do something like:

```ruby
# whole.rb
def self.part_named(name)
  joins(:parts).where(name: name)
end
```

This is unfortunate because now `Whole` knows about a column name for `Part`,
which is none of its business. Isolating knowledge about the persistence for a
given model to that model itself makes changing things easier.

We can get around this with `merge`, like so:

```ruby
# whole.rb
def self.part_named(name)
  joins(:parts).merge(Part.named(name))
end
```

This is what `ScopeDelegation` does, but with a friendly DSL that allows you to
avoid writing boilerplate while discouraging knowing things about your neighbor
that you shouldn't.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scope_delegation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scope_delegation

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/scope_delegation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## About Foraker Labs

![Foraker Logo](http://assets.foraker.com/attribution_logo.png)

Foraker Labs builds exciting web and mobile apps in Boulder, CO. Our work powers a wide variety of businesses with many different needs. We love open source software, and we're proud to contribute where we can. Interested to learn more? [Contact us today](https://www.foraker.com/contact-us).

This project is maintained by Foraker Labs. The names and logos of Foraker Labs are fully owned and copyright Foraker Design, LLC.

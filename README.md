# ValidatesModulus

[![Build Status](https://travis-ci.org/vofo-no/validates_modulus.svg?branch=master)](https://travis-ci.org/vofo-no/validates_modulus)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/validates_modulus`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validates_modulus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validates_modulus

## Usage

This gem validates check digit of any ActiveModel attribute. Currently it supports ```:mod11```.

    class Organization
      include ActiveModel::Validations
      attr_accessor :number

      validates :number, modulus: :mod11
    end

You can overwrite the default error message (```:bad_checksum```) by passing a ```:message``` option argument:

    validates :number, modulus: { with: :mod11, message: 'Not a valid number' }

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vofo-no/validates_modulus.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# CascadeTouch
[![Maintainability](https://api.codeclimate.com/v1/badges/a881059f3a535ddd7a14/maintainability)](https://codeclimate.com/github/markfrst/cascade_touch/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/a881059f3a535ddd7a14/test_coverage)](https://codeclimate.com/github/markfrst/cascade_touch/test_coverage)


Имеем Model1, Model2, Model3, Model4 и связи между ними.

```
Model1 has many Model2
Model2 has many Model3
Model3 has many Model4
```

Наша задача, обеспечить каскадное обновление updated_at на моделях верхнего уровня при изменении модели нижнего уровня. т.е. при изменении инстанса Model1 мы должны изменить updated_at у всех связанных Model2, связанных с ними Model3 и связанных с ними Model4. Должна быть возможность выполнять ассинхронно

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cascade_touch'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cascade_touch

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cascade_touch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CascadeTouch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cascade_touch/blob/master/CODE_OF_CONDUCT.md).

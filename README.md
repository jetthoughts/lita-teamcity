# lita-teamcity

[![Build Status](https://travis-ci.org/jetthoughts/lita-teamcity.png?branch=master)](https://travis-ci.org/jetthoughts/lita-teamcity)
[![Coverage Status](https://coveralls.io/repos/jetthoughts/lita-teamcity/badge.png)](https://coveralls.io/r/jetthoughts/lita-teamcity)

Communicate with TeamCity via Chat

## Installation

Add lita-teamcity to your Lita instance's Gemfile:

``` ruby
gem 'lita-teamcity'
```

## Configuration

### Optional attributes

* `endpoint` (String) – The TeamCity URL
* `user` (String) – HTTP Basic Auth username
* `password` (String) – HTTP Basic Auth password

### Example

```ruby
Lita.configure do |config|
  config.handlers.teamcity.endpoint = 'https://ci.jetthoughts.com/app/rest'
  config.handlers.teamcity.user = 'bot'
  config.handlers.teamcity.password = 'Password'
  # ...
end
```

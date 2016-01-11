# ![Social Sharer Logo][logo]
By [BD Network][thisisbd].

Social Sharer is a [Ruby on Rails][rails] [Gem][rubygems], allowing you to easily create Twitter and Facebook share dialogues.

[![Build status][shield-build]][info-build]
[![Gem Version][shield-gem]][info-gem]
[![Code Coverage][shield-coverage]][info-coverage]
[![License][shield-license]][info-license]

## Key Features
- Easy to configure
- Easy to style
- Kept up to date with changes share systems.


## Getting Started
### Installation
Add this to your gemfile within your Rails project:

```bash
gem 'social_sharer', '0.1.4'
```

### Options
#### Single share URL
If you require a single URL to be shared across both social networks but require simple tracking, e.g. for Google 
Analytics you can use the options listed below:

```ruby
{
  url: 'http://thisisbd.com/',
  twitter_message: 'This%20is%20BD'
}
```

This would have Facebook link to: `http://thisisbd.com/?src=fb` 
and your tweet contents would be: `This is BD http://thisisbd.com/?src=tw`

You may also add an (optional) Twitter handle to be included into the message:

```ruby
{
  url: 'http://thisisbd.com/',
  twitter_handle: '@thisisbd',
  twitter_message: 'This%20is%20BD'
}
```

Your tweet contents would be: `This is BD via @thisisbd http://thisisbd.com/?src=tw`

#### Multiple share URLs
If you provide different URLs for each social network, or want more flexible control over the URLs users are sharing, 
these options are for you:

```ruby
{
  individual_settings: true,

  twitter: {
    url: 'http://thisisbd.com/twitter_url',
    message: 'This%20is%20BD'
  },

  facebook: {
    url: 'http://thisisbd.com/facebook_url'
  }
}
```

This would have Facebook link to: `http://thisisbd.com/facebook_url` 
and your tweet contents would be: `This is BD http://thisisbd.com/twitter_url`

You may also add an (optional) Twitter handle to be included into the message:

```ruby
{
  individual_settings: true,

  twitter: {
    url: 'http://thisisbd.com/twitter_url',
    handle: '@thisisbd',
    message: 'This%20is%20BD'
  },

  facebook: {
    url: 'http://thisisbd.com/facebook_url'
  }
}
```

This would have Facebook link to: `http://thisisbd.com/facebook_url` 
and your tweet contents would be: `This is BD via @thisisbd http://thisisbd.com/twitter_url`

### View Helper
Within your view:

```ruby
<%= social_share_tags( @social_sharer_options ) %>
```

## Requirements
Social Sharer requires [Ruby on Rails][rails] and has been tested on 4.x.


## Contributing
If you wish to submit a bug fix or feature, you can create a pull request and it will be merged pending a code review.

1. Clone it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## License
Social Sharer is licensed under the [MIT License][info-license].

[logo]: https://raw.github.com/thisisbd/social_sharer/master/social_sharer_logo.png

[thisisbd]: http://thisisbd.com/
[rails]: http://rubyonrails.org/
[rubygems]: https://rubygems.org/

[info-coverage]: https://coveralls.io/github/thisisbd/social_sharer
[info-license]: LICENSE
[info-gem]: https://rubygems.org/gems/social_sharer
[info-build]: https://travis-ci.org/thisisbd/social_sharer
[shield-coverage]: https://img.shields.io/coveralls/thisisbd/social_sharer.svg
[shield-license]: https://img.shields.io/badge/license-MIT-blue.svg
[shield-gem]: https://img.shields.io/gem/v/social_sharer.svg
[shield-build]: https://img.shields.io/travis/thisisbd/social_sharer/master.svg
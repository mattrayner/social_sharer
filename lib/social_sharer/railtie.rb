require 'social_sharer/view_helpers'
module SocialSharer
  class Railtie < Rails::Railtie
    initializer 'social_sharer.view_helpers' do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end

module SocialSharer
  module ViewHelpers
    # Given an options object, create a number of social URLs
    def social_share_tags(options)
      validate_social_tag_options(options)

      has_individual_settings = options[:individual_settings]

      twitter_url = has_individual_settings ? options[:twitter][:url] : options[:url]
      twitter_url += '?src=tw'

      twitter_message = has_individual_settings ? options[:twitter][:message] : options[:twitter_message]
      twitter_handle = has_individual_settings ? options[:twitter][:handle] : options[:twitter_handle]

      facebook_url = has_individual_settings ? options[:facebook][:url] : options[:url]
      facebook_url += '?src=fb'

      twitter_handle_text = if twitter_handle.nil?
                              ''
                            else
                              "via #{twitter_handle} "
                            end

      link_to('Share on Twitter', 'http://twitter.com/', rel: 'nofollow', onclick: "popUp=window.open("\
                                                                                     "'http://twitter.com/intent/tweet?text=#{twitter_message} #{twitter_handle_text}#{twitter_url}',"\
                                                                                     "'popupwindow',"\
                                                                                     "'scrollbars=yes,width=800,height=400');"\
                                                                                   "popUp.focus();"\
                                                                                   "return false") +
      link_to('Share on Facebook', 'http://www.facebook.com/', rel: 'nofollow', onclick: "popUp=window.open("\
                                                                                           "'http://www.facebook.com/sharer.php?u=#{facebook_url}',"\
                                                                                           "'popupwindow',"\
                                                                                           "'scrollbars=yes,width=800,height=400');"\
                                                                                         "popUp.focus();"\
                                                                                         "return false")
    end

    private

    # Check to see if the options that we are expecting have been set
    #
    # @param [Hash] options Options passed to social_share_tags
    #
    # @raise [StandardError] Raised if the options passed do not meet what we expect
    def validate_social_tag_options(options)
      raise(StandardError, 'Options parameter cannot be nil') if options.nil?

      correct_opts = true
      missing_opts = []

      root_params = %w( url twitter_message )
      twitter_params, facebook_params = [], []

      if options[:individual_settings]
        root_params =     %w{ twitter facebook }
        twitter_params =  %w( url message )
        facebook_params = %w( url )
      end

      root_params.each do |param|
        unless options[param.to_sym].present?
          correct_opts = false
          missing_opts << param
        end
      end

      twitter_params.each do |param|
        break if options[:twitter].nil?

        unless options[:twitter][param.to_sym].present?
          correct_opts = false
          missing_opts << "twitter - #{param}"
        end
      end

      facebook_params.each do |param|
        break if options[:facebook].nil?

        unless options[:facebook][param.to_sym].present?
          correct_opts = false
          missing_opts << "facebook - #{param}"
        end
      end

      raise(StandardError, "Unexpected options - expected #{missing_opts.inspect} to be present") unless correct_opts
    end
  end
end
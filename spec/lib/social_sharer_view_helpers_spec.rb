require 'spec_helper'

require 'action_view'
require 'active_support'

include ActionView::Helpers
include SocialSharer::ViewHelpers

describe SocialSharer::ViewHelpers do
  describe '#social_share_tags' do
    context 'with valid options' do
      context 'without individual_settings set' do
        context 'with a twitter handle' do
          before :each do
            @options = {
              url: 'http://thisisbd.com',
              twitter_message: 'This is BD - A creative agency in London',
              twitter_handle: '@thisisbd'
            }
          end

          it 'generates the expected twitter tag' do
            expect( social_share_tags(@options) ).to include("<a rel=\"nofollow\" class=\"social_share_tw\" onclick=\"popUp=window.open(&#39;http://twitter.com/intent/tweet?text=This is BD - A creative agency in London via @thisisbd http%3A%2F%2Fthisisbd.com%3Fsrc%3Dtw&#39;,&#39;popupwindow&#39;,&#39;scrollbars=yes,width=800,height=400&#39;);popUp.focus();return false\" href=\"http://twitter.com/\">Share on Twitter</a>")
          end

          it 'generates the expected facebook tag' do
            expect( social_share_tags(@options) ).to include("<a rel=\"nofollow\" class=\"social_share_fb\" onclick=\"popUp=window.open(&#39;http://www.facebook.com/sharer.php?u=http%3A%2F%2Fthisisbd.com%3Fsrc%3Dfb&#39;,&#39;popupwindow&#39;,&#39;scrollbars=yes,width=800,height=400&#39;);popUp.focus();return false\" href=\"http://www.facebook.com/\">Share on Facebook</a>")
          end
        end

        context 'without a twitter handle' do
          before :each do
            @options = {
              url: 'http://thisisbd.com',
              twitter_message: 'This is BD - A creative agency in London'
            }
          end

          it 'generates the expected twitter tag' do
            expect( social_share_tags(@options) ).to include("<a rel=\"nofollow\" class=\"social_share_tw\" onclick=\"popUp=window.open(&#39;http://twitter.com/intent/tweet?text=This is BD - A creative agency in London http%3A%2F%2Fthisisbd.com%3Fsrc%3Dtw&#39;,&#39;popupwindow&#39;,&#39;scrollbars=yes,width=800,height=400&#39;);popUp.focus();return false\" href=\"http://twitter.com/\">Share on Twitter</a>")
          end
        end
      end

      context 'with individual_settings set' do
        context 'with a twitter handle' do
          before :each do
            @options = {
              individual_settings: true,

              twitter: {
                url: 'http://mattrayner.co.u/twitter_specific_page',
                handle: '@mattrayner',
                message: 'Matt Rayner - A full-stack Rubyist in London'
              },

              facebook: {
                url: 'http://mattrayner.co.uk/facebook_specific_page'
              }
            }
          end

          it 'generates the expected facebook tag' do
            expect( social_share_tags(@options) ).to include("<a rel=\"nofollow\" class=\"social_share_fb\" onclick=\"popUp=window.open(&#39;http://www.facebook.com/sharer.php?u=http%3A%2F%2Fmattrayner.co.uk%2Ffacebook_specific_page&#39;,&#39;popupwindow&#39;,&#39;scrollbars=yes,width=800,height=400&#39;);popUp.focus();return false\" href=\"http://www.facebook.com/\">Share on Facebook</a>")
          end

          it 'generates the expected twitter tag' do
            expect( social_share_tags(@options) ).to include("<a rel=\"nofollow\" class=\"social_share_tw\" onclick=\"popUp=window.open(&#39;http://twitter.com/intent/tweet?text=Matt Rayner - A full-stack Rubyist in London via @mattrayner http%3A%2F%2Fmattrayner.co.u%2Ftwitter_specific_page&#39;,&#39;popupwindow&#39;,&#39;scrollbars=yes,width=800,height=400&#39;);popUp.focus();return false\" href=\"http://twitter.com/\">Share on Twitter</a>")
          end
        end

        context 'without a twitter handle' do
          before :each do
            @options = {
              individual_settings: true,

              twitter: {
                url: 'http://mattrayner.co.u/twitter_specific_page',
                message: 'Matt Rayner - A full-stack Rubyist in London'
              },

              facebook: {
                url: 'http://mattrayner.co.uk/facebook_specific_page'
              }
            }
          end

          it 'generates the expected facebook tag' do
            expect( social_share_tags(@options) ).to include("<a rel=\"nofollow\" class=\"social_share_fb\" onclick=\"popUp=window.open(&#39;http://www.facebook.com/sharer.php?u=http%3A%2F%2Fmattrayner.co.uk%2Ffacebook_specific_page&#39;,&#39;popupwindow&#39;,&#39;scrollbars=yes,width=800,height=400&#39;);popUp.focus();return false\" href=\"http://www.facebook.com/\">Share on Facebook</a>")
          end

          it 'generates the expected twitter tag' do
            expect( social_share_tags(@options) ).to include("<a rel=\"nofollow\" class=\"social_share_tw\" onclick=\"popUp=window.open(&#39;http://twitter.com/intent/tweet?text=Matt Rayner - A full-stack Rubyist in London http%3A%2F%2Fmattrayner.co.u%2Ftwitter_specific_page&#39;,&#39;popupwindow&#39;,&#39;scrollbars=yes,width=800,height=400&#39;);popUp.focus();return false\" href=\"http://twitter.com/\">Share on Twitter</a>")
          end
        end
      end
    end

    context 'with invalid options' do
      context 'with no options' do
        it 'raises a SocialSharer::OptionsError as expected' do
          expect{ social_share_tags(nil) }.to raise_error(StandardError, 'Options parameter cannot be nil')
        end
      end

      context 'without individual_settings set' do
        before :each do
          @options = {
                       url: 'http://thisisbd.com',
                       twitter_message: 'This is BD - A creative agency in London',
                       twitter_handle: '@thisisbd'
                     }
        end

        context 'when missing a root parameter' do
          it 'raises the expected SocialSharer::OptionsError with the expected message' do
            root_parameters = %w( url twitter_message )

            root_parameters.each do |param|
              opts = @options.deep_dup
              opts.delete(param.to_sym)

              expect{ social_share_tags(opts) }.to raise_error(StandardError, "Unexpected options - expected [\"#{param}\"] to be present")
            end
          end
        end
      end

      context 'with individual_settings set' do
        before :each do
          @options = {
                        individual_settings: true,

                        twitter: {
                          url: 'http://mattrayner.co.uk/twitter_specific_page',
                          handle: '@mattrayner',
                          message: 'Matt Rayner - A full-stack Rubyist in London'
                        },

                        facebook: {
                          url: 'http://mattrayner.co.uk/facebook_specific_page'
                        }
                      }
        end

        context 'when missing a root parameter' do
          it 'raises the expected SocialSharer::OptionsError with the expected message' do
            root_parameters = %w( facebook twitter )

            root_parameters.each do |param|
              opts = @options.deep_dup
              opts.delete(param.to_sym)

              expect{ social_share_tags(opts) }.to raise_error(StandardError, "Unexpected options - expected [\"#{param}\"] to be present")
            end
          end
        end

        context 'when missing a twitter parameter' do
          it 'raises the expected SocialSharer::OptionsError with the expected message' do

            parameters = %w( url message )

            parameters.each do |param|
              opts = @options.deep_dup
              opts[:twitter].delete(param.to_sym)

              expect{ social_share_tags(opts) }.to raise_error(StandardError, "Unexpected options - expected [\"twitter - #{param}\"] to be present")
            end
          end
        end

        context 'when missing a facebook parameter' do
          it 'raises the expected SocialSharer::OptionsError with the expected message' do
            parameters = %w( url )

            parameters.each do |param|
              opts = @options.deep_dup
              opts[:facebook].delete(param.to_sym)

              expect{ social_share_tags(opts) }.to raise_error(StandardError, "Unexpected options - expected [\"facebook\", \"facebook - #{param}\"] to be present")
            end
          end
        end
      end
    end
  end
end
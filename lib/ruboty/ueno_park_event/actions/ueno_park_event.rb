require 'nokogiri'
require 'open-uri'

module Ruboty
  module UenoParkEvent
    module Actions
      class UenoParkEvent < Ruboty::Actions::Base
        def call
          message.reply(ueno_park_event_text)
        rescue => e
          message.reply(e.message)
        end

        private

        def ueno_park_event_text
          title_and_link = ueno_park_events.map {|e|
            "#{e[:text]}#{$/}#{e[:url]}"
          }.join($/)

          image_urls = ueno_park_events.map {|e|
            e[:image_url]
          }.join($/)

          "#{title_and_link}#{$/*3}#{image_urls}"
        end

        def ueno_park_events
          ueno_park_event_doc.search('.exblock .exbox').map {|ev|
            {
              text:      ev.at_css('.extext h3').text.chomp,
              url:       ev.at_css('.extext h3 a')['href'],
              image_url: ev.at_css('.exleaf img')['src']
            }
          }
        end

        def ueno_park_event_doc
          @ueno_park_event_doc ||= Nokogiri::HTML(ueno_park_event_html)
        end

        def ueno_park_event_html
          @ueno_park_event_html ||= OpenURI.open_uri(ueno_park_event_url)
        end

        def ueno_park_event_url
          'http://museum.guidenet.jp/'
        end
      end
    end
  end
end

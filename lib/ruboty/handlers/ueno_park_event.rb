module Ruboty
  module Handlers
    class UenoParkEvent < Base
      on /上野(公園)?(の?イベント)?.*/, name: 'ueno_park_event', description: '上野公園のイベント'

      def ueno_park_event(message)
        Ruboty::UenoParkEvent::Actions::UenoParkEvent.new(message).call
      end
    end
  end
end

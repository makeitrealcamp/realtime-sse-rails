class ClockController < ApplicationController
  include ActionController::Live

  def index
  end

  def get_time
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, retry: 300, event: "notification")

    begin
      loop do
        sse.write({ date: Time.now })
        sleep 1
      end
    rescue
      # log ...
    ensure
      sse.close
    end
  end
end

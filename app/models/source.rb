module TrafficSpy
  class Source < ActiveRecord::Base
    has_many :payloads
    validates_presence_of :identifier, :root_url
    validates :identifier, uniqueness: true

    # def find_payloads
    #   Payload.find_by(source_id: self.id)
    # end

    def list_urls

      payloads.group(:url).order('count_url DESC').count(:url)

      # keys = payloads.group(:url).order('count_url DESC').count(:url).keys
      # keys.each do |key|
      #   payloads.group(:url).order('count_url DESC').count(:url)
      # end
    end

    def list_response_times
      payloads.group(:url).order('average_responded_in DESC').average(:responded_in)
    end

    def list_resolution
      width = payloads.group(:resolution_width).order('count_resolution_width DESC').count(:resolution_width)
      height = payloads.group(:resolution_height).order('count_resolution_height DESC').count(:resolution_height)
      width.keys.zip(height.keys).map { |inner_array| inner_array.join("x")}.zip(width.values)
    end

  end
end

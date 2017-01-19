module GuessHelper
  class GuessClient
    include HTTParty
    base_uri Rails.configuration.external_services['animal_guess_uri']

    def initialize(height, weight)
      @options = { query: { height: height, weight: weight } }
    end

    def guess_id
      self.class.get('/', @options)['favorite_animal_guess_id']
    end
  end

  def self.height_weight(params)
    # Might be using something like this https://github.com/nicolasblanco/rails_param
    height_ft = Integer(params[:height_ft])
    height_in = Integer(params[:height_in])
    weight_lb = Integer(params[:weight_lb])

    total_height_in = 12 * height_ft + height_in

    [total_height_in, weight_lb]
  end

  def self.get_guess_id(height_in, weight_lb)
    guess_client = GuessClient.new(height_in, weight_lb)
    guess_client.guess_id
  end
end

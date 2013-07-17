class AgentController < ApplicationController
  respond_to :html
  require 'data_parser'

  def create
    case params[:url]
    when "http://utopia-game.com/wol/game/throne"
      sot = DataParser.parse_self_sot(params[:data])
      @sot = Sot.new(sot)
      respond_to do |format|
        if @sot.save
          return head :created
        else
          return head :unprocessable_entity
        end
      end
    when "http://utopia-game.com/wol/game/council_military"
      som = DataParser.parse_self_som(params[:data])
      @som = Som.new(som)
      respond_to do |format|
        if @som.save
          return head :created
        else
          return head :unprocessable_entity
        end
      end
    else
      return head :not_found
    end
  end

end

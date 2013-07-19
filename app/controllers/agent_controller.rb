class AgentController < ApplicationController
  respond_to :html
  require 'data_parser'

  def create
    case params[:url]
    when "http://utopia-game.com/wol/game/throne"
      @sot = Sot.from_page(params[:data], params[:prov])
      if @sot.save
        return head :created
      else
        return head :unprocessable_entity
      end
    when "http://utopia-game.com/wol/game/council_military"
      @som = Som.from_page(params[:data], params[:prov])
      if @som.save
        return head :created
      else
        return head :unprocessable_entity
      end
    else
      return head :not_found
    end
  end

end

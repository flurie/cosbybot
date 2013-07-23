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

    when /http:\/\/utopia-game\.com\/wol\/game\/thievery/ ||
        /http:\/\/utopia-game\.com\/wol\/game\/sorcery/
      Uid.create_from_list(params[:data])
      op = DataParser.parse_op_type params[:data],params[:url],params[:prov]
        if op && op[:success]
          op = DataParser.parse_op_damage params[:data], op
        end
      @op = Op.new(op)
      unless @op.save
        raise "Op could not be created!"
      end
      return head :created
    else
      return head :not_found
    end
  end

end

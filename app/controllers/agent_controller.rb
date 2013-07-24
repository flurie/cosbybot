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
          if DataParser::INTEL_OPS.include? op[:opname]
            #parse appropriate intel op
            case op[:opname]
              when "SPY_ON_THRONE"
              @sot = Sot.enemy_from_page params[:data], op[:target]
              unless @sot.save
                raise "Sot could not be created!"
              end
            end
          else
            #otherwise parse as a damage op
            op = DataParser.parse_op_damage params[:data], op
          end
        end
      @op = Op.new(op)
      @op.save
      return head :created
    when /http:\/\/utopia-game\.com\/wol\/game\/kingdom_details/
      data = DataParser.parse_kingdom_page(params[:data])
      @kingdom = Kingdom.new data[0]
      @kingdom.save
      data[1].each do |prov|
        @prov = MiniSot.new prov
        @prov.save
      end
      return head :created
    else
      return head :not_found
    end
  end

end

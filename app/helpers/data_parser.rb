module DataParser
  require 'nokogiri'  

  #parses a self-made SoT
  def DataParser.parse_self_sot(data)
    data = Nokogiri::HTML(data)
    sot = {}
    data.css("h2")[2].children.text.match(/The Province of ([\d\w\s]+) \((\d{1,2}:\d{1,2})\)([\d\w\s]+) \(/)
    sot[:name] = $1
    sot[:loc] = $2
    sot[:utodate] = $3
    stats = data.css(".two-column-stats tbody tr td")
    sot[:race] = stats[0].text
    sot[:soldiers] = stats[1].text
    ruler = stats[2].text
    if ruler.match(/^The Wealthy/)
      sot[:pers] = "Merchant"
    elsif ruler.match(/^The Wise/)
      sot[:pers] = "Sage"
    elsif ruler.match(/^The Conniving/)
      sot[:pers] = "Tactician"
    elsif ruler.match(/The Rogue$/)
      sot[:pers] = "Rogue"
    elsif ruler.match(/The Sorceror$/) or ruler.match(/The Sorceress$/)
      sot[:pers] = "Mystic"
    elsif ruler.match(/The Warrior$/)
      sot[:pers] = "Warrior"
    elsif ruler.match(/The Blessed$/)
      sot[:pers] = "Cleric"
    elsif ruler.match(/The Hero$/)
      sot[:pers] = "War Hero"
    else
      sot[:pers] = nil
    end
    sot[:ospecs] = stats[3].text.delete ","
    sot[:land] = stats[4].text.delete ","
    sot[:dspecs] = stats[5].text.delete ","
    sot[:peasants] = stats[6].text.delete ","
    sot[:elites] = stats[7].text.delete ","
    sot[:be] = stats[8].text.to_i
    stats[9].text.match(/\s+([\d,]+) \((\d+)/)
    sot[:thieves] = $1.delete ","
    sot[:stealth] = $2.delete ","
    sot[:money] = stats[10].text.delete ","
    stats[11].text.match(/\s+([\d,]+) \((\d+)/)
    sot[:wizards] = $1.delete ","
    sot[:mana] = $2
    sot[:food] = stats[12].text.delete ","
    sot[:horses] = stats[13].text.delete ","
    sot[:runes] = stats[14].text
    sot[:prisoners] = stats[15].text.delete ","
    sot[:tb] = stats[16].text.delete ","
    sot[:off] = stats[17].text.delete ","
    sot[:nw] = stats[18].text.delete ","
    sot[:def] = stats[19].text.delete ","
    messages = data.css(".advice-message").text
    sot[:war] = messages.match(/WAR/) ? true : false
    sot[:dragon] = messages.match(/(Ruby|Gold|Sapphire|Emerald) Dragon/) ? $1 : nil
    sot[:plague] = messages.match(/Plague/) ? true : false
    return sot
  end

  def DataParser.parse_self_som(data)
    data = Nokogiri::HTML(data)
    som = {}
    mil_details = data.css(".game-content p")[2].text
    som[:mil_percent] = mil_details.match(/approximately (\d{1,3}\.\d)/)[1]
    som[:wage] = mil_details.match(/wage rate is (\d{1,3}\.\d)/)[1]
    som[:me] = mil_details.match(/functioning at (\d{1,3}\.\d)/)[1]
    mil_details = data.css(".two-column-stats tbody tr td")
    som[:ome] = mil_details[0].text.delete("%")
    som[:off] = mil_details[1].text.delete(",")
    som[:dme] = mil_details[2].text.delete("%")
    som[:def] = mil_details[3].text.delete(",")
    armies = data.css(".data thead tr th").length
    army_out_details = data.css(".data thead tr th")
    army_details = data.css(".data tbody tr td")
    #set all values to nil until otherwise noted
    (1..5).each do |num|
      som[("gens_" + num.to_s).to_sym] = nil
      som[("soldiers_" + num.to_s).to_sym] = nil
      som[("ospecs_" + num.to_s).to_sym] = nil
      som[("dspecs_" + num.to_s).to_sym] = nil
      som[("elites_" + num.to_s).to_sym] = nil
      som[("horses_" + num.to_s).to_sym] = nil
      som[("land_" + num.to_s).to_sym] = nil
    end
    #armies are always home, so do these
    som[:gens_home] = army_details[armies*0].text.delete(",")
    som[:soldiers_home] = army_details[armies*1].text.delete(",")
    som[:ospecs_home] = army_details[armies*2].text.delete(",")
    som[:dspecs_home] = army_details[armies*3].text.delete(",")
    som[:elites_home] = army_details[armies*4].text.delete(",")
    som[:horses_home] = army_details[armies*5].text.delete(",")
    (1..(armies - 1)).each do |num| # subtract one, it's always home
      unless army_out_details[num].text.match(/Undeployed Army/)
        #army is actually out, get values
        som[("gens_" + num.to_s).to_sym] = army_details[armies*0+num].text.delete(",")
        som[("soldiers_" + num.to_s).to_sym] = army_details[armies*1+num].text.delete(",")
        som[("ospecs_" + num.to_s).to_sym] = army_details[armies*2+num].text.delete(",")
        som[("dspecs_" + num.to_s).to_sym] = army_details[armies*3+num].text.delete(",")
        som[("elites_" + num.to_s).to_sym] = army_details[armies*4+num].text.delete(",")
        som[("horses_" + num.to_s).to_sym] = army_details[armies*5+num].text.delete(",")
        som[("land_" + num.to_s).to_sym] = army_details[armies*6+num].text.delete(",")
      end
    end
    #do training values
    training_details = data.css(".schedule tbody tr td")
    (0..23).each do |num|
      ospecs = training_details[0*24+num].text
      som[("ospecs_training_" + (num+1).to_s).to_sym] = ospecs.empty? ? 0 : ospecs.delete(",") 
      dspecs = training_details[1*24+num].text
      som[("dspecs_training_" + (num+1).to_s).to_sym] = dspecs.empty? ? 0 : dspecs.delete(",")
      elites = training_details[2*24+num].text
      som[("elites_training_" + (num+1).to_s).to_sym] = elites.empty? ? 0 : elites.delete(",")
      thieves = training_details[3*24+num].text
      som[("thieves_training_" + (num+1).to_s).to_sym] = thieves.empty? ? 0 : thieves.delete(",")
    end
    return som
  end
end
  

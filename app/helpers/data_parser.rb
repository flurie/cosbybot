module DataParser
  require 'nokogiri'  

  INTEL_OPS = %w(SPY_ON_THRONE SPY_ON_SCIENCE INFILTRATE SNATCH_NEWS SURVEY SPY_ON_MILITARY)
  
  #parses a self-made SoT
  def DataParser.parse_self_sot(data)
    data = Nokogiri::HTML(data)
    sot = {}
    data.css("h2")[2].children.text.match(/The Province of ([\d\w\s]+) \((\d{1,2}:\d{1,2})\)([\d\w\s]+) \(/)
    sot[:name] = $1
    sot[:loc] = $2
    sot[:utodate] = $3
    sot.merge!(DataParser.parse_two_column_stats(data))
    messages = data.css(".advice-message").text
    sot[:war] = messages.match(/WAR/) ? true : false
    sot[:dragon] = messages.match(/(Ruby|Gold|Sapphire|Emerald) Dragon/) ? $1 : nil
    sot[:plague] = messages.match(/Plague/) ? true : false
    sot[:overpop] = messages.match(/[Oo]verpopulation/)
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

  def DataParser.parse_uids(data)
    data = Nokogiri::HTML(data)
    uids = []
    data.css("select#id_target_province").children.each do |row|
      #if the option is a number, we got a value we can use, save it
      if row.attributes["value"].value =~ /\d+/
        uids << {prov_id: row.attributes["value"].value, name: row.text}
      end
    end
    return uids
  end

  def DataParser.parse_enemy_sot(data)
    data = Nokogiri::HTML(data)
    sot = {}
    data.css("h2")[0].children.text.match(/The Province of ([\d\w\s]+) \((\d{1,2}:\d{1,2})\)([\d\w\s]+) \(/)
    sot[:name] = $1
    sot[:loc] = $2
    sot[:utodate] = $3
    sot.merge!(DataParser.parse_two_column_stats(data))
    messages = data.css(".advice-message").text
    sot[:war] = messages.match(/WAR/) ? true : false
    sot[:dragon] = messages.match(/(Ruby|Gold|Sapphire|Emerald) Dragon/) ? $1 : nil
    sot[:plague] = messages.match(/Plague/) ? true : false
    sot[:overpop] = messages.match(/[Oo]verpopulation/) ? true: false
    return sot
  end
  
  def DataParser.parse_two_column_stats(data)
    sot = {}
    stats = data.css(".two-column-stats tbody tr td")
    sot[:race] = stats[0].text
    sot[:soldiers] = stats[1].text
    ruler = stats[2].text
    case ruler
    when /^The Wealthy/
      sot[:pers] = "Merchant"
    when /^The Wise/
      sot[:pers] = "Sage"
    when /^The Conniving/
      sot[:pers] = "Tactician"
    when /The Rogue$/
      sot[:pers] = "Rogue"
    when /The Sorceror$/  
      sot[:pers] = "Mystic"
    when /The Sorceress$/
      sot[:pers] = "Mystic"
    when /The Warrior$/
      sot[:pers] = "Warrior"
    when /The Blessed$/
      sot[:pers] = "Cleric"
    when /The Hero$/
      sot[:pers] = "War Hero"
    else
      sot[:pers] = nil
    end
    if %w(Merchant Sage Tactician).include? sot[:pers]
      ruler.match /^The \w+ (Sir|Lady|Lord|Noble Lady|Baron|Baroness|Viscount|Viscountess|Count|Countess|Marquis|Marchioness|Duke|Duchess|Prince|Princess)/
    else
      ruler.match /^(Sir|Lady|Lord|Noble Lady|Baron|Baroness|Viscount|Viscountess|Count|Countess|Marquis|Marchioness|Duke|Duchess|Prince|Princess)/
    end
    sot[:rank] = $1 || "Peasant"
    sot[:ospecs] = stats[3].text.delete ","
    sot[:land] = stats[4].text.delete ","
    sot[:dspecs] = stats[5].text.delete ","
    sot[:peasants] = stats[6].text.delete ","
    sot[:elites] = stats[7].text.delete ","
    sot[:be] = stats[8].text.to_i
    if stats[9].text.match(/\s+([\d,]+) \((\d+)/)
      #only self-intel will show this, so only add it if it's there
      sot[:thieves] = $1.delete ","
      sot[:stealth] = $2.delete ","
    end
    sot[:money] = stats[10].text.delete ","
    if stats[11].text.match(/\s+([\d,]+) \((\d+)/)
      #only self-intel will show this, so only add it if it's there
      sot[:wizards] = $1.delete ","
      sot[:mana] = $2.delete ","
    end
    sot[:food] = stats[12].text.delete ","
    sot[:horses] = stats[13].text.delete ","
    sot[:runes] = stats[14].text.delete ","
    sot[:prisoners] = stats[15].text.delete ","
    sot[:tb] = stats[16].text.delete ","
    sot[:off] = stats[17].text.delete ","
    sot[:nw] = stats[18].text.delete ","
    sot[:def] = stats[19].text.delete ","
    return sot
  end

  def DataParser.parse_op_type data, url, provname
    op = {}
    data = Nokogiri::HTML data
    if url.match /[?&]p=(\d+)/
      op[:target] = $1
    else
      #if there's no op, return false
      return false
    end
    if url.match /[?&]q=(\d+)/
      op[:thieves_sent] = $1
    end
    if url.match /[?&]o=([\w_]+)/
      op[:opname] = $1
    end
    op[:success] = data.css(".good").empty? ? false : true

    #check for losses
    failure = data.css(".bad")
    if !failure.empty?
      if failure.text.match(/We lost ([\d,]+) thieves/) ||
          failure.text.
          match(/([\d,]) of our wizards were killed in an explosion!/)
        op[:losses] = $1
      end
    end
    op[:source] = (Uid.find_by name: CGI.unescape(provname)).prov_id
    return op
  end

  def DataParser.parse_op_damage data, op
    data = Nokogiri::HTML data
    match_url = case op[:opname]
                when "ROB_THE_GRANARIES"
                  /Our thieves have returned with ([\d,]+) bushels./
                when "ROB_THE_VAULTS"
                  /Our thieves have returned with ([\d,]+) gold coins./
                when "ROB_THE_TOWERS"
                  /Our thieves were able to steal ([\d,]+) runes./
                when "KIDNAPPING"
                  /Our thieves kidnapped many people, but only were able to return with ([\d,]+) of them./
                when "ARSON"
                  /Our thieves burned down ([\d,]+) acres of buildings./
                when "GREATER_ARSON"
                  /Our thieves burned down ([\d,]+) ([\w\s]+)./
                when "NIGHT_STRIKE"
                  /Our thieves assassinated ([\d,]+) enemy troops./
                when "INCITE_RIOTS"
                  /Our thieves have caused rioting. It is expected to last ([\d,]+) days./
                when "STEAL_WAR_HORSES"
                  /Our thieves were able to release ([\d,]+) horses but could only bring back ([\d,]+) of them./
                when "FREE_PRISONERS"
                  /Our thieves freed ([\d,]+) prisoners from enemy dungeons./
                when "ASSASSINATE_WIZARDS"
                  /Our thieves assassinated ([\d,]+) wizards of the enemy's guilds!/
                when "PROPAGANDA"
                  /We have converted ([\d,]+) (wizards|thieves|soldiers|of the enemy's specialist troops|\w+ from the enemy)/
                when "STORMS"
                  /Storms will ravage .* for (\d+) days!/
                when "DROUGHTS"
                  /A drought will reign over the lands of .* for (\d+) days!/
                when "VERMIN"
                  /Vermin will feast on the granaries of .* for (\d+) days./
                when "GREED"
                  /Our mages have caused our enemy's soldiers to turn greedy for (\d+) days./
                when "FOOLS_GOLD"
                  /Our mages have turned ([\d,]+) gold coins in .* to worthless lead./
                when "PITFALLS"
                  /Pitfalls will haunt the lands of .* for (\d+) days./
                when "CHASTITY"
                  /Much to the chagrin of their men, the womenfolk of .* have taken a vow of chastity for (\d+) days!/
                when "LIGHTNING_STRIKE"
                  /Lightning strikes the Towers in .* and incinerates ([\d,]+) runes!/
                when "EXPLOSIONS"
                  /Explosions will rock aid shipments to and from .* for (\d+) days!/
                when "AMNESIA"
                  /You were able to make the people of .* temporarily forget ([\d,]+) books of knowledge!/
                when "NIGHTMARES"
                  /During the night, ([\d,]+) of the men in the armies and thieves' guilds of .* had nightmares./
                when "MYSTIC_VORTEX"
                  /A magic vortex overcomes the province of .*, negating ([\d]+) active spells./
                when "METEOR_SHOWERS"
                  /Meteors will rain across the lands of .* for (\d+) days/
                when "TORNADOES"
                  /Tornadoes scour the lands of .*, laying waste to ([\d,]+) acres of buildings!/
                when "LAND_LUST"
                  /Our Land Lust over .* has given us ([\d,]+) new acres of land!/
                else
                  return op
                end
    optext = data.css(".good").text
    optext.match match_url
    #all successful ops that can have magnitude will have 0 if nothing else
    op[:magnitude] = $1 || 0
    case op[:opname]
    when "PROPAGANDA"
      #check for successful props but 0 conversions
      if optext.match(/so few (\w+) were found/) ||
          optext.match(/no enemy (\w+) were converted/)
        op[:opname] += "_" + $1.gsub("specialists", "specs").upcase
      else
        #check for prop type
        case $2
        when "of the enemy's specialist troops"
          op[:opname] += "_SPECS"
        when "wizards"
          op[:opname] += "_WIZARDS"
        when "thieves"
          op[:opname] += "_THIEVES"
        when "soldiers"
          op[:opname] += "_SOLIDERS"
        when "Drakes", "Berserkers", "Elf Lords", "Beastmasters", "Brutes",
          "Knights", "Ogres", "Ghouls"
          op[:opname] += "_ELITES"
        end
      end
    when "GREATER_ARSON"
      op[:opname] +=  "_" + $2.gsub(" ", "_").upcase
      op[:magnitude] = $1
    when "MYSTIC_VORTEX"
      op[:magnitude] = []
      ["Minor Protection", "Greater Protection", "Magic Shield", "Mystic Aura",
       "Fertile Lands", "Nature's Blessing", "Love & Peace", "Quick Feet",
       "Builders' Boon", "Inspire Army", "Anonymity", "Invisibility",
       "Clear Sight", "War Spoils", "Fanaticism", "Mage's Fury", "Town Watch",
       "Agression", "Fountain of Knowledge", "Animate Dead", "Reflect Magic",
       "Shadowlight", "Bloodlust", "Patriotism", "Storms", "Droughts",
       "Vermin", "Greed", "Pitfalls", "Chastity", "Explosions",
       "Meteor Showers"].each do |spell|
        if optext.match spell
          op[:magnitude] << spell
        end
      end
      if op[:magnitude].empty?
        op[:magnitude] = nil
      end
    else
      return op
    end
  end

  def DataParser.parse_kingdom_page data
    kingdom = {}
    data = Nokogiri::HTML data
    data.css(".kingdom-label").text.match(/([\w\s]+) \((\d:\d{1,2})\)/)
    kingdom[:name] = $1
    kingdom[:loc] = $2
    two_column_stats = data.css ".two-column-stats td"
    kingdom[:provinces] = two_column_stats[0].text
    kingdom[:stance] = two_column_stats[1].text
    two_column_stats[2].text.match(/([\d,]+)gc \(/)
    kingdom[:nw] = $1.delete ","
    two_column_stats[3].text.match(/(\d+) \/ (\d+)/)
    kingdom[:wins] = $1
    kingdom[:wars] = $2
    two_column_stats[4].text.match(/([\d,]+) acres/)
    kingdom[:land] = $1.delete ","
    kingdom[:war] = data.text.match(/currently at war with/) ? true : false
    provinces = []
    (0..(kingdom[:provinces].to_i-1)).each do |i|
      province = {}
      if data.css(".tablesorter tbody td")[i*7+1].text.match("-")
        #skip empty provs
        next
      end
      data.css(".tablesorter tbody td a")[i].attributes["href"].value.
        match(/(\d+)$/)
      province[:name] = data.css(".tablesorter tbody td a")[i].text
      province[:slot] = $1
      data.css(".tablesorter tbody td")[i*7+1].text.match(/(\w[\w\s]+[\*\^]?)/)
      stats = $1
      province[:online] = stats.match(/\*/) ? true : false
      province[:protection] = stats.match(/\^/) ? true : false
      province[:race] = data.css(".tablesorter tbody td")[i*7+2].text
      data.css(".tablesorter tbody td")[i*7+3].text.match(/([\d,]+)/)
      province[:land] = $1.delete ","
      data.css(".tablesorter tbody td")[i*7+4].text.match(/([\d,]+)/)
      province[:nw] = $1.delete ","
      province[:rank] = data.css(".tablesorter tbody td")[i*7+6].text
      provinces << province
    end
    return [kingdom, provinces]
  end
end

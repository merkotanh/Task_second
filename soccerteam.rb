#---
#calculate the ranking table for a soccer league
#---
class Soccer_team
  def initialize
    @team = []
    @teamh = Hash.new(0)
    @indx = []
    ARGF.each do |line|
      @team << line.chomp.split(/[\n,]/).map(&:lstrip)
    end
  end

  def name_score(tm1, tm2, op, sc1, sc2)
    if tm1[/\d+/].send(op, tm2[/\d+/])
      @teamh[tm1[/\D+/]] += sc1
      @teamh[tm2[/\D+/]] += sc2
    end
  end

  def read_league
    @team.each do |team1, team2|                  # each line in @team == each match
      name_score(team1, team2, :>, 3, 0)          # win = 3, lose = 0, eql =1
      name_score(team1, team2, :==, 1, 1)
    end
    @team = @teamh.sort_by { |k,v| v}.reverse     # sort
    @indx = (1..@team.count).to_a                 # line number for output
    @team = @indx.zip(@team)                      # add index number

    #@team.each.with_index { |val,index| puts "#{val}"} # output in [] :(
  
    puts  @team.map{ |e|                          # if do..end instead of {..} output'd be #<Enumerator:0x0000562d3c123328>
      result = "#{e[0]}. #{e[1][0]}, #{e[1][1]}"  # plural or single 
      e[1][1]== 1 ? result + ' pt' : result + ' pts'
    }
  end
end

puts Soccer_team.new.read_league
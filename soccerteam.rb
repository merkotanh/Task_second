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
    @team.each do |team1, team2|             # each line == each match
      name_score(team1, team2, :>, 3, 0)     # win = 3, lose = 0, eql =1
      name_score(team1, team2, :==, 1, 1)
    end
    @team = @teamh.sort_by{|k,v| v}.reverse  # sort
    @indx = (1..@team.count).to_a            # line number for output
    @team = @indx.zip(@team)                 # add index number
  
    puts  @team.map{ |e| 
      e[1][1]== 1 ?                          # find plural and single
      e[0].to_s + '. ' + e[1][0].to_s + e[1][1].to_s + ' pt' : 
      e[0].to_s + '. ' + e[1][0].to_s + e[1][1].to_s + ' pts'
    }
  end
end

puts Soccer_team.new.read_league
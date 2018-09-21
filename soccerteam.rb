
team = []
teamh = Hash.new(0)
indx = []

ARGF.each do |line|
  team << line.chomp.split(/[\n,]/).map(&:lstrip)
end

team.each do |team1, team2|     # each line == each match
  score1 = team1[/\d+/]			# get score from the string
  score2 = team2[/\d+/]
  tname1 = team1[/\D+/]			# extracts team name 
  tname2 = team2[/\D+/]
  if score1 > score2
    teamh[tname1] += 3
    teamh[tname2] += 0
  end
  if score1 == score2
    teamh[tname1] += 1
    teamh[tname2] += 1
  end
end

team = teamh.sort_by{|k,v| v}.reverse  # sort

indx = (1..team.count).to_a 	# line number for output

team = indx.zip(team)	# add index number

puts  team.map{ |e| 
  e[1][1]== 1 ? 		# find plural and single
  e[0].to_s + '. ' + e[1][0].to_s + e[1][1].to_s + ' pt' : 
  e[0].to_s + '. ' + e[1][0].to_s + e[1][1].to_s + ' pts'
}

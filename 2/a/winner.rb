# Codeforces, Problem 2A
# http://codeforces.com/contest/1/problem/C
# Nate Collings

def get_names_scores(num)
  names = []
  scores = []
  num.times do
    player, score = gets.chomp.split("\s")
    names << player
    scores << score.to_i
  end
  return names, scores
end

def get_max(players)
  max = players.values.map { |v| v }.max
  with_max = players.select { |_,v| v == max}
  return max, with_max
end

def run_round(rounds, names, scores, players=nil, second=false)
  max, with_max = get_max(players) if second
  players = {}
  rounds.times do |round|
    player = names[round]
    score = scores[round]
    if !second || with_max.has_key?(player)
      score += players[player] if players.has_key?(player)
      players[player] = score
      return player if second && score >= max
    end
  end
  players
end

def first_round(rounds, names, scores)
  run_round(rounds, names, scores)
end

def second_round(rounds, names, scores, players)
  run_round(rounds, names, scores, players, true)
end

def solve
  rounds = gets.chomp.to_i
  names, scores = get_names_scores(rounds)

  candidates = first_round(rounds, names, scores)
  return candidates.keys[0] if candidates.length == 1
  return second_round(rounds, names, scores, candidates)
end

puts solve

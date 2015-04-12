# Codeforces, Problem 1A
# http://codeforces.com/problemset/problem/1/A
# Nate Collings

def solve(n, m, a)
  horizontal_req = (n * 1.0 / a).ceil
  vert_req = (m * 1.0 / a).ceil
  horizontal_req * vert_req
end

n, m, a = gets.chomp.split("\s").map { |x| x.to_i }
puts solve(n, m, a)

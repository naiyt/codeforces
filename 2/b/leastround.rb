# Codeforces, Problem 2B
# http://codeforces.com/contest/1/problem/C
# Nate Collings

def cust_count(num, divisor)
  count = 0
  while num % divisor == 0
    count += 1
    num /= divisor
  end
  count
end

def table_init(n)
  n.times.map { [0] * n }
end

def solve(matrix)
  n = matrix.length
  twos = table_init(n)
  fives = table_init(n)
  x = -1
  y = -1

  n.times do |i|
    n.times do |j|
      num = matrix[i][j]
      if num == 0
        twos[i][j] = 1
        fives[i][j] = 1
        x = i
        y = j
      else
        twos[i][j] = cust_count(num, 2)
        fives[i][j] = cust_count(num, 5)
      end
    end
  end

  twos_table = make_table(twos, n)
  fives_table = make_table(fives, n)

  if x < 0 || Math.min(twos_table[n-1][n-1], fives_table[n-1][n-1]) == 0
    return solution(twos, twos_table, n) if (twos_table[n-1][n-1] < fives_table[n-1][n-1])
    return solution(fives, fives_table, n)
  else
    sol = "1\n"
    x.times { sol += 'D' }
    y.times { sol += 'R' }
    (n-x).times { sol += 'D' }
    (y-x).times { sol += 'R' }
    return sol
  end
end

def make_table(table, n)
  dynamic_table = table_init(n)
  dynamic_table[0][0] = table[0][0]
  (1...n).each { |i| dynamic_table[0][i] = dynamic_table[0][i-1] + table[0][i] }
  (1...n).each { |i| dynamic_table[i][0] = dynamic_table[i-1][0] + table[i][0] }
  (1...n).each do |i|
    (1...n).each do |j|
      dynamic_table[i][j] = [dynamic_table[i-1][j], dynamic_table[i][j-1] + table[i][j]].min
    end
  end
  dynamic_table
end

def solution(table, dynamic, n)
  start = "#{dynamic[n-1][n-1]}\n"
  sol = ''
  i = n - 1
  j = n - 1
  while i != 0 || j != 0
    if i == 0
      sol += 'R'
      j -= 1
    elsif j == 0
      sol += 'D'
      i -= 1
    else
        if dynamic[i][j] - table[i][j] == dynamic[i-1][j]
          sol += 'D'
          i -= 1
        else
          sol += 'R'
          j -= 1
        end
    end
  end
  start + sol.reverse
end

def matrix(n)
  n.times.map { gets.chomp.split("\s").map { |x| x.to_i } }
end

puts solve(matrix(gets.chomp.to_i))
# Codeforces, Problem 1B
# http://codeforces.com/contest/1/problem/B
# Nate Collings

def first_int(cell)
  cell.split('').each_with_index do |char, i|
    begin
      Integer(char)
      return i
    rescue ArgumentError
    end
  end
end

def abc_to_int(str)
  num = 0
  power = 1
  str.reverse.split('').each do |char|
    num += (char.ord - 'A'.ord + 1) * power
    power *= 26
  end
  num
end

def convert_row_col_to_standard(r, c)
  dividend = c
  column = ''
  while dividend > 0
    remainder = (dividend - 1) % 26
    column = (65 + remainder).chr + column
    dividend = ((dividend - remainder) / 26).to_i
  end
  "#{column}#{r}"
end

def to_standard(cell)
  c_index = cell.index('C')
  row = cell[1...c_index].to_i
  col = cell[c_index+1..-1].to_i
  convert_row_col_to_standard(row, col)
end

def to_rxcy(cell)
  r_index = first_int(cell)
  col = abc_to_int(cell[0...r_index])
  row = cell[r_index..-1]
  "R#{row}C#{col}"
end

def is_rxcy?(cell)
  /R[0-9]+C[0-9]+/.match(cell)
end

gets.chomp.to_i.times do
  cell = gets.chomp
  if is_rxcy?(cell)
    puts to_standard(cell)
  else
    puts to_rxcy(cell)
  end
end

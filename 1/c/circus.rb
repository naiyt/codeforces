# Codeforces, Problem 1C
# http://codeforces.com/contest/1/problem/C
# Nate Collings

Point = Struct.new(:x, :y)

def angle(a, r)
  val = 1.0 - a**2 / (2.0 * r**2)
  val = 1.0 if val > 1.0
  val = -1.0 if val < -1.0
  Math.acos(val) / (2.0 * Math::PI)
end

def near?(f)
  (f - f.round).abs < 1e-4
end

def distance(point1, point2)
  x_diff = point1.x - point2.x
  y_diff = point1.y - point2.y
  Math.sqrt(x_diff**2 + y_diff**2)
end

def get_radius(a, b, c)
  s = (a + b + c) / 2.0
  area = Math.sqrt(s * (s - a) * (s - b) * (s - c))
  a * b * c / (4 * area)
end

def solve(pillars)
  side_a = distance(pillars[0], pillars[1])
  side_b = distance(pillars[1], pillars[2])
  side_c = distance(pillars[2], pillars[0])
  radius = get_radius(side_a, side_b, side_c)
  angle1 = angle(side_a, radius)
  angle2 = angle(side_b, radius)
  angle3 = angle(side_c, radius)
  n = 2
  while n <= 99
    n += 1
    break if near?(n * angle1) && near?(n * angle2) && near?(n * angle3)
  end
  n * 0.5 * radius**2 * Math.sin(Math::PI * 2.0 / n)
end

def get_pillars(n)
  pillars = n.times.map { gets.chomp.split("\s").map { |x| x.to_f } }
  pillars.map { |p| Point.new(p[0], p[1]) }
end

puts solve(get_pillars(3))

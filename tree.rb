require "./fude"

def deg2rad(deg)
  deg * Math::PI / 180
end

def tree(n, x0, y0, l, ang)
  return if n < 0
  x1 = x0 + Math::cos(deg2rad(ang)) * l
  y1 = y0 + Math::sin(deg2rad(ang)) * l
  line(x0, y0, x1, y1, @n - n + 1)
  @lines += 1
  tree(n - 1, x1, y1, l*0.7, ang-20)
  tree(n - 1, x1, y1, l*0.7, ang+20)
end

script do
  @n = 0

  (1..14).each do |n|
    @n = n
    yld 60
  end
end

draw do
  cls 0
  @lines = 0
  tree(@n, 127, 255, 70, -90)
  print("n = #{@n} (#{@lines} lines)", 10, 10, 7)
end

run("tree")

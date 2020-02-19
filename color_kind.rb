require "./fude"

script do
  loop do
    @i = 0

    @text = "色番号のサンプルです。"
    yld 120
    @text = ""

    1.upto(16) do |e|
      @i = e
      yld 8
    end

    yld 120
  end
end

draw do
  cls
  tile(@i)
  print(@text, 32, 128 - 8, 7)
end

def tile_n(x, y, n)
  x *= 64
  y *= 64
  rectfill x, y, 64, 64, n
  c = n >= 6 ? 0 : 7
  a = ["黒", "濃紺", "紫", "緑", "茶", "泥", "灰", "白", "赤", "橙", "黄", "黄緑", "青", "藍", "淡紅", "桃"]
  print "#{n}\n#{a[n]}", x + 12, y + 4, c
end

def tile(n)
  return if n == 0
  tile_n(0, 0, 0)
  return if n == 1
  tile_n(1, 0, 1)
  return if n == 2
  tile_n(2, 0, 2)
  return if n == 3
  tile_n(3, 0, 3)
  return if n == 4
  tile_n(0, 1, 4)
  return if n == 5
  tile_n(1, 1, 5)
  return if n == 6
  tile_n(2, 1, 6)
  return if n == 7
  tile_n(3, 1, 7)
  return if n == 8
  tile_n(0, 2, 8)
  return if n == 9
  tile_n(1, 2, 9)
  return if n == 10
  tile_n(2, 2, 10)
  return if n == 11
  tile_n(3, 2, 11)
  return if n == 12
  tile_n(0, 3, 12)
  return if n == 13
  tile_n(1, 3, 13)
  return if n == 14
  tile_n(2, 3, 14)
  return if n == 15
  tile_n(3, 3, 15)
end

run("fude", 1)

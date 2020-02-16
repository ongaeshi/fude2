require "./fude"

script do
  loop do
    @i = 0

    @text = "Color Kind"
    yld 30
    @text = ""

    1.upto(16) do |e|
      @i = e
      yld 8
    end

    yld 60
  end
end

draw do
  cls
  tile(@i)
  print(@text, 16, 64 - 4, 7)
end

def tile_n(x, y, n)
  rectfill x, y, 32, 32, n
  c = n == 7 ? 0 : 7
  print n.to_s, x + 12, y + 12, c
end

def tile(n)
  return if n == 0
  tile_n(0, 0, 0)
  return if n == 1
  tile_n(32, 0, 1)
  return if n == 2
  tile_n(64, 0, 2)
  return if n == 3
  tile_n(96, 0, 3)
  return if n == 4
  tile_n(0, 32, 4)
  return if n == 5
  tile_n(32, 32, 5)
  return if n == 6
  tile_n(64, 32, 6)
  return if n == 7
  tile_n(96, 32, 7)
  return if n == 8
  tile_n(0, 64, 8)
  return if n == 9
  tile_n(32, 64, 9)
  return if n == 10
  tile_n(64, 64, 10)
  return if n == 11
  tile_n(96, 64, 11)
  return if n == 12
  tile_n(0, 96, 12)
  return if n == 13
  tile_n(32, 96, 13)
  return if n == 14
  tile_n(64, 96, 14)
  return if n == 15
  tile_n(96, 96, 15)
end

run("fude")

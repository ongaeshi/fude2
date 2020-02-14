require "./fude"

script do
  loop do
    @i = 0

    @text = "Color Pallete Demo"
    1.upto(30) { Fiber.yield }
    @text = ""

    1.upto(16) do |e|
      @i = e
      1.upto(8) { Fiber.yield }
    end

    @text = "THE END"
    1.upto(60) { Fiber.yield }
  end
end

draw do
  cls
  tile(@i)
  print(@text, 16, 64 - 4, 7)
end

def tile(n)
  return if n == 0
  rectfill 0, 0, 32, 32, 0
  print 0.to_s, 16 - 4, 16 - 4, 7
  return if n == 1
  rectfill 32, 0, 32, 32, 1
  print 1.to_s, 32 + 16 - 4, 0 + 16 - 4, 7
  return if n == 2
  rectfill 64, 0, 32, 32, 2
  print 2.to_s, 64 + 16 - 4, 0 + 16 - 4, 7
  return if n == 3
  rectfill 96, 0, 32, 32, 3
  return if n == 4
  rectfill 0, 32, 32, 32, 4
  return if n == 5
  rectfill 32, 32, 32, 32, 5
  return if n == 6
  rectfill 64, 32, 32, 32, 6
  return if n == 7
  rectfill 96, 32, 32, 32, 7
  return if n == 8
  rectfill 0, 64, 32, 32, 8
  return if n == 9
  rectfill 32, 64, 32, 32, 9
  return if n == 10
  rectfill 64, 64, 32, 32, 10
  return if n == 11
  rectfill 96, 64, 32, 32, 11
  return if n == 12
  rectfill 0, 96, 32, 32, 12
  return if n == 13
  rectfill 32, 96, 32, 32, 13
  return if n == 14
  rectfill 64, 96, 32, 32, 14
  return if n == 15
  rectfill 96, 96, 32, 32, 15
end

run("fude")

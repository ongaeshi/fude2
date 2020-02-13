require "./raylib"
require "./fude"
include Fude

class Scene
  def initialize
  end

  def update
  end

  def draw
		cls(0)
		rectfill 0,   0, 32, 32, 0
		# print "0", 16, 16, 7
		rectfill 32,  0, 32, 32, 1
		rectfill 64,  0, 32, 32, 2
		rectfill 96,  0, 32, 32, 3
		rectfill 0,  32, 32, 32, 4
		rectfill 32, 32, 32, 32, 5
		rectfill 64, 32, 32, 32, 6
		rectfill 96, 32, 32, 32, 7
		rectfill 0,  64, 32, 32, 8
		rectfill 32, 64, 32, 32, 9
		rectfill 64, 64, 32, 32, 10
		rectfill 96, 64, 32, 32, 11
		rectfill 0,  96, 32, 32, 12
		rectfill 32, 96, 32, 32, 13
		rectfill 64, 96, 32, 32, 14
		rectfill 96, 96, 32, 32, 15
  end
end

run(Scene.new, "fude")

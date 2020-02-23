require "./fude"

script do
  @text_offx = 0
  @array = []
  @array_offx = 0

  run_command("x = [1, 2, 3]") do
    @array = [1, 2, 3]
  end

  run_command("x.push(4)") do
    @array.push(4)
  end

  run_command("x.unshift(5)") do
    @array_offx = -32
    @array.unshift 5
  end

  run_command("x.reverse!") do
    @array.reverse!
  end

  run_command("x = x.map { |e| e * 2 }", -32) do
    @array = @array.map { |e| e * 2 }
  end

  run_command("x = x.fill(9)") do
    @array = @array.fill(9)
  end

  run_command("x.delete(9)") do
    @array.delete(9)
  end

  yld 30
end

PADDING = 2

draw do
  cls 13
  print(@text, 64 + @text_offx, 32, @color)

  (0...@array.length).each do |i|
    x = 64 + 32 * i - 1 + @array_offx
    rect(x + PADDING, 64 + PADDING, 32 - PADDING, 32 - PADDING, 7)
    print(@array[i].to_s, x + 12 + PADDING, 64 + 8 + PADDING, 7)
  end
end

def run_command(command, offx = 0)
  @text = ""
  @text_offx = offx

  a = command.split("")
  a.each do |e|
    @text += e
    @color = 0
    yld 4
  end

  yld 30
  @color = 7
  yield
  yld 30
end

run("array animation")

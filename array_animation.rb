require "./fude"

script do
  set_color_hash(:bg, hex_color(0x55423d))
  set_color_hash(:input, hex_color(0xfff3ec))
  set_color_hash(:done, hex_color(0xfffffe))

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

  run_command("x = x.shift") do
    @array_offx = 0
    @array.shift
  end

  run_command("x.pop") do
    @array.pop
  end

  run_command("x.reverse!") do
    @array.reverse!
  end

  run_command("x = x.map { |e| e * 2 }", -32) do
    @array = @array.map { |e| e * 2 }
  end

  run_command("x = x.rotate(2)") do
    @array = @array.rotate
    yld 30
    @array = @array.rotate
  end

  run_command("x.union([1, 2])") do
    @array = @array.union([1, 2])
  end

  run_command("x.concat([1, 2])") do
    @array_offx = -32
    @array.concat([1, 2])
  end

  run_command("x = x.sort") do
    @array = @array.sort
  end

  run_command("x[1..2] = [2, 2]") do
    @array[0..1] = [2, 2]
  end

  run_command("x[0, 4] = [0, 0, 0]") do
    @array_offx = -16
    @array[0, 4] = [0, 0, 0]
  end

  run_command("x = x.uniq") do
    @array_offx = 0
    @array = @array.uniq
  end

  run_command("x.delete_at(1)") do
    @array_offx = 16
    @array.delete_at(1)
  end

  run_command("x *= 2") do
    @array_offx = 0
    @array *= 2
  end

  run_command("x.delete(6)") do
    @array_offx = 32
    @array.delete(6)
  end

  run_command("x = x.fill(9)") do
    @array = @array.fill(9)
  end

  run_command("x.clear") do
    @array.clear
  end

  yld 30
end

PADDING = 2

draw do
  cls :bg
  print(@text, 64 + @text_offx, 32, @color)

  (0...@array.length).each do |i|
    x = 64 + 32 * i - 1 + @array_offx
    rect(x + PADDING, 64 + PADDING, 32 - PADDING, 32 - PADDING, :done)
    print(@array[i].to_s, x + 12 + PADDING, 64 + 8 + PADDING, :done)
  end
end

def run_command(command, offx = 0)
  @text = ""
  @text_offx = offx

  a = command.split("")
  a.each do |e|
    @text += e
    @color = :input
    yld 4
  end

  yld 30
  @text = @text
  @color = :done
  yield
  yld 30
end

run("array animation")

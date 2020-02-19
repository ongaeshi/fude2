require "./fude"

def run_command(command)
  1.upto(command.length) do |e|
    @text = command[0..e]
    @color = 0
    yld 1
  end

  yld 15
  @color = 7
  yield
  yld 30
end

script do
  loop do
    @array = []

    run_command("x = [1, 2, 3]") do
      @array = [1, 2, 3]
    end

    run_command("x.push(4)") do
      @array.push(4)
    end

    run_command("x.reverse!") do
      @array.reverse!
    end

    yld 30
  end
end

draw do
  cls 13
  print(@text, 64, 32, @color)

  (0...@array.length).each do |i|
    x = 64 + 32 * i - 1
    rect(x, 64, 32, 32, 7)
    print(@array[i].to_s, x + 12, 64 + 8, 7)
  end
end

run("array animation")

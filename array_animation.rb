require "./fude"

script do
  loop do
    @array = []

    t = "x = [1, 2, 3]"
    1.upto(t.length) do |e|
      @text = t[0..e]
      @color = 0
      yld 8
    end

    yld 30
    @color = 7
    @array = [1, 2, 3]
    yld 120

    t = "x.push(4)"
    1.upto(t.length) do |e|
      @text = t[0..e]
      @color = 0
      yld 8
    end

    yld 30
    @color = 7
    @array.push(4)
    yld 120

    t = "x.reverse!"
    1.upto(t.length) do |e|
      @text = t[0..e]
      @color = 0
      yld 8
    end

    yld 30
    @color = 7
    @array.reverse!
    yld 120
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

require "./fude"

script do
  @text = "self[*item] -> Array"
  @window_text = @src = ""
  yld 120
  @text = ""
  @window_text = "引数itemを要素として持つ配列を生成して返します。"
  @src = <<EOS
  Array[1, 2, 3]
   #=> [1, 2, 3]

  class SubArray < Array
    # ...
  end
  p SubArray[1, 2, 3]
   # => [1, 2, 3]
EOS
  yld 120
  @window_text = "Arrayのサブクラスを作成したときに、そのサブクラスのインスタンスを作成しやすくするために用意されている。 "
  yld 120
  @window_text = "[PARAM] item:\n配列の要素を指定します。"
  yld 120
end

draw do
  cls 0
  print(@text, 24, 128, 7)

  printrec(@src, 4, 0, 248, 160, 7)

  if (@window_text != "")
    rect(0, 160, 256, 96, 7)
    printrec(@window_text, 4, 164, 248, 96, 7)
  end
end

run("array self")

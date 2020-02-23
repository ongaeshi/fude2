require "./raylib"

module Fude
  SCREEN_WIDTH = 256
  SCREEN_HEIGHT = 256
  SPRITE_SIZE = 8

  COLORS = [
    Raylib::Color.init(0, 0, 0, 255), # black
    Raylib::Color.init(29, 43, 83, 255), # dark-blue
    Raylib::Color.init(126, 37, 83, 255), # dark-purple
    Raylib::Color.init(0, 135, 81, 255), # dark-green
    Raylib::Color.init(171, 82, 54, 255), # brown
    Raylib::Color.init(95, 87, 79, 255), # dark-gray
    Raylib::Color.init(194, 195, 199, 255), # light-gray
    Raylib::Color.init(255, 241, 232, 255), # white
    Raylib::Color.init(255, 0, 77, 255), # red
    Raylib::Color.init(255, 163, 0, 255), # orange
    Raylib::Color.init(255, 236, 39, 255), # yellow
    Raylib::Color.init(0, 228, 54, 255), # green
    Raylib::Color.init(41, 173, 255, 255), # blue
    Raylib::Color.init(131, 118, 156, 255), # indigo
    Raylib::Color.init(255, 119, 168, 255), # pink
    Raylib::Color.init(255, 204, 170, 255),  # peach
  ]

  @@spritesheet = nil
  @@scripts = []
  @@drawers = []

  def cls(col = 0)
    Raylib::clear_background(COLORS[col])
    # slower patch: https://github.com/raysan5/raylib/issues/922
    Raylib::draw_sphere(Raylib::Vector3.init(0, 0, 0), 0, Raylib::WHITE)
  end

  def rect(x0, y0, x1, y1, col = 0)
    Raylib::draw_rectangle_lines(x0, y0, x1, y1, COLORS[col])
  end

  def rectfill(x0, y0, x1, y1, col = 0)
    Raylib::draw_rectangle(x0, y0, x1, y1, COLORS[col])
  end

  def print(str, x, y, col = 0)
    if @@font
      Raylib::draw_text_ex(@@font, str, Raylib::Vector2.init(x, y), 16, 1, COLORS[col])
    else
      Raylib::draw_text(str, x, y, 16, COLORS[col])
    end
  end

  def printrec(str, x, y, w, h, col = 0)
    Raylib::draw_text_rec(@@font, str, Raylib::Rectangle.init(x, y, w, h), 16, 1, true, COLORS[col])
  end

  def spr(n, x, y, w = 1.0, h = 1.0, flip_x = false, flip_y = false)
    s = SPRITE_SIZE
    ss = SCREEN_WIDTH / SPRITE_SIZE
    Raylib::draw_texture_rec(
      @@spritesheet,
      Raylib::Rectangle.init((n % ss) * s, (n / ss).to_i * s, s * w, s * h),
      Raylib::Vector2.init(x, y),
      Raylib::WHITE
    )
  end

  BTN_KEY = [
    Raylib::KEY_LEFT,
    Raylib::KEY_RIGHT,
    Raylib::KEY_UP,
    Raylib::KEY_DOWN,
    Raylib::KEY_Z,
    Raylib::KEY_X,
  ]

  def btn(i = 0, p = 0)
    return false if i >= BTN_KEY.length

    Raylib::is_key_down(BTN_KEY[i]) ||
    game_pad_key_down(i, p)
  end

  def game_pad_key_down(i, p)
    ANALOG_THRESHOLD = 0.5

    case i
    when 0
      Raylib::get_gamepad_axis_movement(0, 1) < -ANALOG_THRESHOLD
    when 1
      Raylib::get_gamepad_axis_movement(0, 1) > ANALOG_THRESHOLD
    when 2
      Raylib::get_gamepad_axis_movement(0, 2) < -ANALOG_THRESHOLD
    when 3
      Raylib::get_gamepad_axis_movement(0, 2) > ANALOG_THRESHOLD
    when 4
      Raylib::is_gamepad_button_down(0, 17)
    when 5
      Raylib::is_gamepad_button_down(0, 16)
    end
  end

  def pausebtn(p = 0)
    Raylib::is_key_down(Raylib::KEY_ENTER) ||
    Raylib::is_key_down(Raylib::KEY_ESCAPE) ||
    Raylib::is_gamepad_button_down(0, 10)
  end


  def circfill(x, y, r = 4, col = 0)
    Raylib::draw_circle(x, y, r, COLORS[col])
  end

  def rnd(max = 1.0)
    Math::rand * max
  end

  def sqrt(num)
    Math.sqrt(num)
  end

  def abs(num)
    num.abs
  end

  def flr(num)
    num.floor
  end

  def line(x0, y0, x1, y1, col = 7)
    Raylib::draw_line(x0, y0, x1, y1, COLORS[col]);
  end

  def yld(wait = 1)
    1.upto(wait) { Fiber.yield }
  end

  def script(&block)
    if Raylib::get_is_gif
      oneshot(&block)
    else
      @@scripts.push(Fiber.new { loop { block.call } })
    end
  end

  def oneshot(&block)
    @@scripts.push(Fiber.new(&block))
  end

  def draw(&block)
    @@drawers.push(block)
  end

  def all_scripts_end?
    @@scripts.all? { |e| !e.alive? }
  end

  def gif_file_name
    FILE_NAME.sub(File.extname(FILE_NAME), "") + ".gif"
  end

  def run(title, scale = 2, width = SCREEN_WIDTH, height = SCREEN_HEIGHT)
    Raylib::window(width * scale, height * scale, title) do
      Raylib::set_target_fps(60)

      target = Raylib::load_render_texture(width, height)
      @@spritesheet = Raylib::load_texture("resource/spritesheet.png")

      @@font = Raylib::load_font("resource/font.fnt")

      Raylib::gif_begin(gif_file_name) if Raylib::get_is_gif

      until Raylib::window_should_close || (Raylib::get_is_gif && all_scripts_end?)
        # Update
        @@scripts.each do |e| 
          e.resume if e.alive?
        end

        # Draw
        Raylib::draw do
          Raylib::texture_mode(target) do
            @@drawers.each do |e| 
              e.call
            end
          end

          Raylib::draw_texture_pro(
            target.texture,
            Raylib::Rectangle.init(
              0.0,
              0.0,
              target.texture.width,
              -target.texture.height
            ),
            Raylib::Rectangle.init(
              (Raylib::get_screen_width() - width * scale) * 0.5,
              (Raylib::get_screen_height() - height * scale) * 0.5,
              width * scale,
              height * scale
            ),
            Raylib::Vector2.init(0, 0),
            0.0,
            Raylib::WHITE
          )

          Raylib::gif_write_frame if Raylib::get_is_gif
        end
      end

      Raylib::gif_end if Raylib::get_is_gif
    end
  end
end

include Fude
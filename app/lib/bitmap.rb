class Bitmap
  attr_reader :pixels

  def initialize(width, height)
    @pixels = Array.new(width) { Array.new(height, "0") }
  end

  def draw_vertical_line(x, y1, y2, color)
    validate_within_bounds([{x: x, y: 1}, {x: x, y: y1}, {x: x, y: y2}])
    
    (y1..y2).each do |y| 
      draw_pixel(x, y, color) 
    end
  end

  def draw_horizontal_line(x1, x2, y, color)
    validate_within_bounds([{x: 1, y: y}, {x: x1, y: y}, {x: x2, y: y}])
    
    (x1..x2).each do |x| 
      draw_pixel(x, y, color) 
    end
  end

  def draw_pixel(x, y, color)
    validate_within_bounds([{x: x, y: y}])
    @pixels[x-1][y-1] = color
  end

  def fill_area(x, y, color, show_progress=false)
    old_color = @pixels[x-1][y-1]
    fill(x, y, color, old_color, show_progress)
  end

  def fill(x, y, new_color, old_color, show_progress)
    if within_bounds(x, y) && @pixels[x-1][y-1] == old_color
      draw_pixel(x, y, new_color)
      
      if show_progress
        puts `clear`
        puts self.to_s
        sleep 0.01
      end

      # recur for up/down/left/right
      fill(x, y+1, new_color, old_color, show_progress)
      fill(x, y-1, new_color, old_color, show_progress)
      fill(x-1, y, new_color, old_color, show_progress)
      fill(x+1, y, new_color, old_color, show_progress)
    end
  end

  def to_s
    @pixels.transpose.map { |col| col.join(" ") }.join("\n")
  end

  def clear
    @pixels.map { |col| col.map! { "0" } }
  end

  private

  def within_bounds(x, y)
    x > 0 && y > 0 && !@pixels[x-1].nil? && !@pixels[x-1][y-1].nil?
  end

  def validate_within_bounds(coords)
    coords.each do |coord| 
      raise "you are trying to draw beyond the boundary of the image" unless within_bounds(coord[:x], coord[:y])
    end
  end
end
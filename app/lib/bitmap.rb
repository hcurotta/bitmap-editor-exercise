class Bitmap
  attr_reader :pixels

  def initialize(width, height)
    @pixels = Array.new(width) { Array.new(height, "0") }
  end

  def draw_vertical_line(x, y1, y2, color)
    validate_within_bounds([{x: x-1, y: 0}, {x: x-1, y: y1-1}, {x: x-1, y: y2-1}])
    
    (y1..y2).each do |y| 
      draw_pixel(x, y, color) 
    end
  end

  def draw_horizontal_line(x1, x2, y, color)
    validate_within_bounds([{x: 0, y: y-1}, {x: x1-1, y: y-1}, {x: x2-1, y: y-1}])
    
    (x1..x2).each do |x| 
      draw_pixel(x, y, color) 
    end
  end

  def draw_pixel(x, y, color)
    validate_within_bounds([{x: x-1, y: y-1}])
    @pixels[x-1][y-1] = color
  end

  def to_s
    @pixels.transpose.map { |col| col.join(" ") }.join("\n")
  end

  def clear
    @pixels.map { |col| col.map! { "0" } }
  end

  private

  def validate_within_bounds(coords)
    coords.each do |coord|
      if @pixels[coord[:x]].nil? || @pixels[coord[:x]][coord[:y]].nil?
        raise "you are trying to draw beyond the boundary of the image" 
      end
    end
  end
end
require_relative "./lib/editor"

class BitmapEditor
  def run
    @running = true
    puts 'type ? for help'
    @editor = Editor.new
    while @running
      print '> '
      input = gets.chomp.strip

      case input
        when '?'
          show_help
        when 'X'
          exit_console
        else
          begin
            @editor.execute(input)
          rescue Exception => e
            puts e.message
          end
      end
    end
  end

  private
    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def show_help
      puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
F [S] X Y C - Fill a contiguous region of color with a new color. Optional S command to see fill in process.
S - Show the contents of the current image
X - Terminate the session"
    end
end

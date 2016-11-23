require_relative 'bitmap'

class Editor
  attr_reader :bitmap

  # REGEX to check for integers up to 250 and Colors A-Z
  REGEX_VALID_NUMBER = '([1-9][0-9]?|1[0-9]{2}|2[0-4][0-9]|250)'
  REGEX_VALID_COLOR = '([A-Z])'

  def execute(command)
    case command
    when /^I #{REGEX_VALID_NUMBER} #{REGEX_VALID_NUMBER}$/
      @bitmap = Bitmap.new($1.to_i, $2.to_i)
    when /^C$/
      raise 'bitmap not initialized' if @bitmap.nil?
      @bitmap.clear
    when /^S$/
      raise 'bitmap not initialized' if @bitmap.nil?
      puts @bitmap.to_s
    when /^L #{REGEX_VALID_NUMBER} #{REGEX_VALID_NUMBER} #{REGEX_VALID_COLOR}$/
      raise 'bitmap not initialized' if @bitmap.nil?
      @bitmap.draw_pixel($1.to_i, $2.to_i, $3)
    when /^H #{REGEX_VALID_NUMBER} #{REGEX_VALID_NUMBER} #{REGEX_VALID_NUMBER} #{REGEX_VALID_COLOR}$/
      raise 'bitmap not initialized' if @bitmap.nil?
      @bitmap.draw_horizontal_line($1.to_i, $2.to_i, $3.to_i, $4)
    when /^V #{REGEX_VALID_NUMBER} #{REGEX_VALID_NUMBER} #{REGEX_VALID_NUMBER} #{REGEX_VALID_COLOR}$/
      raise 'bitmap not initialized' if @bitmap.nil?
      @bitmap.draw_vertical_line($1.to_i, $2.to_i, $3.to_i, $4)
    when /^F( S)? #{REGEX_VALID_NUMBER} #{REGEX_VALID_NUMBER} #{REGEX_VALID_COLOR}$/
      raise 'bitmap not initialized' if @bitmap.nil?
      @bitmap.fill_area($2.to_i, $3.to_i, $4, !$1.nil?)
    else
      raise 'unrecognised command :('
    end
  end

end
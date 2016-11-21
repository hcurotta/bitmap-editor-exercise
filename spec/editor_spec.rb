require 'spec_helper'

RSpec.describe Editor do 
  describe '#execute' do
    let(:editor) { Editor.new }
    context "when initializing" do 
      it 'should initialize when given valid dimensions' do
        command = 'I 5 6'
        expected_bitmap = Bitmap.new(5,6)
        editor.execute(command)
        expect(editor.bitmap.pixels).to eq(expected_bitmap.pixels)
      end

      it 'should not accept dimensions greater than 250' do
        command = 'I 10 251'
        expect {editor.execute(command)}.to raise_error('unrecognised command :(')
      end
    end

    context 'when drawing' do 
      
      before(:each) do 
        editor.execute('I 5 6')
      end

      let(:control_bitmap) { Bitmap.new(5,6) }

      it 'should draw a single pixel' do 
        command = 'L 2 3 A'
        control_bitmap.draw_pixel(2,3,"A")
        editor.execute(command)
        expect(editor.bitmap.pixels).to eq(control_bitmap.pixels)
      end

      it 'should draw a vertical line' do 
        command = 'V 2 3 6 W'
        control_bitmap.draw_vertical_line(2,3,6,"W")
        editor.execute(command)
        expect(editor.bitmap.pixels).to eq(control_bitmap.pixels)
      end

      it 'should draw a horizontal line' do 
        command = 'V 3 5 2 Z'
        control_bitmap.draw_vertical_line(3,5,2,"Z")
        editor.execute(command)
        expect(editor.bitmap.pixels).to eq(control_bitmap.pixels)
      end

      it 'should show the bitmap' do 
        expected_output = "0 0 0 0 0\n0 0 0 0 0\n0 0 0 0 0\n0 0 0 0 0\n0 0 0 0 0\n0 0 0 0 0\n"
        expect {editor.execute("S")}.to output(expected_output).to_stdout
      end

      it 'should raise an error if bitmap is not initialized' do
        editor = Editor.new
        expect {editor.execute("L 5 6 C")}.to raise_error('bitmap not initialized')
      end
    end

    it 'should raise an error when an invalid command is executed' do 
      invalid_commands = ["I M", "T", "L X Y", "V X Y1 Y2 C 2", "H 2 Y C", "B", "Q", ""]
      invalid_commands.each do |command|
        expect {editor.execute(command)}.to raise_error('unrecognised command :(')
      end
    end
  end
end
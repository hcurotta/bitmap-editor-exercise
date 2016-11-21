require 'spec_helper'

RSpec.describe Bitmap do 
  describe '#initialize' do
    it 'should instantiate a bitmap with dimension 3 by 4' do 
      expected_pixel_array = [["0", "0", "0", "0"], ["0", "0", "0", "0"], ["0", "0", "0", "0"]]
      bitmap = Bitmap.new(3, 4)
      expect(bitmap.pixels).to eq(expected_pixel_array)
    end
  end

  context 'when drawing' do

    let(:bitmap) { bitmap = Bitmap.new(3, 4) }

    describe '#draw_pixel' do 
      it 'should draw a pixel with a color' do 
        expected_pixel_array = [["C", "0", "0", "0"], ["0", "0", "0", "0"], ["0", "0", "0", "0"]]
        bitmap.draw_pixel(1, 1, 'C')
        expect(bitmap.pixels).to eq(expected_pixel_array)
      end

      it 'should raise an error when outside the bounds of the image' do 
        expect {bitmap.draw_pixel(10, 10, 'C')}.to raise_error("you are trying to draw beyond the boundary of the image")
      end
    end

    describe "#draw_vertical_line" do 
      it 'should draw a vertical line with a color' do 
        expected_pixel_array = [["C", "C", "C", "C"], ["0", "0", "0", "0"], ["0", "0", "0", "0"]]
        bitmap.draw_vertical_line(1, 1, 4, 'C')
        expect(bitmap.pixels).to eq(expected_pixel_array)
      end
    end

    describe "#draw_horizontal_line" do 
      it 'should draw a horizontal line with a color' do 
        expected_pixel_array = [["C", "0", "0", "0"], ["C", "0", "0", "0"], ["C", "0", "0", "0"]]
        bitmap.draw_horizontal_line(1, 3, 1, 'C')
        expect(bitmap.pixels).to eq(expected_pixel_array)
      end
    end

    describe '#clear' do 
      it 'should replace all pixels with 0 color' do
        expected_pixel_array = [["0", "0", "0", "0"], ["0", "0", "0", "0"], ["0", "0", "0", "0"]]
        bitmap.draw_pixel(1, 1, 'C')
        bitmap.clear
        expect(bitmap.pixels).to eq(expected_pixel_array)
      end
    end
  end

  describe '#to_s' do 
    it 'should return a string representation of pixels' do
      bitmap = Bitmap.new(2, 2)
      bitmap.draw_pixel(1, 1, "C")
      expected_string = "C 0\n0 0"
      expect(bitmap.to_s).to eq(expected_string)
    end
  end
end

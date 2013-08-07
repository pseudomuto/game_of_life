require "spec_helper"

describe "Board" do
  subject { GameOfLife::Board.new(5, 4) }

  it { should respond_to(:row_count) }
  it { should respond_to(:column_count) }
  it { should respond_to(:spawn_cells) }
  it { should respond_to(:each_row) }
  it { should respond_to(:each_cell_in_row) }
  it { should respond_to(:live_neighbour_count) }

  describe "#row_count" do
  	specify { subject.row_count.should eql(5) }
  end

  describe "#column_count" do
  	specify { subject.column_count.should eql(4) }
  end

  describe "#each_row" do
    it "should yield all rows" do
      count = 0
      subject.each_row {|row, y| count += 1 }
      expect(count).to eql(5)
    end
  end

  describe "#each_cell_in_row" do
    it "should yield all columns" do
      count = 0
      subject.each_cell_in_row(1) {|cell, x| count += 1 }
      expect(count).to eql(4)
    end
  end

  describe "#live_neighbour_count" do
    subject { GameOfLife::Board.new(5, 5) }
    before { subject.spawn_cells([2, 1], [2, 2], [2, 3]) }

    it "should be 0 for (0, 0)" do
      expect(subject.live_neighbour_count(0, 0)).to be_zero
    end
  end

  describe "#spawn_cells" do
  	
  	context "when called with valid list" do
	  before { subject.spawn_cells([2,1], [2,2], [2,3]) }

	  specify { subject.to_s.should eql("0000\n0000\n0111\n0000\n0000\n") }
	end
  end

  describe "#to_s" do

  	context "when no living cells exist" do
  	  subject { GameOfLife::Board.new(3, 5).to_s }

  	  it { should eql("00000\n00000\n00000\n") }
  	end
  end
end
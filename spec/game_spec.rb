require "spec_helper"

describe "Game" do
  subject { GameOfLife::Game.new(5, 5, [2, 1], [2, 2], [2, 3]) }

  it { should respond_to(:play) }

  describe "#to_s" do
  	
  	let(:output) { subject.to_s }

  	specify { output.should eql("00000\n00000\n01110\n00000\n00000\n") }
  end

  describe "#play" do

  	it "defaults to a single generation" do
  	  subject.play
  	  expect(subject.to_s).to eql("00000\n00100\n00100\n00100\n00000\n")
  	end

  	it "performs n ticks" do
  	  subject.play(2)
  	  expect(subject.to_s).to eql("00000\n00000\n01110\n00000\n00000\n")
  	end

  	context "when called with a block" do

  	  it "should yield for each iteration" do
  	  	states = []
  	  	subject.play(3) do
  	  	  states << subject.to_s
  	  	end

  	  	expect(states.size).to eql(3)
  	  end
  	end
  end

  describe "#tick" do

  	it "should oscillate" do
  	  init_state = subject.to_s
  	  end_state = "00000\n00100\n00100\n00100\n00000\n"

  	  expect { subject.__send__(:tick) }.to change(subject, :to_s).to(end_state)
  	  expect { subject.__send__(:tick) }.to change(subject, :to_s).to(init_state)
  	end
  end
end
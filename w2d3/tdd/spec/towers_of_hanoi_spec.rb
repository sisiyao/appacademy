require 'rspec'
require 'towers_of_hanoi'

describe '#initialize' do
  subject(:game) { TowersOfHanoi.new }

  it "starts off with 3 arrays" do
    expect(game.piles.length).to eq(3)
  end

  it "starts off with all discs in first pile" do
    expect(game.piles[0].length).to eq(3)
    expect(game.piles[1]).to be_empty
    expect(game.piles[2]).to be_empty
  end
end

describe '#move' do
  let(:game) { TowersOfHanoi.new }
  before(:each) do
    game.move([0,1])
  end

  it "can move a disc to an empty pile" do
    game.move([0,2])

    expect(game.piles[2].length).to eq(1)
  end

  it "can move a disc on top of a smaller disc" do
    game.move([0,2])
    game.move([1,2])
    expect(game.piles[2].length).to eq(2)
  end
end

describe "valid_input?" do
  let(:game) { TowersOfHanoi.new }
  before(:each) do
    game.move([0,1])
  end
  
  it "doesn't move a bigger disc on top of a smaller one" do
    expect(game.valid_input?([0,1])).to be_falsy
  end
end

describe "#won?" do
  let(:game) { TowersOfHanoi.new }

  it "knows when the player has won the game" do
    game.piles[0], game.piles[2] = game.piles[2], game.piles[0]
    expect(game.won?).to be_truthy
  end

  it "knows when the player has not won the game" do
    expect(game.won?).to be_falsy
  end
end

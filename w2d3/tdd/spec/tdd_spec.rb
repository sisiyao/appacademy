require 'rspec'
require 'tdd'

describe '#my_uniq' do
  let(:array) { [1,2,3,4,4] }

  it "returns a unique array" do
    expect(array.my_uniq).to eq([1,2,3,4])
  end

  it "does not remove duplicates" do
    expect(array.my_uniq).not_to eq([1,2,3])
  end
end

describe "#two_sum" do
  it "finds the correct pairs" do
    array = [-1, 0, 2, -2, 1]
    expect(array.two_sum).to eq([[0, 4], [2, 3]])
  end

  it "reuses numbers in pairs" do
    array = [-1, 0, 2, 1, 1]
    expect(array.two_sum).to eq([[0, 3], [0, 4]])
  end

  it "finds pairs in the correct order" do
    array = [-1, 0, 2, 1, 1]
    expect(array.two_sum).not_to eq([[0, 4], [0, 3]])
  end

  it "the pairs should be two different indices" do
    array = [-1, 0, 2, 1, 1]
    expect(array.two_sum).not_to include([1, 1])
  end

  it "doesn't find incorrect pairs" do
    array = [1, 0, 2, 1, 1]
    expect(array.two_sum).to eq([])
  end
end

describe "my_transpose" do
  let(:array) { [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ] }

  it "doesn't change the first element of the first array" do
    expect(my_transpose(array)[0][0]).to eq(array[0][0])
  end

  it "doesn't change the number of arrays within the array" do
    expect(my_transpose(array).length).to eq(array.length)
  end

  it "transposes the array correctly" do
    expect(my_transpose(array)).to eq([[0,3,6],[1,4,7],[2,5,8]])
  end

  it "doesn't flatten the original array" do
    expect(my_transpose(array).length).not_to eq(array.flatten.length)
  end
end

describe "stock_picker" do
  let(:stock) { [5,4,1,8,10,2,4,100,7] }

  it "selects the correct pair of days" do
    expect(stock_picker(stock)).to eq([2,7])
  end

  it "doesn't reverse the pair of days" do
    expect(stock_picker(stock)).not_to eq([7,2])
  end

  it "doesn't return the values of the stock prices" do
    expect(stock_picker(stock)).not_to eq([1,100])
  end
end

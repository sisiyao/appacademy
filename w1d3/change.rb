# require 'byebug'

def greedy_make_change(tot, coins)
  change = []
  return [] if tot == 0
  num_highest_coin = tot / coins[0]
  change += [coins[0]] * num_highest_coin
  remainder = tot % coins[0]
  coins.shift
  change + greedy_make_change(remainder, coins)
end

def make_better_change(tot, coins)
  best_change = nil
  return [] if tot == 0

  coins.each do |coin|
    # debugger
    change = []
    remainder = tot - coin
    if tot < coin
      change += make_better_change(tot, coins[1..-1])
    else
      change += [coin] + make_better_change(remainder, coins)
    end
    best_change = change if best_change.nil? || change.length < best_change.length
  end

  best_change
end

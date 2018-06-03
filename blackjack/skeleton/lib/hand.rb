require_relative 'card.rb'
require_relative 'deck.rb'
require 'byebug'

class Hand
  attr_accessor :cards
  # This is a *factory method* that creates and returns a `Hand`
  # object.
  def self.deal_from(deck)
    hand = deck.take(2)
    Hand.new(hand)
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    points = 0
    ace = false
    @cards.each do |card|
      if card.value == :ace
        ace = true
        points += 21
      else
        points += card.blackjack_value
      end
    end
    if ace == true
      if points <= 21
      elsif points > 21
        until points <= 21
          points -= 10
        end
      end
    end
    points
  end

  def busted?
    return true if points > 21
    false
  end

  def hit(deck)
    raise "already busted" if self.busted?
    @cards += deck.take(1)
  end

  def beats?(other_hand)
    return false if busted?

    other_hand.busted? || (self.points > other_hand.points)
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end

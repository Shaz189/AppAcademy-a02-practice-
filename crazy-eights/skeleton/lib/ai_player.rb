require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'pile.rb'
require 'byebug'

# Represents a computer Crazy Eights player.
class AIPlayer
  attr_reader :cards

  # Creates a new player and deals them a hand of eight cards.
  def self.deal_player_in(deck)
    cards = deck.take(8)
    AIPlayer.new(cards)
  end

  def initialize(cards)
    @cards = cards
  end

  # Returns the suit the player has the most of; this is the suit to
  # switch to if player gains control via eight.
  def favorite_suit
    suit_hash = Hash.new {|k, v| v = 0 }
    @cards.each do |card|
      suit_hash[card.suit] += 1
    end
    suit_hash.sort_by {|suit, num| num}.to_h.keys.last
  end

  # Plays a card from hand to the pile, removing it from the hand. Use
  # the pile's `#play` and `#play_eight` methods.
  def play_card(pile, card)
    if @cards.include?(card)
      if card.value == :eight
        # debugger
        pile.play_eight(@cards.find {|card| card.value == :eight}, favorite_suit)
      else
        pile.play(card)
      end
      @cards.delete(card)
    else
      raise'cannot play card outside your hand'
    end
  end

  # Draw a card from the deck into player's hand.
  def draw_from(deck)
    @cards += deck.take(1)
  end

  # Choose any valid card from the player's hand to play; prefer
  # non-eights to eights (save those!). Return nil if no possible
  # play. Use `Pile#valid_play?` here; do not repeat the Crazy Eight
  # rules written in the `Pile`.
  def choose_card(pile)
    valid = []
    @cards.each do |card|
      valid << card if pile.valid_play?(card)
    end
    return valid.first if valid.length == 1
    return nil if valid.length == 0
    if valid.length > 1
      return valid.find {|card| card.value != :eight}
    end
  end

  # Try to choose a card; if AI has a valid play, play the card. Else,
  # draw from the deck and try again until there is a valid play.
  # If deck is empty, pass.
  def play_turn(pile, deck)
    card_to_play = choose_card(pile)
    while card_to_play == nil && deck.empty? == false
      draw_from(deck)
      card_to_play = choose_card(pile)
    end
    if card_to_play != nil
      play_card(pile, card_to_play)
    end
  end
end

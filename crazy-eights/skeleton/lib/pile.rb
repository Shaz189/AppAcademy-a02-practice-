# Represents the common "pile" of cards on which to play Crazy Eights.
class Pile
  attr_reader :top_card, :current_suit

  def initialize(top_card)
    @top_card = top_card
    @current_suit = @top_card.suit
  end

  # Returns the current value in play. This is the value of the top
  # card.
  def current_value
    @top_card.value
  end

  # Returns the current suit in play; either the suit of the top card,
  # or the suit specified by the previous player if an eight was
  # played.
  def current_suit
    @current_suit
  end

  # Returns true if a card is valid to play in this circumstance. Card
  # should either:
  #   (1) be the same suit as the current suit,
  #   (2) be the same rank as the previous card,
  #   (3) be an eight.
  def valid_play?(card)
    top = @top_card
    return true if card.suit == current_suit || card.value == top.value || card.value == :eight
    false
  end

  # Plays a non-eight card on the top of the pile, objecting if it is
  # not valid.
  def play(card)
    if card.value == :eight
      raise 'must declare suit when playing eight'
    elsif valid_play?(card)
      @top_card = card
      @current_suit = card.suit
    else
      raise "invalid play"
    end
  end

  # Plays an eight on top of the pile, setting the suit choice.
  def play_eight(card, suit_choice)
    if card.value != :eight
      raise 'must play eight'
    else
      @top_card = card
      @current_suit = suit_choice
      # debugger
    end
  end
end

class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @hand = nil
  end

  def pay_winnings(bet_amt)
    @bankroll += bet_amt
  end

  def return_cards(deck)
    @hand.return_cards(deck)
    @hand = nil
  end

  def place_bet(dealer, bet_amt)
    dealer.take_bet(self, bet_amt)
    if @bankroll - bet_amt < 0
      raise "player can't cover bet"
    else
      @bankroll -= bet_amt
    end
  end
end

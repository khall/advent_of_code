class RockPaperScissors
  HANDS = {
    'A' => :rock,
    'B' => :paper,
    'C' => :scissors,
    'X' => :rock,
    'Y' => :paper,
    'Z' => :scissors
  }.freeze

  OPPONENT_VERSUS_PLAYER_OUTCOME = {
    rock: { rock: :tie, paper: :win, scissors: :lose },
    paper: { rock: :lose, paper: :tie, scissors: :win },
    scissors: { rock: :win, paper: :lose, scissors: :tie }
  }.freeze

  OUTCOME_SCORES = {
    lose: 0,
    tie: 3,
    win: 6
  }.freeze

  MOVE_BONUS = {
    rock: 1,
    paper: 2,
    scissors: 3
  }.freeze

  def initialize
    @input = File.readlines('input').map { |n| n.strip.split(' ') }
  end

  def total_score
    running_score = 0

    @input.each do |opponent_play, my_play|
      running_score += match_score(HANDS[opponent_play], HANDS[my_play])
    end

    running_score
  end

  private

  def match_score(opponent_play, my_play)
    OUTCOME_SCORES[OPPONENT_VERSUS_PLAYER_OUTCOME[opponent_play][my_play]] + MOVE_BONUS[my_play]
  end
end

puts RockPaperScissors.new.total_score

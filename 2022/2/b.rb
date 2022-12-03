class RockPaperScissors
  HANDS = {
    'A' => :rock,
    'B' => :paper,
    'C' => :scissors
  }.freeze

  PLAYER_GOAL = {
    'X' => :lose,
    'Y' => :tie,
    'Z' => :win
  }.freeze

  PLAYERS_PLAY = {
    lose: { rock: :scissors, paper: :rock, scissors: :paper },
    tie: { rock: :rock, paper: :paper, scissors: :scissors },
    win: { rock: :paper, paper: :scissors, scissors: :rock }
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

    @input.each do |opponent_play, player_goal|
      running_score += match_score(HANDS[opponent_play], PLAYER_GOAL[player_goal])
    end

    running_score
  end

  private

  def match_score(opponent_play, player_goal)
    my_play = PLAYERS_PLAY[player_goal][opponent_play]
    OUTCOME_SCORES[OPPONENT_VERSUS_PLAYER_OUTCOME[opponent_play][my_play]] + MOVE_BONUS[my_play]
  end
end

puts RockPaperScissors.new.total_score

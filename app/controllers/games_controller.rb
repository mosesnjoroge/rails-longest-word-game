require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    # get request
    # create array of the alphabet

    # randomly generate letters for the user to see and pick
    # make post request to the api
    # pass post request to score page
    letter_array = ('a'..'z').to_a
    @letters = []
    10.times do
      rand_num = rand(1...26)
      @letters.push(letter_array[rand_num])
    end
    @letters
  end

  def word_comparison(guess, grid)
    final_answer = []
    guess_array = guess.split("")
    grid.each do |item|
      final_answer.push(item) if guess_array.include?(item)
    end
    indexer = (final_answer & guess_array).flat_map { |i| [i] * [final_answer.count(i), guess_array.count(i)].min }
    indexer.sort == guess_array.sort
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def score; end
end

# longest word challenge w/o rails

# def included?(guess, grid)
#   guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
# end

# def compute_score(attempt, time_taken)
#   time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
# end

# def run_game(attempt, grid, start_time, end_time)
#   # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
#   result = { time: end_time - start_time }

#   score_and_message = score_and_message(attempt, grid, result[:time])
#   result[:score] = score_and_message.first
#   result[:message] = score_and_message.last

#   result
# end

# def score_and_message(attempt, grid, time)
#   if included?(attempt.upcase, grid)
#     if english_word?(attempt)
#       score = compute_score(attempt, time)
#       [score, "well done"]
#     else
#       [0, "not an english word"]
#     end
#   else
#     [0, "not in the grid"]
#   end
# end

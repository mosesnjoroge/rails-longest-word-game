require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
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

  def score
    @user_answer = params["input"]
    grid_check = params["user_array"].split("").join.split(" ")
    compare_check = compare_instances(@user_answer, grid_check)
    exist_check = word_exists(@user_answer)
    @responce = ""

    if exist_check == false
      @responce = "Sorry, but #{@user_answer} is not an English word"
    elsif compare_check == false
      @responce = "Sorry but #{@user_answer} can't be built out of #{display(grid_check)} "
    else
      @responce = "Congrats buddy, that was a real word my dude...."
    end
    @responce
  end
end

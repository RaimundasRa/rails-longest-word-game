require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer].upcase
    @grid = params[:letters]
    @english_word = english_word?(@answer)
    @included_in_grid = included_in_grid?(@answer, @grid)
  end

  def english_word?(word)
    result = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(result.read)
    json["found"]
  end

  def included_in_grid?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end
end

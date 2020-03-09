require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @word_a = @word.upcase.chars
    @letters = params[:letters].gsub(/\s+/, '').chars

    @grid_validation = @word_a.all? { |letter| @letters.include?(letter) }
    word = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    @english_validation = word['found']

    if @grid_validation == false
      @result = "Sorry but #{@word} can't be build out of #{@letters.join(', ')}"
    elsif @english_validation == false
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word} is a valid English word!"
    end
  end
end

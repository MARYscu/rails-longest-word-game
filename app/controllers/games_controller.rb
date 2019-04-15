require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @new_letters = []
    10.times do |x|
      @new_letters.push(rand(65..90).chr())
    end
    return @new_letters
  end

  def score
    @new = new
    @result_judge = 0
    @result = ""
    @score = 0
    @long_words = params[:long_words]
    @all = @long_words.split
    @all.each do |letter|
      if @new.include?(letter.upcase)
        @result_judge = 0
      else
        @result_judge = 1
        break
      end
    end
    if @result_judge == 0
      base_url = 'https://wagon-dictionary.herokuapp.com/'
      url = base_url + @long_words
      json_string = open(url).read
      judge_hash = JSON.parse(json_string)
      if judge_hash["found"] == false
       @result  = "not an english word"
       score = 0
      else
       @result = "right"
       score =  100
      end
    else
      @result = "not in the grid"
      score = 0
    end
  end

end

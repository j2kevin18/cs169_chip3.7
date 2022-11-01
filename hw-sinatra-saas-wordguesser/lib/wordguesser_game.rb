class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

    def initialize(new_word)
      @word = new_word
      @guesses = ""
      @wrong_guesses = ""
    end

    def guess(letter)
      if !letter.nil? and letter.match?(/[a-zA-Z]/)
        letter.downcase!
      else
        raise ArgumentError
      end
      if @word.include?(letter) and !@guesses.include?(letter)
        @guesses.send(:<<, letter)
      elsif !@word.include?(letter) and !@wrong_guesses.include?(letter)
        @wrong_guesses.send(:<<, letter)
      else
        false
      end
    end

    def word_with_guesses
      str = ""
      @word.each_char{|c| str.send(:<<, @guesses.include?(c) ? c : '-')}
      str
    end

    def check_win_or_lose
      match = 0

      @word.each_char{|c| match += @guesses.include?(c) ? 1 : 0}
      if @wrong_guesses.length >= 7
        :lose
      elsif match == @word.length
        :win
      else
        :play
      end
    end
    

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end

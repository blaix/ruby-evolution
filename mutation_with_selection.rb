# Simple implementation of Dawkin's "weasel" program in ruby.
# http://en.wikipedia.org/wiki/Methinks_it_is_a_weasel
#
# Demonstrating the power of random mutation + selection
# as compared to blind chance.
#
# - Justin Blake <justin@adsdevshop.com>

class EvolutionMachine
  def initialize(options = {})
    @max_children = options[:max_children] || 1000
    @sleep = options[:sleep] || 0
    @selection = options[:selection].nil? ? true : options[:selection]
  end
  
  def evolve(phrase, target)
    normalize(phrase, target)
    puts phrase
    gets
    while(phrase != target)
      sleep(@sleep)
      children = procreate(phrase)
      phrase = @selection ? select_fittest(children, target) : select_random(children)
      puts phrase
    end
  end
  
  private
  
  def normalize(phrase, target)
    phrase << ' ' while phrase.length < target.length
    target << ' ' while target.length < phrase.length
  end
  
  def procreate(phrase)
    children = []
    num_children = rand(@max_children) + 1
    num_children.times { children << mutate(phrase) }
    children
  end
  
  def mutate(string)
    string = string.clone
    string.length.times do |i|
      # 5% chance of variation per character
      string[i] = random_char if rand(100) < 5
    end
    string
  end

  def random_char
    @chars ||= (32..126).to_a.collect! { |c| c.chr }
    @chars[rand(@chars.length)]
  end

  def select_fittest(children, target)
    best_score = nil
    fittest = nil
    children.each do |child|
      score = (0...target.length).inject(0) do |sum, i|
        sum + (target[i] - child[i]).abs
      end
      if(best_score.nil? || score < best_score)
        fittest = child
        best_score = score
      end
    end
    fittest
  end
  
  def select_random(children)
    children[rand(children.length)]
  end
end


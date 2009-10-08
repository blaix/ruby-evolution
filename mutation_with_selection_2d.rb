require 'mutation_with_selection'

class EvolutionMachine2D < EvolutionMachine
  def initialize(options = {})
    @characters = options.delete(:characters) || (32..126).to_a.collect! { |c| c.chr }
    super
  end
  
  private
  
  def mutate(string)
    string = string.clone.split("\n")
    string.length.times do |line_number|
      if rand(100) < 5
        string[line_number].length.times do |i|
          string[line_number][i] = random_char if rand(100) < 5
        end
      end
    end
    string.join("\n")
  end

  def random_char
    @characters[rand(@characters.length)]
  end

  def select_fittest(children, target)
    best_score = nil
    fittest = nil
    target = target.split("\n")
    children.each do |child|
      child = child.split("\n")
      score = (0...child.length).inject(0) do |total_score, line_number|
        line = child[line_number]
        target_line = target[line_number]
        total_score + (0...line.length).inject(0) do |line_score, i|
          line[i] == target_line[i] ? line_score : line_score + 1
        end
      end
      if(best_score.nil? || score < best_score)
        fittest = child
        best_score = score
      end
    end
    fittest.join("\n")
  end
end


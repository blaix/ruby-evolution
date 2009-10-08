module Enumerable
  def random
    self[rand(size)]
  end
end

class Individual
  def initialize(information = nil)
    @information = information || [rand(10000), rand(10000), rand(10000), rand(10000)]
  end
  
  def [](range)
    @information[range]
  end
  
  def []=(index, value)
    @information[index] = value
  end

  def fitness(target)
    sum = @information.inject(0) { |sum, i| sum + i }
    (target - sum).abs
  end
  
  def to_s
    @information.inspect
  end
end

class Population
  attr_reader :individuals
  
  def initialize
    @individuals = []
    100.times do
      @individuals << yield
    end
  end
  
  def fittest(n)
    sorted = @individuals.sort_by { |individual| individual.fitness(@target) }
    sorted[0...n]
  end
  
  def evolve(target, generations = 10)
    @target = target
    generations.times do
      # show the 3 fittest each generation
      puts fittest(3).inspect
      parents = fittest(50)
      @individuals = procreate(parents)
    end
    fittest(1)
  end
  
  def procreate(parents)
    children = []
    (rand(100) + 1).times do 
      daddy = parents.random # TODO: prevent inbreading
      mommy = parents.random
      (rand(100) + 1).times do
        child = Individual.new(daddy[0...2] + mommy[2...4])
        # 5% chance of random mutation
        mutate(child) if rand(100) < 5
        children << child
      end
    end
    children
  end
  
  def mutate(individual)
    individual[rand(4)] = rand(100)
  end
end

population = Population.new { Individual.new }
puts population.evolve(100)

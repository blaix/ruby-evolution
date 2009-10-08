require 'mutation_with_selection_2d'

start = <<-END
###############
###############
###############
###############
###############
###############
###############
END

finish = <<-END
   #########   
 #           # 
#    #   #    #
#      #      #
#   |_____|   #
  #          # 
    #######    
END

# If we allow all ascii characters
# this will take way too long to run.
characters = [' ', '#', '_', '|']

machine2d = EvolutionMachine2D.new(:characters => characters)
machine2d.evolve(start.chop, finish.chop)

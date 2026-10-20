#= A very simple predator prey relationship with graph plotting for population results after the simulation is complete.
    The simulation usually ends with total extinction.
    =#

# Libraries
using Plots
using Random

# Simulate the predators and prey
function simulate(prey, food, predators, prey_array, predator_array, time_array)
    # Iterate for set number of steps
    for i in range(2, length(time_array))
        if prey > 0
            # Calculate the number of prey deaths with some randomisation
            prey_deaths = div(trunc((sqrt(predators * prey))), rand(2:10))
            # Remove prey deaths from the prey population
            prey -= prey_deaths
            # Randomly simulate natural death of some predators
            predator_deaths = div(predators, rand(2:100))
            # Remove predator deaths from predator population
            predators -= predator_deaths
            # Simulate predator reproduction
            if predators > 2
                predators += div(trunc((sqrt(predators * prey_deaths))), rand(2:10))
            end

            # Stop negative population
            if prey < 0
                prey = 0
            # Simulate prey reproduction
            elseif prey > 2
                prey += div(prey, rand(4:8))
            end

        else
            # Simulate predator starvation
            predators -= div(predators, rand(10:16))
            
            # Stop negative population
            if predators <= 0
                predators = 0
            end

        end

        # Update values to population arrays for graph
        push!(prey_array, prey)
        push!(predator_array, predators)

    end

end

# Plot graph of populations after simulation concludes
function plot_results(prey_array, predator_array, time_array)
    x = time_array
    y1 = prey_array
    y2 = predator_array
    plot(x, [y1, y2], label=["Prey" "Predator"])
end

# Initial starting values
prey = 100
food = 500
predators = 4
simulation_time = 250
# Arrays for graph data
prey_pop = [prey]
predator_prop = [predators]
time = [0:simulation_time;]

# Run program
simulate(prey, food, predators, prey_pop, predator_prop, time)
plot_results(prey_pop, predator_prop, time)

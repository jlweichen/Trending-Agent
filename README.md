# Trending-Agent
This is just a script in R to extract what is trending at a location. I have the script set up to check what's trending at a specified set of coordinates every five minutes over a specified number of times. The default is Soldier Field in Chicago, but the script can be easily altered to find what is trending in the location closest to any given set of coordinates.

For instance, below is a line graph created with the ggplot2 package illustrating the top sports trends in the New York area on December 31, 2017. Each color relates to a different professional sport. Notice that there are very few NFL tweets before the kickoff of the day's first block of games, but a slew of NFL trends afterwards. They are replaced by a new set of NFL-related trends after kickoff of the second block of games.

![top trends in NYC relating to sports](nyctoptrends.png)

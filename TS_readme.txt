*Initial Solution

  The initial solution is randomly generated. 

*Neighbors of each schedule

  Each schedule will have (m-1)*n neighbors, where m is the number of machines, and n is the number of jobs. Neighbors will only have one job scheduled on a different machine.

*Finding the best neighbor

  In order the find the neighbor with the lowest cost, the algorithm will loop through every  valid neighbor and evaluate its cost. The neighbor with the lowest cost will be selected as the best neighbor.

*Tabulist

  The list length of the tabulist is user-defined. The tabulist acts like a queque (first in first out) in which the oldest move will be deleted when a new move is appended. A new move is appended every time after finding a best neighbor.




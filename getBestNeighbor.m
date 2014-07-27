function [bestNeighbour, bestNeighbourCost, newTabuList, cantMove] = ...
  getBestNeighbor(schedule, jobs, m, n, tabuList, knownBestCost, costFunc)
  neighbor = schedule;
  bestNeighbour = schedule;
  newTabuList = tabuList;
  job_to_mutate=0;
  new_machine=0;
  bestNeighbour_initialized = 0;
  move = zeros(2,1);
  cantMove=0;

  tabuList_transposed = transpose(tabuList);
  for i = 1 : n
    job_to_mutate=i;
    for j = 1 : m
      new_machine=j;
      neighbor = schedule;
      if(new_machine ~= schedule(job_to_mutate))
        if(bestNeighbour_initialized==0)
          bestNeighbour(i)=j;
          move = [i;j];
          bestNeighbour_initialized = 1;
        else
          neighbor(i)=j;
          if (ismember([i,j],tabuList_transposed,'rows')) %[i;j] is in tabu list
            if (costFunc(neighbor, jobs, m, n)<knownBestCost)
              bestNeighbour = neighbor;
              move = [i;j];
            end
          else %[i;j] not in tabu list
            if(costFunc(neighbor, jobs, m, n) < costFunc(bestNeighbour, jobs, m, n))
              neighborBestCost = costFunc(neighbor, jobs, m, n);
              bestNeighbour = neighbor;
              move = [i;j];
            end
          end
        end
      end
    end
  end

  if (move==[0;0])
    cantMove=1;
  else % update tabuList if a move is available
    newTabuList = tabuList(:,2:end);
    newTabuList = [newTabuList move];
  end
  bestNeighbourCost = costFunc(bestNeighbour, jobs, m, n);
end

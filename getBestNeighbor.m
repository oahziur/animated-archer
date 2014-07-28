function [bestNeighbour, bestNeighbourCost, newTabuList] = ...
  getBestNeighbor(schedule, jobs, m, n, tabuList, knownBestCost, costFunc)
  total_move_number = (m-1)*n;
  all_valid_moves = zeros(total_move_number,3);
  neighbor = schedule;
  newTabuList = tabuList;
  row = 1;

  for i = 1 : n
    for j = 1 : m
      neighbor = schedule;
      if(j ~= schedule(i))
        neighbor(i)=j;
        all_valid_moves(row,:) = [i,j,costFunc(neighbor, jobs, m, n)];
        row = row+1;
      end
    end
  end
  all_valid_moves = sortrows(all_valid_moves,3);

  for i = 1 : total_move_number
    neighbor = schedule;
    job = all_valid_moves(i,1);
    machine = all_valid_moves(i,2);
    cost = all_valid_moves(i,3);
    neighbor(job)=machine;

    % if in tabu list
    if(ismember([job,machine],tabuList,'rows'))
      if(cost < knownBestCost)
        bestNeighbour = neighbor;
        bestNeighbourCost = cost;
        break;
      end
    % not in tabu list
    else
      bestNeighbour = neighbor;
      bestNeighbourCost = cost;
      break;
    end
  end

  %updating tabu list
  newTabuList(1,:)=[];
  newTabuList(end+1,:)=[job,machine];
end

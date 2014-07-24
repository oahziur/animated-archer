function [result] = cost(schedule, jobs, m, n)
  results = zeros(1, m);
  if n == 0
     result = 0;
  else
    for i = 1:n
      results(schedule(i)) = results(schedule(i)) + jobs(i);
    end
    result = max(results);
  end
end

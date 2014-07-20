function [result] = cost(schedule, jobs, m, n)
  results = zeros(1, m);
  for i = 1:n
    results(schedule(i)) = results(schedule(i)) + jobs(i);
  end
  result = max(results);
end

function [sT] = findStartTemp(jobs, m)
  sT = 0;
  maxChange = max(jobs);
  avgExeTime = sum(jobs) / m;
  if (avgExeTime > maxChange)
    maxChange = avgExeTime;
  end
  sT = -1* maxChange / log(0.85);
end

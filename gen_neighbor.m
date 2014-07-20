function [neighbor] = gen_neighbor(schedule, m, n)
  neighbor = schedule;
  job_to_mutate = randi([1, n], 1);
  new_machine = randi([1, m], 1);
  while new_machine == schedule(job_to_mutate)
    new_machine = randi([1, m], 1);
  end
  neighbor(job_to_mutate) = new_machine;
end

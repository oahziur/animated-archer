function [costs, bestSol] = PSO(jobs, m, n, particals, iterations, costFunc)
  c1 = 1.4944;
  c2 = 1.4944;
  w = 0.79;
  gbests = ones(1, n);
  gbest = costFunc(gbests, jobs, m, n);
  lbests = randi(m, particals, n);
  lbest = ones(1, particals);
  costs = ones(iterations, 1);
  costsEnd = 0;
  for i = 1:particals
      lbest(i) = costFunc(lbests(i, :), jobs, m, n);
      if lbest(i) < gbest
          gbest = lbest(i);
          gbests = lbests(i, :);
      end
  end
  x = lbests;
  v = zeros(particals, n);
  
  for i = 1:iterations
      ibest = costFunc(ones(particals, n), jobs, m, n);
      r1 = rand(particals, 1);
      r2 = rand(particals, 1);
      v = w*v + c1 * bsxfun(@times, r1, lbests - x) + ...
        c2 * bsxfun(@times, r2, (bsxfun(@minus, gbests, x)));
      x = round(x + v);
      %x = bsxfun(@mod, x, m) + 1;
      x(x < 1) = 1;
      x(x > m) = m;
      for j = 1:particals
          c = costFunc(x(j, :), jobs, m, n);
          if c < ibest
              ibest = c;
          end
          if c < lbest(j)
              lbest(j) = c;
              lbests(j, :) = x(j, :);
          end
      end
      costsEnd = costsEnd + 1;
      costs(costsEnd) = ibest;
      [ilbest, idx] = min(lbest);
      %ibest
      ilbests = lbests(idx, :);
      if ilbest < gbest
          gbest = ilbest;
          gbests = ilbests;
      end
  end
  bestSol = gbests;
end
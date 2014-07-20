function [] = gen_neighbor_test()
  S = [1, 1, 2, 2, 3, 3];
  N = gen_neighbor(S, 3, 6);
  diff = 0;
  for i = 1:6
    if S(i) != N(i)
      diff = diff + 1;
    end
  end
  if diff == 1
    disp("gen_neighbor function PASSED!");
  else
    disp("gen_neighbor function FAILED!");
end

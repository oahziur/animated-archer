function [] = cost_test()
  S = [1, 2, 2, 3, 1, 1];
  J = [2, 3, 4, 6, 2, 2];
  result = cost(S, J, 3, 6);
  if result == 7
    disp("cost function test PASSED!");
  else
    disp("cost function test FAILED!");
end

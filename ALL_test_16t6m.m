function [] = ALL_test_16t6m()
  n = 1000;
  t(1) = cputime;
  GACost = GA_16t6m_test(n);
  t(2) = cputime;
  PSOCost = PSO_16t6m_test(n);
  t(3) = cputime;
  TSCost = TS_16t6m_test(n);
  t(4) = cputime;
  SACost = SA_16t6m_test(n);
  t(5) = cputime;
  ACOCost = ACO_16t6m_test(n);
  t(6) = cputime;
  diff(t)

  % SAVE COST TO DISK


  hold on;
  plot(GACost, 'b');
  plot(PSOCost, 'k');
  plot(SACost, 'c');
  plot(ACOCost, 'r');
  plot(TSCost, 'g');
  legend(' GA ', ' PSO ', ' SA ', ' ACO ', ' TS ');
  title(' Iteration plot for 16 task on 6 machine ');
  hold off;
end

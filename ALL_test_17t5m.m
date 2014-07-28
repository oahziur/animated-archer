function [] = ALL_test_17t5m()
  n = 1000;
  t(1) = cputime;
  GACost = GA_17t5m_test(n);
  t(2) = cputime;
  PSOCost = PSO_17t5m_test(n);
  t(3) = cputime;
  TSCost = TS_17t5m_test(n);
  t(4) = cputime;
  SACost = SA_17t5m_test(n);
  t(5) = cputime;
  ACOCost = ACO_17t5m_test(n);
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
  title(' Iteration plot for 17 task on 5 machine ');
  hold off;
end

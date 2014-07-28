function [] = ALL_test_17t5m()
  n = 1000;

  GACost = GA_17t5m_test(n);
  PSOCost = PSO_17t5m_test(n);
  TSCost = TS_17t5m_test(n);
  SACost = SA_17t5m_test(n);
  ACOCost = ACO_17t5m_test(n);

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

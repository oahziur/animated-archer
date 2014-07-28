function [] = ALL_test_16t6m()
  n = 10;

  GACost = GA_16t6m_test(n);
  PSOCost = PSO_16t6m_test(n);
  TSCost = TS_16t6m_test(n);
  SACost = SA_16t6m_test(n);
  ACOCost = ACO_16t6m_test(n);

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

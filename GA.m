% Genetic Algorithm (Simple Demo) Matlab/Octave Program
% Written by X S Yang (Cambridge University)
% Modified by Gary Li (University of Waterloo) 2014
% Usage: gasimple or gasimple('x*exp(-x)');

%This program is modified to satify the Job Scheduling problem
%For ECE457A, Unitersity of Waterloo, Summer, 2014

%costs, Best Solution
function [costs, schedule]=GA(jobs, numberOfMachines, maxGen)
  global solnew sol pop popnew fitness fitold range userdefinedn chromesomesize jobList NumberOfMachines limitedRange;
  range=[1 numberOfMachines]; % Range/Domain
  % Initializing the parameters
  rand('state' ,0'); % Reset the random generator
  popsize=100; % Population size
  MaxGen=100; % Max number of generations
  count=0;    % counter
  nsite=2;    % number of mutation sites
  pc=0.95;    % Crossover probability
  pm=0.05;    % Mutation probability

  % Update the max generation number if max generation is given
  if nargin>1,
    MaxGen=maxGen;
    jobList=jobs;
    NumberOfMachines=numberOfMachines;
  end

  chromesomesize=length(dec2bin(numberOfMachines));
  nsbit=length(jobs)*chromesomesize;   % String length (bits)
  userdefinedn=length(jobs); %user defined n
  % Generating the initial population
  popnew=init_gen(popsize,nsbit);
  fitness=zeros(1,popsize); % fitness array
%   Display the shape of the function
  %x=range(1):0.1:range(2);
  %plot(x,felement(x,userdefinedn));
  fitold=fitness;

  % Initialize solution <- initial population
  solnew=zeros(popsize, userdefinedn);

  limitedRange=max(abs(range));

  costs=zeros(maxGen,1);

  %TODO:populate row
  for i=1:popsize,
    solnew(i,:)=bintodec(popnew(i,:));
  end

  bestfun=zeros(MaxGen,1);
  bestsol=zeros(MaxGen,length(jobs));

  %Record as the history
  fitold=fitness;
  pop=popnew;
  sol=solnew;

  % Start the evolution loop
  for i=1:MaxGen,
    % Record as the history
    for k=1:popsize,
        if(fitness(k)>=fitold(k))
            pop(k,:)=popnew(k,:);
            sol(k,:)=solnew(k,:);
            fitold(k)=fitness(k);
        else
            popnew(k,:)=pop(k,:);
            solnew(k,:)=sol(k,:);
        end
    end
    for j=1:popsize,
      % Crossover pair
      ii=floor(popsize*rand)+1;
      jj=floor(popsize*rand)+1;
      % Cross over
      if pc>rand,
        [popnew(ii,:),popnew(jj,:)]=crossover(pop(ii,:),pop(jj,:));
        % Evaluate the new pairs
        count=count+2;
        evolve(ii);
        evolve(jj);
      end

      % Mutation at n sites
      if pm>rand,
        kk=floor(popsize*rand)+1; count=count+1;
        popnew(kk,:)=mutate(pop(kk,:),nsite);
        evolve(kk);
      end
    end % end for j
    % Record the current best
    bestfun(i)=max(fitness);
    bestsols=sol(bestfun(i)==fitness,:);
    bestsol(i,:)=bestsols(1,:);
    costs(i,:)=cost(bestsol(i,:), jobs, numberOfMachines);
  end % end for i

  % Display results
  %set(gcf,'color','w');
  %subplot (2,1,1);
  %plot(bestsol);
  %title('Plot of best solution of each generation');
  %subplot(2,1,2);
  %plot(bestfun);
  %title('Fitness');

  %output
  schedule=bestsol(size(bestsol, 1),:);
%costOutput=cost(schedule, jobs, numberOfMachines);
end % end for gasimple

% All the sub functions
% generation of the initial population
function pop=init_gen(np,nsbit)
  % String length=nsbit+l with pop(:,l) for the Sign
  %pop=rand(np,nsbit)>0.5;
  pop=randi([0 1],np,nsbit);
end % end for init_gen

% Evolving the new generation
function evolve(j)
  global solnew popnew fitness fitold pop sol jobList NumberOfMachines;
  solnew(j,:)=bintodec(popnew(j,:));
  %TODO: cost(schedule, Jobs, numberOfMachine)
  fitness(j)= 1 / (1 + cost( solnew(j,:),jobList,NumberOfMachines));
  if fitness(j)>fitold(j),
    pop(j,:)=popnew(j,:);
    sol(j)=solnew(j);
%   else
%       popnew(j,:)= pop(j,:);
%     solnew(j)=sol(j);
  end
% Convert a binary string into a decimal number
end % end for evolve


function [decs]=bintodec(bins)
  global chromesomesize userdefinedn limitedRange;
  decs=zeros(1, userdefinedn);
  index=1;
  divisor=((2^chromesomesize)-1);
  for deci=1:userdefinedn,
    nindex=index+chromesomesize;
    bin=bins(index:nindex-1);
    num=bin(1:end); % get the binary
    generated=0;
    for i=1:length(bin),
      generated=generated+num(i)*2^(length(bin)-i);
    end
    dec=round((generated/divisor)*(limitedRange-1))+1;
    index=nindex;
    decs(deci)=dec;
  end
end % end for bintodec

% Crossover operator
function [c,d]=crossover(a,b)
  nn=length(a)-1;
  % generating a random crossover point
  cpoint=floor(nn*rand)+1;
  c=[a(1:cpoint) b(cpoint+1:end)];
  d=[b(1:cpoint) a(cpoint+1:end)];
end % end for crossover

% Mutatation operator
function anew=mutate(a,nsite)
  nn=length(a);
  anew=a;
  for i=1:nsite,
    j=floor(rand*nn)+1;
    anew(j)=mod(a(j)+1,2);
  end
end % end for mutation operation

% function for question 3, assume every value in vector x is same
% value
% x is the input of each value in vector x, assume each vector is same
% n is the user defined variable, which implies the size of the input
function [result]=felement(x, n)
  result=zeros(1,size(x,2));
  for i=1:size(x,2),
    absx = abs(x(i));
    absxn(1:n) = absx;
    iexp = linspace(2, n+1, n);
    result(i) = sum(absxn .^ iexp);
  end
end


function [result]=cost(schedule, jobs, numberOfMachines)
  results=zeros(1,numberOfMachines);
  for i=1:length(jobs)
    results(schedule(i)) = results(schedule(i)) + jobs(i);
  end
  result=max(results);
end

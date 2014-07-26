% Genetic Algorithm (Simple Demo) Matlab/Octave Program
% Written by X S Yang (Cambridge University)
% Usage: gasimple or gasimple('x*exp(-x)');
function [schedule,costOutput]=GA(jobs, numberOfMachines, maxGen)
global solnew sol pop popnew fitness fitold range userdefinedn chromesomesize jobList NumberOfMachines;
range=[1 numberOfMachines]; % Range/Domain
% Initializing the parameters
rand('state' ,0'); % Reset the random generator
popsize=20; % Population size
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

chromesomesize=length(dec2bin(numberOfMachines-1));
nsbit=length(jobs)*chromesomesize;   % String length (bits)
userdefinedn=length(jobs); %user defined n
% Generating the initial population
popnew=init_gen(popsize,nsbit);
fitness=zeros(1,popsize); % fitness array
% Display the shape of the function
x=range(1):0.1:range(2);
plot(x,felement(x,userdefinedn));
% Initialize solution <- initial population
solnew=zeros(popsize, userdefinedn);

%TODO:populate row
for i=1:popsize,
    solnew(i,:)=bintodec(popnew(i,:))+1;
end
% Start the evolution loop
for i=1:MaxGen,
    % Record as the history
    fitold=fitness;
    pop=popnew;
    sol=solnew;
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
end % end for i
% Display results
set(gcf,'color','w');
subplot (2,1,1);
plot(bestsol);
title('Plot of best solution of each generation');
subplot(2,1,2);
plot(bestfun);
title('Fitness');

%output
schedule=bestsol(size(bestsol, 1),:);
costOutput=cost(schedule, jobs, numberOfMachines);
end % end for gasimple

% All the sub functions
% generation of the initial population
function pop=init_gen(np,nsbit)
% String length=nsbit+l with pop(:,l) for the Sign
pop=rand(np,nsbit)>0.5;
end % end for init_gen

% Evolving the new generation
function evolve(j)
global solnew popnew fitness fitold pop sol jobList NumberOfMachines;
solnew(j,:)=bintodec(popnew(j,:))+1;
%TODO: cost(schedule, Jobs, numberOfMachine)
fitness(j)= 1 / (1 + cost( solnew(j,:),jobList,NumberOfMachines));
if fitness(j)>fitold(j),
    pop(j,:)=popnew(j,:);
    sol(j)=solnew(j);
end
% Convert a binary string into a decimal number
end % end for evolve


%TODO: Fix
function [decs]=bintodec(bins)
global range chromesomesize userdefinedn;
decs=zeros(1, userdefinedn);
index=1;
for deci=1:userdefinedn,
    nindex=index+chromesomesize;
    bin=bins(index:nindex-1);
    num=bin(1:end); % get the binary
    dec=0;
    % floating point/decimal place in a binary string
    dp=floor(log2(max(abs(range))));
    for i=1:length(bin),
        dec=dec+num(i)*2^(dp-i);
    end
    index=nindex;
    decs(deci)=round(dec);
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
for i=1:size(x,2),
    absx = abs(x(i));
    absxn(1:n) = absx;
    iexp = linspace(2, n+1, n);
    result(i) = sum(absxn .^ iexp);
end
end

% function for question 3, assume every value in vector x is different
function [result]=fvector(x)
absxn = abs(x);
iexp = linspace(2, size(x, 2)+1, size(x,2));
result = sum(absxn .^ iexp);
end

function [result]=cost(schedule, jobs, numberOfMachines)
results=zeros(1,numberOfMachines);
for i=1:length(jobs)
    results(schedule(i)) = results(schedule(i)) + jobs(i);
end
result=max(results);
end

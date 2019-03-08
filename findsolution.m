global task morework fastertime;
task=[17;3;10;2;10;3;8;11;2;2;3;12;4;4;1;10;1];
     %A1,A2,B1,C1,D1,E1,E2,F1,F2,F3,G1,G2,G3,G4,G5,G6,H1
     %1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,11,12,13,14,15,16,17
morework=[1,3,7,8,10,12,14];
fastertime=[10,2,5,6,1,5,2];
cost=[100,500,25,720,30,35,50];
mincost=9999999999;
best_sol=ones(7);
besti=999;
for i=0:1:127
    [keypath,solution]=callength(i);
    maxpath=max(keypath);
    if maxpath<=21
        sol_cost=sum(cost(solution==1));
        if sol_cost<mincost
            best_sol=solution;
            mincost=sol_cost;
            besti=i;
        end
    end
end
[keypath,~]=callength(besti);
[M,I]=max(keypath);
disp(I);
function [keypath,solution]=callength(number)
    global task morework fastertime;
    thistask=task;
    keypath=zeros(1,6);
    solution=decode(number);
    thistask(morework(solution==1))=fastertime(solution==1);
    keypath(1)=task(1)+task(2);
    keypath(2)=task(4);
    keypath(3)=task(5);
    if thistask(3)<thistask(6)+thistask(7)
        keypath(4)=thistask(6)+thistask(7)+thistask(8)+thistask(9)+thistask(10);
    else
        keypath(4)=thistask(3)+thistask(8)+thistask(9)+thistask(10);
    end
    if thistask(13)<thistask(11)+thistask(12)
        keypath(5)=thistask(11)+thistask(12)+thistask(14)+thistask(15)+thistask(16);
    else
        keypath(5)=thistask(13)+thistask(14)+thistask(15)+thistask(16);
    end
    keypath(6)=thistask(17);
end
function [solution]=decode(number)
    n=7;
    solution=zeros(1,n);
    for i=1:1:n
        if abs(number-1)<0.01
            solution(i)=1;
            solution(i+1:n)=0;
            break;
        end
        if mod(number,2)==0
            solution(i)=0;
            number=number/2;
        else
            solution(i)=1;
            number=(number-1)/2;
        end    
    end
end

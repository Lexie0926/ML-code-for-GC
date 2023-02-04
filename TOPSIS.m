load data.mat

[n,m] = size(X);
disp(['total' num2str(n) 'experiments, ' num2str(m) 'factors']) 
Judge = input(['this' num2str(m) 'whether the forward processing is required，yes 1 ，no 0：  ']);

if Judge == 1
    Position = input('lease enter the column of the indicator that needs to be forward processed. For example, columns 2,3, and 6 need to be processed, then you need to enter [2,3,6]  '); %input for example [2,3,6]
    disp('Please enter the index type of the columns you want to process (1: very small, 2: intermediate, 3: interval) ')
    Type = input(' For example, if column 2 is extremely small, column 3 is interval type, and column 6 is intermediate type, enter [1,3,2] :  '); %[2,1,3]
    
    for i = 1 : size(Position,2)  %number of recycle
        X(:,Position(i)) = Positivization(X(:,Position(i)),Type(i),Position(i));
    end
    disp('matrix after  X =  ')
    disp(X)
end

function [posit_x] = Min2Max(x)
    posit_x = max(x) - x;
     %posit_x = 1 ./ x;    %if all x>0
end

function [posit_x] = Mid2Max(x,best)
    M = max(abs(x-best));
    posit_x = 1 - abs(x-best) / M;
end

function [posit_x] = Inter2Max(x,a,b)
    r_x = size(x,1);  % row of x 
    M = max([a-min(x),max(x)-b]);
    posit_x = zeros(r_x,1);  
    for i = 1: r_x
        if x(i) < a
           posit_x(i) = 1-(a-x(i))/M;
        elseif x(i) > b
           posit_x(i) = 1-(x(i)-b)/M;
        else
           posit_x(i) = 1;
        end
    end
end


 
function [posit_x] = Positivization(x,type,i)
    if type == 1 
        disp(['NO' num2str(i) 'proceeding'] )
        posit_x = Min2Max(x);  
        disp(['NO' num2str(i) 'completed'] )
        disp('~~~~~~~~~~~~~~~~~~~~Boundary~~~~~~~~~~~~~~~~~~~~')
    elseif type == 2  
        disp(['NO' num2str(i) 'proceeding'] )
        best = input('Best value： ');
        posit_x = Mid2Max(x,best);
        disp(['NO' num2str(i) 'proceeding'] )
        disp('~~~~~~~~~~~~~~~~~~~~Boundary~~~~~~~~~~~~~~~~~~~~')
    elseif type == 3 
        disp(['NO' num2str(i) 'proceeding'] )
        a = input('lower bound： ');
        b = input('upper bound： '); 
        posit_x = Inter2Max(x,a,b);
        disp(['NO' num2str(i) 'proceeding'] )
        disp('~~~~~~~~~~~~~~~~~~~~Boundary~~~~~~~~~~~~~~~~~~~~')
    else
        disp('There is no indicator of this Type, check if there are any values other than 1, 2, or 3 in the type vector')
    end
end

Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
disp('Normalized matrix Z = ')
disp(Z)

D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ],2) .^ 0.5;   
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ],2) .^ 0.5;   
S = D_N ./ (D_P+D_N);    
disp('The final score is：')
stand_S = S / sum(S)
%[sorted_S,index] = sort(stand_S ,'descend')
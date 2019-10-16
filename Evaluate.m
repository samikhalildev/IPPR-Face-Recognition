function [Accuracy,Precision,Recall,F1_score] = Evaluate(confmat)

[row,column] = size(confmat);
numClass= row;

TP=zeros(1,numClass);
FN=zeros(1,numClass);
FP=zeros(1,numClass);
TN=zeros(1,numClass);
for i=1:numClass
    TP(i)=confmat(i,i);
    FN(i)=sum(confmat(i,:))-confmat(i,i);
    FP(i)=sum(confmat(:,i))-confmat(i,i);
    TN(i)=sum(confmat(:))-TP(i)-FP(i)-FN(i);
end
P=TP+FN;
N=FP+TN;

%Accuracy
accuracy= TP./(P+N);
Accuracy=sum(accuracy);

%Precision
Precision = TP./(TP+FP);
Precision(isnan(Precision))=[];
Precision=mean(Precision);

%Recall
Recall = TP./(TP+FN);
Recall(isnan(Recall))=[];
Recall=mean(Recall);

%F1
F1_score=(2*Recall*Precision)/(Recall+Precision);

%Print
fprintf("Accuracy == %f \n",Accuracy);
fprintf("Precision == %f \n",Precision);
fprintf("Recall == %f \n",Recall);
fprintf("F1 == %f \n",F1_score);

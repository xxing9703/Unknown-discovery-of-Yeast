function score=dot_prod(A,B,tol)

[~, AB_full]=merge_specAB(A,B,tol);
MSA=AB_full(:,2); % is the intensities of 1st spect after merge
MSB=AB_full(:,3); % is the intensities of 2nd spect after merge
score=sum(MSA.*MSB)/sqrt(sum(MSA.^2) *sum(MSB.^2));
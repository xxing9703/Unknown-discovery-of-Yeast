% elem is the double type matrix containing [m, lb, ub], 
% [mass err]is the mass to be evaluated, iter records the total # interations 

function [combo]=get_mass_combos2(elem,mass,err)

%iter=iter+1;
combo=[];
count=0;
pos=size(elem,1); %take the last (heaviest) element

wt = elem(pos,1); %element mass
lb = elem(pos,2);  % min count
ub = elem(pos,3);  % max count

kmax = min(floor((mass+err)/ wt),ub);
kmin = lb;
   if pos>1
        for k=kmin:kmax
            mass_cut    = k * wt;  % take away mass_cut
            nlo = mass - mass_cut - err;  
            nhi = mass - mass_cut + err;
            
            if nlo <= 0 && nhi >= 0  %found
                combo=[zeros(1,pos-1),k];
            else  % keep looking
                [cc]=get_mass_combos2(elem(1:pos-1,:),mass - mass_cut,err);                
                for i=1:size(cc,1)
                    combo(count+i,:)=[cc(i,:),k];
                end
                count=count+size(cc,1);
            end
        end
   else      
        kmax = min(ceil((mass + err) / wt),ub);
        kmin = lb;
        for k=kmin:kmax
            mass_cut    = k * wt;
            nlo = mass - mass_cut - err;  
            nhi = mass - mass_cut + err;           
            if nlo <= 0 && nhi >= 0  %found
               combo=k;
            end
           
        end
    end

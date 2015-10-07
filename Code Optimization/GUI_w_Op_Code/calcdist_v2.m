function [distance] = calcdist_v2(ps,pe,pc)

vx      = ps(1) - pe(1);	%Differenz x
vy      = ps(2) - pe(2);	%Differenz y
vz      = ps(3) - pe(3);	%Differenz z
vsquare = (vx*vx) + (vy*vy) + (vz*vz);

lx      = ((ps(1) - pc(1)) * vx);
ly      = ((ps(2) - pc(2)) * vy); 
lz      = ((ps(3) - pc(3)) * vz);
lambda  = (lx + ly+ lz) / vsquare;

cx = ps(1) - pc(1) - (lambda * vx);
cy = ps(2) - pc(2) - (lambda * vy);
cz = ps(3) - pc(3) - (lambda * vz);

distance = (cx*cx) + (cy*cy) + (cz*cz);
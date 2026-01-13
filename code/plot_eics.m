function plot_eics(ax,pk)
eics=pk.eics;
cl='bbbrrrggg';
for i=1:length(eics) % 7X1 cell
  dt=eics{i};
  hold(ax,'on');
  plot(ax, dt(:,1),dt(:,2),cl(i))  
end

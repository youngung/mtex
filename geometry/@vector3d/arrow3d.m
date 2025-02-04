function h = arrow3d(vec,varargin)
% plot three dimensional arrows
%
% Syntax
%   arrow3d(v)
%
% Input
%
% See also
% savefigure vector3d/scatter3 vector3d/plot3 vector3d/text3

% where to plot
if check_option(varargin,'parent')
  ax = get_option(varargin,'parent');
else
  ax = gca;
end

% do not change caxis
cax = caxis(ax);

% length of the arrows
vec = 1.2.*vec;
lengthTail = 0.9;
radiHead = 0.05;
radiTail = 0.02;


for i = 1:length(vec)
  
  v = vec.subSet(i);
  
  % the center line of the arrow
  c = [vector3d(0,0,0),vector3d(0,0,0),v.*lengthTail,v.*lengthTail,v];

  % the radii
  r = [0,radiTail,radiTail,radiHead,0] .* norm(v);

  % a normal vector
  n = rotate(v.orth,rotation('axis',v,'angle',linspace(0,2*pi,50)));

  % the hull of the arrow
  hull = repmat(c,length(n),1) + n * r;

  % plot as surface plot
  h(i) = optiondraw(surf(hull.x,hull.y,hull.z,'parent',ax,...
    'facecolor','k','edgecolor','none'),varargin{:});
  
end

% set caxis back
caxis(ax,cax);

% set axis to 3d
axis(ax,'equal','vis3d','off');

% st box limits
bounds = [-1 1] * max(norm(vec(:)));
set(ax,'XDir','rev','YDir','rev','XLim',bounds,'YLim',bounds,'ZLim',bounds);

if nargout == 0, clear h;end

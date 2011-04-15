function fig = ghalt(varargin);
% ghalt(...)
% Temps
ffig = ne_group(varargin,'Temps','phaltsfb','phaltsff','phaltsf2b','phaltsf2f');
if nargout > 0 fig = ffig; end
% Removed ,'phalta','phalte' Air*T and Exh*T

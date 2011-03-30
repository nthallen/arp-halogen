function fig = ghall(varargin);
% ghall(...)
% Lamps
ffig = ne_group(varargin,'Lamps','phalldt','phallir','phallirs','phalllmt','phallp','phallrf','phallrfs','phalls');
if nargout > 0 fig = ffig; end

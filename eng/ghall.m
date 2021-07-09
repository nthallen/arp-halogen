function fig = ghall(varargin);
% ghall(...)
% Lamps
ffig = ne_group(varargin,'Lamps','phallir','phallirs','phalllmt','phallp','phallrfbw','phallrffw','phallrfs','phalls');
if nargout > 0 fig = ffig; end

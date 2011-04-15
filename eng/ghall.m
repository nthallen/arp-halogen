function fig = ghall(varargin);
% ghall(...)
% Lamps PT
ffig = ne_group(varargin,'Lamps PT','phalldt','phalllmt','phallp');
% ffig = ne_group(varargin,'Lamps','phalldt','phallir','phallirs','phalllmt','phallp','phallrfbw','phallrffw','phallrfs','phalls');
if nargout > 0 fig = ffig; end

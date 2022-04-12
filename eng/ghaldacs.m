function fig = ghaldacs(varargin);
% ghaldacs(...)
% uDACS16
ffig = ne_group(varargin,'uDACS16','phaldacsp','phaldacst','phaldacsv','phaldacss');
if nargout > 0 fig = ffig; end

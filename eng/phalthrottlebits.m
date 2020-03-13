function phalthrottlebits(varargin);
% phalthrottlebits( [...] );
% Throttle Bits
h = ne_dstat({
  'Scan', 'IXStt', 0 }, 'Bits', varargin{:} );

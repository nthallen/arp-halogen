function phalls(varargin);
% phalls( [...] );
% Lamps Status
h = ne_dstat({
  'Lmp_A', 'DS84A', 4; ...
	'Lmp_B', 'DS84A', 5; ...
	'Lmp_C', 'DS84A', 6; ...
	'Lmp_D', 'DS84A', 7 }, 'Status', varargin{:} );
function phalrfa(varargin);
% phalrfa( [...] );
% RF Alive
h = ne_dstat({
  'A_ok', 'RFDalive', 0; ...
	'B_ok', 'RFDalive', 1; ...
	'C_ok', 'RFDalive', 2; ...
	'D_ok', 'RFDalive', 3 }, 'Alive', varargin{:} );

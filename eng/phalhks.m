function phalhks(varargin);
% phalhks( [...] );
% HK Switches
h = ne_dstat({
  'CpSw0', 'IOSwS', 4; ...
	'CpSw1', 'IOSwS', 5; ...
	'Fail0', 'FailS', 0; ...
	'Fail1', 'FailS', 1; ...
	'IOSw0', 'IOSwS', 0; ...
	'IOSw1', 'IOSwS', 1 }, 'Switches', varargin{:} );

function phalpressuret(varargin);
% phalpressuret( [...] );
% Pressure T
h = timeplot({'SDP1T','SDP2T'}, ...
      'Pressure T', ...
      'T', ...
      {'SDP1T','SDP2T'}, ...
      varargin{:} );
function phallrfs(varargin);
% phallrfs( [...] );
% Lamps RF Set
h = timeplot({'RFASet','RFBSet','RFCSet','RFDSet'}, ...
      'Lamps RF Set', ...
      'RF Set', ...
      {'RFASet','RFBSet','RFCSet','RFDSet'}, ...
      varargin{:} );

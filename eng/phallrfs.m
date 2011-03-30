function phallrfs(varargin);
% phallrfs( [...] );
% Lamps RF Set
h = timeplot({'RFASet','RFBSet','RFCSet','RFDSet'}, ...
      'Lamps RF Set', ...
      'RFSet', ...
      {'RFASet','RFBSet','RFCSet','RFDSet'}, ...
      varargin{:} );
function phallrf(varargin);
% phallrf( [...] );
% Lamps RF
h = timeplot({'ARFBW','ARFFW','BRFBW','BRFFW','CRFBW','CRFFW','DRFFW','DRFBW'}, ...
      'Lamps RF', ...
      'RF', ...
      {'ARFBW','ARFFW','BRFBW','BRFFW','CRFBW','CRFFW','DRFFW','DRFBW'}, ...
      varargin{:} );

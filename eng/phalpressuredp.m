function phalpressuredp(varargin);
% phalpressuredp( [...] );
% Pressure DP
h = timeplot({'SD1DP','SD2DP'}, ...
      'Pressure DP', ...
      'DP', ...
      {'SD1DP','SD2DP'}, ...
      varargin{:} );
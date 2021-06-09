function phaltsf2b(varargin);
% phaltsf2b( [...] );
% Temps SF2B
h = timeplot({'SF2B0','SF2B1','SF2B2','SF2B3','SF2B4','SF2B5','SF2B6','SD2TSP','SF2BTemp'}, ...
      'Temps SF2B', ...
      'SF2B', ...
      {'0','1','2','3','4','5','6','S','T'}, ...
      varargin{:} );

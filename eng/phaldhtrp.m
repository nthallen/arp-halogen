function phaldhtrp(varargin);
% phaldhtrp( [...] );
% D Htr Pwr
h = timeplot({'DH1P','DH2P','DHP'}, ...
      'D Htr Pwr', ...
      'Pwr', ...
      {'DH1P','DH2P','Total'}, ...
      varargin{:} );

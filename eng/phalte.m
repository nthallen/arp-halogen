function phalte(varargin);
% phalte( [...] );
% Temps Exh
h = timeplot({'Exh1T','Exh2T','Exh3T','Exh4T'}, ...
      'Temps Exh', ...
      'Exh', ...
      {'Exh1T','Exh2T','Exh3T','Exh4T'}, ...
      varargin{:} );
function phalgdt(varargin);
% phalgdt( [...] );
% Gas Deck T
h = timeplot({'Air_T','Gas1T','Gas2T','Gas3T','Gas4T','Gas5T'}, ...
      'Gas Deck T', ...
      'T', ...
      {'Air\_T','1','2','3','4','5'}, ...
      varargin{:} );

function phaldacst(varargin);
% phaldacst( [...] );
% uDACS16 T
h = timeplot({'MS5607_T','TRU1T','TRU2T','TRU3T','TRUIB1T','TRUIB2T'}, ...
      'uDACS16 T', ...
      'T', ...
      {'MS5607\_T','TRU1T','TRU2T','TRU3T','TRUIB1T','TRUIB2T'}, ...
      varargin{:} );
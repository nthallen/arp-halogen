function phalpvv(varargin);
% phalpvv( [...] );
% Power V28V
h = timeplot({'V28V1','V28V2','V28V3','V28V4'}, ...
      'Power V28V', ...
      'V28V', ...
      {'V28V1','V28V2','V28V3','V28V4'}, ...
      varargin{:} );

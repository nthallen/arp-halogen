function phalthrottles(varargin);
% phalthrottles( [...] );
% Throttle Step
h = timeplot({'SV1Step','SV2Step'}, ...
      'Throttle Step', ...
      'Step', ...
      {'SV1Step','SV2Step'}, ...
      varargin{:} );

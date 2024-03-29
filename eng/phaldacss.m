function phaldacss(varargin);
% phaldacss( [...] );
% uDACS16 Status
h = ne_dstat({
  'LED_Grn', 'uDACS16_CmdStat', 0; ...
	'LED_Red', 'uDACS16_CmdStat', 1; ...
	'TRU_cmd', 'uDACS16_CmdStat', 3; ...
	'uD16_I2C_COLL', 'uDACS16_ADC_Status', 0; ...
	'uD16_I2C_BUSY', 'uDACS16_ADC_Status', 1; ...
	'uD16_I2C_BUS', 'uDACS16_ADC_Status', 2; ...
	'uD16_I2C_ADDR', 'uDACS16_ADC_Status', 3; ...
	'uD16_I2C_ARB', 'uDACS16_ADC_Status', 4; ...
	'uD16_I2C_NACK', 'uDACS16_ADC_Status', 5 }, 'Status', varargin{:} );

function axsout = chamber_est2(pattern, verbosity)
cd C:\Data\Halogens\Analysis
if nargin < 1; pattern = '*F'; end
if nargin < 2; verbosity = 0; end
Eliminate = [];
Chamber.F210609_2F = 828; ZeroT.F210609_2F = 0;
Chamber.F210614_3F = 816; ZeroT.F210614_3F = 0;
Chamber.F210617_2F = 830; ZeroT.F210617_2F = 0;
% Chamber.F210713_1F = 710; ZeroT.F210713_1F = 0;
Chamber.F210717_1F = 620; ZeroT.F210717_1F = 0;
Chamber.F210721_1F = 740; ZeroT.F210721_1F = 0;
Chamber.F210723_2F = 710; ZeroT.F210723_2F = 0;
Chamber.F210726_2F = 850; ZeroT.F210726_2F = 0;
Chamber.F210729_2F = 680; ZeroT.F210729_2F = 0;
Chamber.F210802_3F = 680; ZeroT.F210802_3F = 25;
% Chamber.F210807_1F = 710; ZeroT.F210807_1F = 25;
Chamber.F210810_2F = 600; ZeroT.F210810_2F = 25;
Chamber.F210814_2F = 640; ZeroT.F210814_2F = 25;
Chamber.F210817_2F = 820; ZeroT.F210817_2F = 25;
% Chamber.F210820_1F = 710; ZeroT.F210820_1F = 25;
Chamber.F210913_1F = 612; ZeroT.F210913_1F = 25;
Navg = 60; % 16 points, 4 seconds
%%
flights = dir(pattern);
figs = [];
for fi = 1:length(flights)
  cd C:\Data\Halogens\Analysis
  rundir = flights(fi).name;
  run = [ 'F' strrep(rundir,'.','_')];
  if ~isfield(Chamber, run)
    fprintf(1,'Skipping flight %s\n', rundir);
    continue;
  end
  fprintf(1,'Running flight %s\n', rundir);
  cd(rundir);
  %%
  H1 = ne_load('haleng_1','Hal_Data_Dir');
  H4 = ne_load('haleng_4','Hal_Data_Dir');
  S11 = ne_load('SolAd11','Hal_Data_Dir');
  T11 = time2d(S11.TSolAd11);
  S12 = ne_load('SolAd12','Hal_Data_Dir');
  run = [ 'F' strrep(getrun(1),'.','_')];
  ZeroTemp = ZeroT.(run);
  cool = S12.SF1BTemp_Z >= ZeroTemp-15 & S12.SF1BTemp_Z <= ZeroTemp+15; % & SF1BT_4 > -20;
  %%
  f = figure;
  if bitand(verbosity,2)
    Density = S11.SD1_P_Z(cool)./(S12.SF1BTemp_Z(cool)+273.15);
    sc = scatter(Density,S11.DetB_Z(cool),10,time2d(S11.TSolAd11(cool)));
    sc.DataTipTemplate.DataTipRows(1).Label = 'P/T:';
    xlabel('P/T');
    xdesc = 'P/T';
  else
    sc = scatter(S11.SD1_P_Z(cool),S11.DetB_Z(cool),10,time2d(S11.TSolAd11(cool)));
    sc.DataTipTemplate.DataTipRows(1).Label = 'SD1\_P\_Z';
    xlabel('SD1\_P\_Z');
    xdesc = 'Pressure';
  end
  sc.Parent.Color = 0.3 * [1 1 1];
  c = colorbar;
  c.Label.String = 'Time';
  sc.Marker = '.';
  sc.SizeData = 500;
  sc.DataTipTemplate.DataTipRows(2).Label = 'DetB\_Z';
  row = dataTipTextRow('Time','CData');
  sc.DataTipTemplate.DataTipRows(3) = row;
  title(sprintf('%s: DetB\\_Z vs %s, Heater Off', rundir, xdesc));
  ylabel('DetB\_Z');
  cd C:\Data\Halogens\Analysis
  figs(end+1) = f;
  if bitand(verbosity,1)
    savefig(f,[run '.fig']);
  end
end
gyl = [];
gxl = [];
axs = [];
for i=1:length(figs)
  f = figs(i);
  ax = findobj(f,'type','Axes');
  axs(end+1) = ax;
  xl = ax.XLim;
  yl = ax.YLim;
  if isempty(gyl)
    gxl = xl;
    gyl = yl;
  else
    gxl = [min(xl(1),gxl(1)) max(xl(2),gxl(2))];
    gyl = [min(yl(1),gyl(1)) max(yl(2),gyl(2))];
  end
end
for i=1:length(figs)
  f = figs(i);
  ax = findobj(f,'type','Axes');
  ax.XLim = gxl;
  ax.YLim = gyl;
end
if nargout > 0
  axsout = axs;
end

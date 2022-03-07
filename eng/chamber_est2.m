function [axsout, fits] = chamber_est2(pattern, verbosity)
% verbosity 1: Write figure to .fig file
% verbosity 2: Plot vs P/T instead of P
% verbosity 4: Plot residuals vs Time
cd C:\Data\Halogens\Analysis
if nargin < 1; pattern = '*F'; end
if nargin < 2; verbosity = 0; end
Eliminate = [];
Twarmups = [];
Chamber.F210609_2F = 828; ZeroT.F210609_2F = 0; Twarmups.F210609_2F = 0;
Chamber.F210614_3F = 816; ZeroT.F210614_3F = 0; Twarmups.F210614_3F = 65503;
Chamber.F210617_2F = 830; ZeroT.F210617_2F = 0; Twarmups.F210617_2F = 62169;
% Chamber.F210713_1F = 710; ZeroT.F210713_1F = 0;
Chamber.F210717_1F = 620; ZeroT.F210717_1F = 0;
Chamber.F210721_1F = 740; ZeroT.F210721_1F = 0; Twarmups.F210721_1F = 59898;
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
%-----------------------------
  Twarmups.F210609_2F = 71000; % 65589;
  Twarmups.F210614_3F = 65503;
  Twarmups.F210617_2F = 64000; % 62169;
% Twarmups.F210713_1F = 0;
  Twarmups.F210717_1F = 60000;
  Twarmups.F210721_1F = 58000; % 52758;
  Twarmups.F210723_2F = 55000;
  Twarmups.F210726_2F = 65608; % 61000; % 60000;
  Twarmups.F210729_2F = 48467;
  Twarmups.F210802_3F = 60000; % 52634;
% Twarmups.F210807_1F = 0;
  Twarmups.F210810_2F = 61565; % 53200; % 52395;
  Twarmups.F210814_2F = 51494;
  Twarmups.F210817_2F = 67212; % 60000;
% Twarmups.F210820_1F = 0;
  Twarmups.F210913_1F = 52207;

Navg = 60; % 16 points, 4 seconds
Pmax = 140;
PTmax = 0.6;
%%
flights = dir(pattern);
figs = [];
if nargout > 1; fits = []; end
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
  if isfield(Twarmups,run)
    Twarmup = Twarmups.(run);
  else
    Twarmup = 0;
  end
  cool = S12.SF1BTemp_Z >= ZeroTemp-15 & S12.SF1BTemp_Z <= ZeroTemp+15; % & SF1BT_4 > -20;
  %%
  f = figure;
  Ydata = S11.DetB_Z;
  Time = time2d(S11.TSolAd11);
  if bitand(verbosity,2)
    Xdata = S11.SD1_P_Z./(S12.SF1BTemp_Z+273.15);
    Xmax = PTmax;
    Density = Xdata(cool); % S11.SD1_P_Z(cool)./(S12.SF1BTemp_Z(cool)+273.15);
    sc = scatter(Density,Ydata(cool),10,Time(cool));
    sc.DataTipTemplate.DataTipRows(1).Label = 'P/T:';
    xlabel('P/T');
    xdesc = 'P/T';
    xvarname = 'dSdPT';
  else
    Xdata = S11.SD1_P_Z;
    Xmax = Pmax;
    sc = scatter(Xdata(cool),Ydata(cool),10,Time(cool));
    sc.DataTipTemplate.DataTipRows(1).Label = 'SD1\_P\_Z';
    xlabel('SD1\_P\_Z');
    xdesc = 'Pressure';
    xvarname = 'dSdP';
  end
  fitset = cool & Xdata <= Xmax & Time >= Twarmup;
  Vfit = polyfit(Xdata(fitset),Ydata(fitset),1);
  if nargout > 1
    fitstruct = struct('Sch', Vfit(2), xvarname, Vfit(1), 'Twarmup', Twarmup);
    fits.(run) = fitstruct;
  end
  Xline = [min(Xdata) max(Xdata)];
  Yline = polyval(Vfit,Xline);
  hold on;
  h = plot(Xline,Yline,'w');
  hold off;
  sc.Parent.Color = 0.3 * [1 1 1];
  grid on
  c = colorbar;
  c.Label.String = 'Time';
  sc.Marker = '.';
  sc.SizeData = 500;
  sc.DataTipTemplate.DataTipRows(2).Label = 'DetB\_Z';
  row = dataTipTextRow('Time','CData');
  sc.DataTipTemplate.DataTipRows(3) = row;
  title(sprintf('%s: DetB\\_Z vs %s, Heater Off', rundir, xdesc));
  ylabel('DetB\_Z');
  
  % display residuals
  if bitand(verbosity,4)
    f2 = figure;
    ax2 = [nsubplot(2,1,1) nsubplot(2,1,2)];
    resset = cool & Xdata <= Xmax;
    Twu = max(Twarmup,min(Time(resset)));
    Yfit = polyval(Vfit,Xdata);
    Resid = Ydata-Yfit;
    plot(ax2(1),Time(resset),Resid(resset),'.',[Twu Twu],[max(Resid(resset)) min(Resid(resset))],'MarkerSize',15);
    title(ax2(1),getrun);
    grid(ax2(1),'on');
    plot(ax2(2),Time,Xdata);
    linkaxes(ax2,'x');
    pause;
    delete(f2);
  end

  if bitand(verbosity,4)
    pause;
  end
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
set(axs,'GridColor',[1 1 1]);
if nargout > 0
  axsout = axs;
end

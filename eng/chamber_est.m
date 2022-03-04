function chamber_est(pattern, verbosity)
% chamber_est(pattern, verbosity)
% verbosity values combine bitwise
% verbosity 1 draws the temperature plot identifying cool and uncool
% regions
% verbosity 2 shows each fit for chamber scatter
% verbosity 4 draws the final figure showing chamber scatter and raw counts
% verbosity 8 overlays all flights vs SD2_P
if nargin < 1; pattern = '*F'; end
if nargin < 2; verbosity = 0; end
%%
cd C:\Data\Halogens\Analysis
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
if bitand(verbosity,8)
  figure;
  Sch_v_P = gca;
  legends = {};
end
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
  if ~isfield(S12,'SF1BTemp_Z')
    fprintf(1,'%s: S12 is missing SF12BTemp_Z, skipping\n', run);
    continue;
  end

  run = [ 'F' strrep(getrun(1),'.','_')];
  Sch = Chamber.(run)/4;
  ZeroTemp = ZeroT.(run);
  %%
  T1 = time2d(H1.Thaleng_1);
  SF1BT_1 = H1.SF1BTemp;
  T4 = time2d(H4.Thaleng_4);
  X4 = 1:length(T4);
  SF1BT_4 = interp1(T1,SF1BT_1,T4,'linear','extrap');
  hot = SF1BT_4 > 150;
  cool = SF1BT_4 < ZeroTemp+15; % & SF1BT_4 > -20;
  cold = SF1BT_4 < ZeroTemp-15;
  % %
  % figure;
  % plot(T4(cool),H4.DetB(cool),'.');
  % %
  % Identify contiguous regions of cool temps that are longer than 1 sec
  % figure;
  % plot(T4, cool, '.');
  % ylim([-.1 1.1]);
  %%
  starts = find(diff([0;cool])>0);
  ends = find(diff([cool;0])<0);
  if isfield(Eliminate, run)
    V = (1:length(starts)) ~= Eliminate.(run);
    starts = starts(V);
    ends = ends(V);
  end
  dur = ends-starts;
  if any(starts >= ends)
    warning('%s: Take a look at durations', rundir);
  end
  if bitand(verbosity,1)
    figure;
    plot(X4(cool),SF1BT_4(cool),'.',X4(~cool),SF1BT_4(~cool),'.');
    Vax = gca;
  end
  %%
  DetBZ = NaN*H4.DetB;
  CorrDB = NaN*H4.DetB;
  CorrDB2 = NaN*H4.DetB;
  Nregions = length(starts)-1;
  % RegTs = zeros(Nregions,2);
  % RegDs = zeros(Nregions,2);
  % RegP = zeros(Nregions,2);
  % RegTemp = zeros(Nregions,2);
  RegP2 = zeros(Nregions,1);
  RegSchFit = zeros(Nregions,2); % dSdM and Sch
  RegSchZFit = zeros(Nregions,2); % dSdM and Sch
  RegTime = zeros(Nregions,2);
  if bitand(verbosity,2); figure; end
  for i=1:Nregions
    Rpre = ends(i)-Navg+1:ends(i);
    Rpost = starts(i+1):starts(i+1)+Navg-1;
    % We have defined the regions. Now we would like to go through each
    % region and estimate Sch chamber scatter and dSdM such that signal
    % S = dSdM * P/T + Sch. For the first pass, I will use all the data
    % from Rpre through Rpost.
    Rfit = Rpre(1):Rpost(end);
    RegTime(i,:) = T4(Rfit([1 end]));
    RegP2(i) = mean(H4.SD2_P(Rfit));
    S = H4.DetB(Rfit);
    M = [H4.SD1_P(Rfit)./(SF1BT_4(Rfit)+273.15) ones(size(S)) ];
    RegSchFit(i,:) = M\S;

    % Second approach: Just use Z region values
    V11 = T11>=RegTime(i,1) & T11 <= RegTime(i,2);
    if ~any(V11)
      warning('%s: No Z in region %d', run, i);
      continue;
    end
    SZ = S11.DetB_Z(V11);
    MZ = [ S11.SD1_P_Z(V11)./(S12.SF1BTemp_Z(V11)+273.15) ones(size(SZ)) ];
    RegSchZFit(i,:) = MZ\SZ;
    if bitand(verbosity,2)
      MM = [min(M);max(M)];
      SM = MM*(RegSchFit(i,:)');
      MMZ = [min(MZ);max(MZ)];
      SMZ = MMZ*(RegSchZFit(i,:)');
      plot(M(:,1),S,'.g',MM(:,1),SM,'b',MZ(:,1),SZ,'*k', ...
        MMZ(:,1),SMZ,'r');
      hold on;
      plot(MM(:,1),SM,'r');
      hold off;
      pause;
    end
  end
  if bitand(verbosity,4)
    f = figure;
    ax = [ nsubplot(2,1,1) nsubplot(2,1,2)];
    % h = plot(ax(1), RegTime', (RegSchFit(:,1)*[1 1])','b-', ...
    %    RegTime', (RegSchFit(:,2)*[1 1])','r-');
    % set(h,'LineWidth', 3);
    % Playing games here to get the legend to match up with all these
    % segments:
    RT = [ RegTime NaN*ones(size(RegTime,1),1) ]';
    RSF = (RegSchFit(:,2)*[1 1 1])';
    RSZF = (RegSchZFit(:,2)*[1 1 1])';
    h = plot(ax(1),T4, H4.DetB, '.g', RT(:),RSF(:), 'b-', ...
      RT(:), RSZF(:),'r-', T4([1 end]), Sch * [1 1],'k');
    % This is how it was done before:
    % h = plot(ax(2),T4, H4.DetB, '.g', RegTime', (RegSchFit(:,2)*[1 1])','b-', ...
    %   RegTime', (RegSchZFit(:,2)*[1 1])','r-', ...
    %   T4([1 end]), Sch * [1 1],'k');
    set(h(1:end-1),'LineWidth', 3);
    title(ax(1),getrun);
    % grid(ax(1),'on');
    grid(ax(1),'on');
    ax(1).YAxisLocation = 'right';
    % ax(1).XTickLabel = [];
    ax(1).XTickLabel = [];
    % ylabel(ax(1), 'dS/dM');
    ylabel(ax(1), 'S_{ch}');
    M = H4.SD1_P./(SF1BT_4+273.15);
    plot(ax(2),T4,M,'.');
    ylabel(ax(2),'[M] sort of');
    linkaxes(ax,'x');
    legend(ax(1),'raw','S_{ch,all}','S_{ch,Z}','S_{ch}')
    f.WindowState = 'maximized';
    % return;
  end
  %%
  if bitand(verbosity, 8)
    plot(Sch_v_P,RegP2,RegSchZFit(:,2),'*');
    title(Sch_v_P,'Chamber Scatter vs SD2\_P');
    ylabel(Sch_v_P,'S_{ch}');
    %ylim(Sch_v_P,[80 300]);
    xlabel(Sch_v_P,'SD2\_P');
    %xlim(Sch_v_P,[35 200]);
    grid(Sch_v_P,'on');
    hold(Sch_v_P, 'on');
    legends{end+1} = rundir;
  end
end
if bitand(verbosity,8)
  hold(Sch_v_P,'off');
  legend(legends{:});
end

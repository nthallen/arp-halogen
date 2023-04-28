function correct_z(pattern, verbosity, fits)
% Verbosity 1 Plot cool and uncool regions
% Verbosity 2 Per segment data
% Verbosity 4 Per flight 3-panel plot
% Verbosity 8 Per flight 3-panel plot
% Verbosity 16 Sch vs P or P/T for all flights
% Verbosity 32 Don't do Twarmup correction
% Verbosity 64 Useful to suppress everything else
if nargin < 1; pattern = '*F'; end
if nargin < 2; verbosity = 0; end
if nargin < 3; fits = []; end
%%
cd C:\Data\Halogens\Analysis
Eliminate = [];
%-----Chamber scatter DW based on scaling relative to 520
Chamber.F210609_2F = 589; ZeroT.F210609_2F = 0;
Chamber.F210614_3F = 582; ZeroT.F210614_3F = 0;
Chamber.F210617_2F = 577; ZeroT.F210617_2F = 0;
% Chamber.F210713_1F = 710; ZeroT.F210713_1F = 0;
Chamber.F210717_1F = 452; ZeroT.F210717_1F = 0;
Chamber.F210721_1F = 471; ZeroT.F210721_1F = 0;
Chamber.F210723_2F = 490; ZeroT.F210723_2F = 0;
Chamber.F210726_2F = 541; ZeroT.F210726_2F = 0;
Chamber.F210729_2F = 552; ZeroT.F210729_2F = 0;
Chamber.F210802_3F = 490; ZeroT.F210802_3F = 25;
% Chamber.F210807_1F = 710; ZeroT.F210807_1F = 25;
Chamber.F210810_2F = 546; ZeroT.F210810_2F = 25;
Chamber.F210814_2F = 502; ZeroT.F210814_2F = 25;
Chamber.F210817_2F = 532; ZeroT.F210817_2F = 25;
% Chamber.F210820_1F = 710; ZeroT.F210820_1F = 25;
Chamber.F210913_1F = 434; ZeroT.F210913_1F = 25;
%----------Changes based on chamber_est2--------
Chamber.F210609_2F = 602; ZeroT.F210609_2F = 0;
Chamber.F210614_3F = 588; ZeroT.F210614_3F = 0;
Chamber.F210617_2F = 563; ZeroT.F210617_2F = 0;
% Chamber.F210713_1F = 710; ZeroT.F210713_1F = 0;
Chamber.F210717_1F = 462; ZeroT.F210717_1F = 0;
Chamber.F210721_1F = 497; ZeroT.F210721_1F = 0;
Chamber.F210723_2F = 517; ZeroT.F210723_2F = 0;
Chamber.F210726_2F = 550; ZeroT.F210726_2F = 0;
Chamber.F210729_2F = 500; ZeroT.F210729_2F = 0;
Chamber.F210802_3F = 505; ZeroT.F210802_3F = 25;
% Chamber.F210807_1F = 710; ZeroT.F210807_1F = 25;
Chamber.F210810_2F = 506; ZeroT.F210810_2F = 25;
Chamber.F210814_2F = 471; ZeroT.F210814_2F = 25;
Chamber.F210817_2F = 570; ZeroT.F210817_2F = 25;
% Chamber.F210820_1F = 710; ZeroT.F210820_1F = 25;
Chamber.F210913_1F = 435; ZeroT.F210913_1F = 25;

Navg = 60; % 16 points, 4 seconds

%%
flights = dir(pattern);
for fi = 1:length(flights)
  cd C:\Data\Halogens\Analysis
  rundir = flights(fi).name;
  run = [ 'F' strrep(rundir,'.','_')];
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
  if isfield(fits,run)
    Sfit = fits.(run);
  else
    fprintf(1,'%s: No fit data, skipping\n', run);
    continue;
  end
  Sch = Sfit.Sch;
  if isfield(Chamber, run)
    fprintf(1,'%s: Overriding Sfit.Sch(%.0f) with Chamber(%.0f)\n', ...
      Sfit.Sch, Chamber.(run));
    Sch = Chamber.(run);
  end

  %%
  T1 = time2d(H1.Thaleng_1);
  SF1BT_1 = H1.SF1BTemp;
  T4 = time2d(H4.Thaleng_4);
  X4 = 1:length(T4);
  SF1BT_4 = interp1(T1,SF1BT_1,T4,'linear','extrap');
  hot = SF1BT_4 > 150;
  cool = SF1BT_4 < ZeroTemp+15; % & SF1BT_4 > -20;
  cold = SF1BT_4 < ZeroTemp-15;

  % cool12 is on the S11/S12 time base and matches the conditions used in
  % chamber_est2.
  cool12 = S12.SF1BTemp_Z >= ZeroTemp-15 & S12.SF1BTemp_Z <= ZeroTemp+15;
  cool12WU = cool12 & T11 < Sfit.Twarmup;
  Tcool12 = T11(cool12);
  SchWU = Sch*ones(size(Tcool12));
  SchWU(Tcool12 < Sfit.Twarmup) = Sch * ...
    S11.DetB_Z(cool12WU)./polyval([Sfit.dSdP Sfit.Sch],S11.SD1_P_Z(cool12WU));
%   figure;
%   plot(Tcool12,SchWU,'.','MarkerSize',15);
%   title(getrun);
%   ylabel('S_{ch}');
%   xlabel('Time');
%   grid on;
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
  RegTs = zeros(Nregions,2);
  RegDs = zeros(Nregions,2);
  RegP = zeros(Nregions,2);
  RegTemp = zeros(Nregions,2);
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
      % Plot Signal vs Sch vfor both fits and all regions
      MM = [min(M);max(M)];
      SM = MM*(RegSchFit(i,:)');
      MMZ = [min(MZ);max(MZ)];
      SMZ = MMZ*(RegSchZFit(i,:)');
      plot(M(:,1),S,'.g',MM(:,1),SM,'b',MZ(:,1),SZ,'*k', ...
        MMZ(:,1),SMZ,'r');
%       hold on;
%       plot(MM(:,1),SM,'r');
%       hold off;
      pause;
    end
  end
  if bitand(verbosity,4)
    f = figure;
    ax = [nsubplot(3,1,1) nsubplot(3,1,2) nsubplot(3,1,3)];
    h = plot(ax(1), RegTime', (RegSchFit(:,1)*[1 1])','b-', ...
       RegTime', (RegSchFit(:,2)*[1 1])','r-');
    set(h,'LineWidth', 3);
    % Playing games here to get the legend to match up with all these
    % segments:
    RT = [ RegTime NaN*ones(size(RegTime,1),1) ]';
    RSF = (RegSchFit(:,2)*[1 1 1])';
    RSZF = (RegSchZFit(:,2)*[1 1 1])';
    h = plot(ax(2),T4, H4.DetB, '.g', RT(:),RSF(:), 'b-', ...
      RT(:), RSZF(:),'r-', T4([1 end]), Sch * [1 1],'k');
    % This is how it was done before:
    % h = plot(ax(2),T4, H4.DetB, '.g', RegTime', (RegSchFit(:,2)*[1 1])','b-', ...
    %   RegTime', (RegSchZFit(:,2)*[1 1])','r-', ...
    %   T4([1 end]), Sch * [1 1],'k');
    set(h(1:end-1),'LineWidth', 3);
    title(ax(1),getrun);
    grid(ax(1),'on');
    grid(ax(2),'on');
    ax(2).YAxisLocation = 'right';
    ax(1).XTickLabel = [];
    ax(2).XTickLabel = [];
    ylabel(ax(1), 'dS/dM');
    ylabel(ax(2), 'S_{ch}');
    M = H4.SD1_P./(SF1BT_4+273.15);
    plot(ax(3),T4,M,'.');
    ylabel(ax(3),'[M] sort of');
    linkaxes(ax,'x');
    legend(ax(2),'raw','S_{ch,all}','S_{ch,Z}','S_{ch}')
    f.WindowState = 'maximized';
    % return;
  end
  for i=1:Nregions
    % Looking between cool region i and cool region i+1
    % We are only interested where the gap between cool regions includes
    % hot data.
    hoti = ends(i)+1:starts(i+1)-1;
    if ~any(hot(hoti))
      fprintf(1,'%s: Skipping region %d: no hot data\n', rundir, i);
      continue;
    end
    if dur(i) < Navg
      warning('%s: Cool region preceeding cycle %d (%d-%d) has only %d samples', ...
        rundir, i, starts(i+1), ends(i+1), dur(i));
    end
    if dur(i+1) < Navg
      warning('%s: Cool region following cycle %d (%d-%d) has only %d samples', ...
        rundir, i, starts(i+1), ends(i+1), dur(i+1));
    end
    Rpre = ends(i)-Navg+1:ends(i);
    if any(cold(Rpre))
      warning('%s: Cool region preceeding cycle %d (%d-%d) has cold samples', ...
        rundir, i, starts(i), ends(i));
    end
    Rpost = starts(i+1):starts(i+1)+Navg-1;
    if any(cold(Rpost))
      warning('%s: Cool region following cycle %d (%d-%d) has cold samples', ...
        rundir, i, starts(i+1), ends(i+1));
    end

    % We want to take the last N points in region i and the first N points
    % in region i+1, average them and their times, then interpolate.
    RegTs(i,:) = [ mean(T4(Rpre)) mean(T4(Rpost))];
    RegTemp(i,:) = [ mean(SF1BT_4(Rpre)) mean(SF1BT_4(Rpost))]+273.15;
    RegP(i,:) = [ mean(H4.SD1_P(Rpre)) mean(H4.SD1_P(Rpost))];
    RegDs(i,:) = [ mean(H4.DetB(Rpre)) mean(H4.DetB(Rpost)) ];
    Rint = ends(i)+1:starts(i+1)-1;
    DetBZ(Rint) = interp1(RegTs(i,:),RegDs(i,:),T4(Rint));
    TimeR = T4(Rint);
    SchR = Sch*ones(size(TimeR));
    if ~bitand(verbosity,32)
      SchR(TimeR<Sfit.Twarmup) = ...
        interp1(Tcool12,SchWU,TimeR(TimeR<Sfit.Twarmup));
    end
    Temp1 = interp1(RegTs(i,:),RegTemp(i,:),T4(Rint));
    Pres1 = interp1(RegTs(i,:),RegP(i,:),T4(Rint));
    CorrDB2(Rint) = ((DetBZ(Rint)-SchR) .* ...
      (Temp1./Pres1) .* ...
      (H4.SD1_P(Rint)./(SF1BT_4(Rint)+273.15))) + SchR;
  end
  %%
  if verbosity == 0 || bitand(verbosity,8)
    figure;
    ax = [nsubplot(3,1,1) nsubplot(3,1,2) nsubplot(3,1,3)];
    h = plot(ax(1),movmean(T4,4),movmean(H4.DetB,4),'.',T4,DetBZ,RegTs(:),RegDs(:),'*', ...
      T4,CorrDB2,'r',T11,S11.DetB_Z,'.k');
    title(ax(1),getrun);
    plot(ax(2),T4,H4.SD1_P);
    ylabel(ax(2),'P');
    linkaxes(ax,'x');
    h(2).LineWidth = 3;
    h(4).LineWidth = 3;
    h(5).MarkerSize = 15;
    plot(ax(3),T4,SF1BT_4);
    ylabel(ax(3),'SF1BT');
    set(ax(1),'XTickLabel',[]);
    set(ax(2),'YAxisLocation','Right','XTickLabel',[]);
  end
  %%
  Corr.T11 = T11;
  Corr.DetB_Z_C = S11.DetB_Z;
  BZ_C = interp1(T4,CorrDB2,T11);
  V = ~isnan(BZ_C);
  Corr.DetB_Z_C(V) = BZ_C(V);
  Corr.T4 = T4;
  Corr.CorrDetB = CorrDB2;
  fname = ['Corr_' rundir '.mat'];
  cd C:\Data\Halogens\Analysis
  save(fname, '-struct', 'Corr');
  %%
  if verbosity == 0 || bitand(verbosity,16)
    figure;
    % movmean(T4,4),movmean(H4.DetB,4),'.',
    h = plot(T11,S11.DetB_Z,'-o', ...
      T11,Corr.DetB_Z_C,'-*');
    legend('uncorrected','corrected');
    title(rundir);
  end
  %%
end

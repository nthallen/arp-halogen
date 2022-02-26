function correct_z(pattern, verbosity)
if nargin < 1; pattern = '*F'; end
if nargin < 2; verbosity = 0; end
%%
cd C:\Data\Halogens\Analysis
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
  S12 = ne_load('SolAd12','Hal_Data_Dir');

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
  if verbosity > 0
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
      if verbosity > 1
        hold(Vax,'on');
        x = [starts(i) ends(i)];
        plot(Vax,X4(x),SF1BT_4(x),'xk');
        hold(Vax,'off');
      end
    end
    if dur(i+1) < Navg
      warning('%s: Cool region following cycle %d (%d-%d) has only %d samples', ...
        rundir, i, starts(i+1), ends(i+1), dur(i+1));
      if verbosity > 1
        hold(Vax,'on');
        x = [starts(i+1) ends(i+1)];
        plot(Vax,X4(x),SF1BT_4(x),'xg');
        hold(Vax,'off');
      end
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
    %CorrDB(Rint) = ((DetBZ(Rint)-Sch) * ...
    %  (mean(RegTemp(i,:))/mean(RegP(i,:))) .* ...
    %  (H4.SD1_P(Rint)./(SF1BT_4(Rint)+273.15))) + Sch;
    %Rayint = interp1(RegTs(i,:),Ray,T4(Rint));
    %DetBZ(Rint) = Rayint .* H4.SD2_P(Rint) ./ (SF1BT_4(Rint)+273.15) + Sch;
    Temp1 = interp1(RegTs(i,:),RegTemp(i,:),T4(Rint));
    Pres1 = interp1(RegTs(i,:),RegP(i,:),T4(Rint));
    CorrDB2(Rint) = ((DetBZ(Rint)-Sch) .* ...
      (Temp1./Pres1) .* ...
      (H4.SD1_P(Rint)./(SF1BT_4(Rint)+273.15))) + Sch;
  end
  T11 = time2d(S11.TSolAd11);
  %%
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
  figure;
  % movmean(T4,4),movmean(H4.DetB,4),'.',
  h = plot(T11,S11.DetB_Z,'-o', ...
    T11,Corr.DetB_Z_C,'-*');
  legend('uncorrected','corrected');
  title(rundir);
  %%
end

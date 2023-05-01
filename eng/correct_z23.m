function correct_z23(pattern, verbosity)
% pattern is currently based on directories in \Data\Halogens\Analysis.
% That should change to Hal_Data_Dir using ne_load_runsdir
% Verbosity 1 Plot cool and uncool regions
% Verbosity 2 Plot DetB_Z and DetB_Z_C
% Verbosity 4 Safe figures
if nargin < 1; pattern = '*F'; end
if nargin < 2; verbosity = 0; end
%%
% cd C:\Data\Halogens\Analysis
ZeroT.F210609_2F = 0; Q_P.F210609_2F = 0.0126;
ZeroT.F210614_3F = 0; Q_P.F210614_3F = 0.0126;
ZeroT.F210617_2F = 0; Q_P.F210617_2F = 0.0126;
% ZeroT.F210713_1F = 0; Q_P.F210713_1F = 0.0126;
ZeroT.F210717_1F = 0; Q_P.F210717_1F = 0.0102;
ZeroT.F210721_1F = 0; Q_P.F210721_1F = 0.0102;
ZeroT.F210723_2F = 0; Q_P.F210723_2F = 0.0102;
ZeroT.F210726_2F = 0; Q_P.F210726_2F = 0.0102;
ZeroT.F210729_2F = 0; Q_P.F210729_2F = 0.0102;
ZeroT.F210802_3F = 25; Q_P.F210802_3F = 0.0102;
% ZeroT.F210807_1F = 25; Q_P.F210807_1F = 0.0102;
ZeroT.F210810_2F = 25; Q_P.F210810_2F = 0.0110;
ZeroT.F210814_2F = 25; Q_P.F210814_2F = 0.0110;
ZeroT.F210817_2F = 25; Q_P.F210817_2F = 0.0110;
% ZeroT.F210820_1F = 25; Q_P.F210820_1F = 0.0112;
ZeroT.F210913_1F = 25; Q_P.F210913_1F = 0.0112;
%%
sigma_1189_O2 = 2e-20;
l_ray = 7.5; %cm
R_Torr_K_molecules_cm3 = 9.6563E18;
T_lab = 295; % K
%%
runsdir = ne_load_runsdir('Hal_Data_Dir');
flights = dir([runsdir filesep pattern]);
for fi = 1:length(flights)
  rundir = flights(fi).name;
  run = [ 'F' strrep(rundir,'.','_')];
  if ~isfield(Q_P,run) || Q_P.(run) == 0
    fprintf(1,'Missing Q_P for run %s: skipping\n', run);
    continue;
  end
  Q_M = Q_P.(run) * T_lab / R_Torr_K_molecules_cm3;
  ZeroTemp = 25;
  if isfield(ZeroT, run)
    ZeroTemp = ZeroT.(run);
  end
  fprintf(1,'Running flight %s\n', rundir);
  %%
  H1 = load([runsdir filesep rundir filesep 'haleng_1.mat']);
  H4 = load([runsdir filesep rundir filesep 'haleng_4.mat']);
  S11 = load([runsdir filesep rundir filesep 'SolAd11.mat']);
  S12 = load([runsdir filesep rundir filesep 'SolAd12.mat']);
  if isempty(H1) || isempty(H4) || isempty(S11)
    fprintf(1,'%s: missing some mat files: skipping\n', run);
    continue;
  end
  if ~isfield(S12,'SF1BTemp_Z')
    fprintf(1,'%s: S12 is missing SF12BTemp_Z, skipping\n', run);
    continue;
  end
  T11 = time2d(S11.TSolAd11);

  %%
  T1 = time2d(H1.Thaleng_1);
  T4 = time2d(H4.Thaleng_4);
  SF1BT_1 = H1.SF1BTemp;
  X4 = 1:length(T4);
  SD1P_4 = H4.SD1_P;
  SF1BT_4 = interp1(T1,SF1BT_1,T4,'linear','extrap');
  M4 = R_Torr_K_molecules_cm3 * SD1P_4 ./ SF1BT_4;
  hot4 = SF1BT_4 > 150;
  cool4 = SF1BT_4 < ZeroTemp+15;
  cold4 = SF1BT_4 < ZeroTemp-15;
  SF1BT_Z = S12.SF1BTemp_Z;
  SD1_P_Z = S11.SD1_P_Z;
  DetB_Z = S11.DetB_Z;
  hot = SF1BT_Z > 150;
  cool = SF1BT_Z < ZeroTemp+15;
  cold = SF1BT_Z < ZeroTemp-15;
  M_Z = R_Torr_K_molecules_cm3 * SD1_P_Z ./ (SF1BT_Z + 273.15);
  O2abs_Z = exp(-0.21*sigma_1189_O2*l_ray*M_Z);
  F_Z = (DetB_Z ./ O2abs_Z) ./ (1 + 0.84*Q_M*M_Z);
  Corr.T11 = T11;
  Corr.DetB_Z = DetB_Z;
  Corr.DetB_Z_C = DetB_Z;
  %%
  if bitand(verbosity,1)
    ax = [nsubplot(2,1,1) nsubplot(2,1,2)];
    % plot(ax(1),T11,1+0.84*Q_M*M_Z,'.');
    plot(ax(1),T11(cool),F_Z(cool),'.',T11(~cool),F_Z(~cool),'.');
    grid(ax(1),'on');
    % plot(ax(2),T4,H4.DetB,'.');
    plot(ax(2),T1,SF1BT_1);
    set(ax(2:2:end),'YAxisLocation','Right');
    set(ax(1:end-1),'XTickLabel',[]);
    linkaxes(ax,'x');
  end
  %%
  if bitand(verbosity,1)
    figure;
    ax = [ nsubplot(2,1,1) nsubplot(2,1,2) ];
    plot(ax(1),T11(cool),SF1BT_Z(cool),'.',T11(~cool),SF1BT_Z(~cool),'.');
    plot(ax(2),T4,H4.DetB,'.',T11(cool),DetB_Z(cool),'.',T11(~cool),DetB_Z(~cool),'.');
    set(ax(2:2:end),'YAxisLocation','Right');
    set(ax(1:end-1),'XTickLabel',[]);
    linkaxes(ax,'x');
  end
  %%
  % regions are not cool (but not necessarily hot)
  starts = find(diff([0;~cool])>0);
  ends = find(diff([~cool;0])<0);
  dur = ends-starts;
  if any(dur < 0)
    warning('%s: Take a look at durations', rundir);
  end
  %%
  Nregions = length(starts);
  for i=1:Nregions
    Ifit = [starts(i)-1,ends(i)+1];
    Rfit = starts(i):ends(i);
    if ~any(hot(Rfit))
      fprintf(1,'%s: Skipping region %d: no hot data\n', rundir, i);
      continue;
    end
    % We have defined the regions. Now we would like to go through each
    % region and estimate Sch chamber scatter and dSdM such that signal
    % S = dSdM * P/T + Sch. For the first pass, I will use all the data
    % from Rpre through Rpost.
    Ffit = interp1(T11(Ifit),F_Z(Ifit),T11(Rfit));
    Corr.DetB_Z_C(Rfit) = Ffit .* O2abs_Z(Rfit).*(1+0.84*Q_M*M_Z(Rfit));
  end
  %%
  fname = ['Corr_' rundir '.mat'];
  cd C:\Data\Halogens\Analysis
  save(fname, '-struct', 'Corr');
  %%
  if bitand(verbosity,2)
    f = figure;
    ax = [nsubplot(2,1,1) nsubplot(2,1,2)];
    plot(ax(1),Corr.T11,Corr.DetB_Z,'-o', ...
      Corr.T11,Corr.DetB_Z_C,'-*');
    grid(ax(1),'on');
    legend(ax(1),'uncorrected','corrected');
    plot(ax(2),T1,SF1BT_1);
    set(ax(2:2:end),'YAxisLocation','Right');
    set(ax(1:end-1),'XTickLabel',[]);
    linkaxes(ax,'x');
    title(ax(1),rundir);
    if bitand(verbosity,4)
      savefig(f,['DetB_Z_z23_' run '.fig']);
    end
  end
  %%
end

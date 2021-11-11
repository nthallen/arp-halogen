function createHALict(flightdate, revision, revdate)
D = load([flightdate '.mat']);
YYYY = flightdate(1:4);
MM = flightdate(5:6);
DD = flightdate(7:8);
if nargin < 3; revdate = flightdate; end
revYYYY = revdate(1:4);
revMM = revdate(5:6);
revDD = revdate(7:8);

normal_comments = importdata('normal_comments.txt','\n');
special_comments = importdata('special_comments.txt','\n');

hdr1 = {
  'Wilmouth, David M.'
  'Harvard University'
  'Harvard Halogens Instrument'
  'DCOTSS'
  '1,1'
};

hdr2 = {
  '0'
  'Time_Start, seconds, number_of_seconds_from_0000_UTC'
  '4'
  '1.0,1.0,1.0,1.0'
  '-999999.9,-999999.9,-999999.9,-999999.9'
  'Time_Stop, seconds, Time_Stop'
  'Time_Mid, seconds, Time_Mid'
  'ClO_HAL, pptv, Gas_ClO_InSitu_S_AVMR, ClO Volume Mixing Ratio pptv'
  'ClONO2_HAL, pptv, Gas_ClONO2_InSitu_S_AVMR, ClONO2 Volume Mixing Ratio pptv'
};

total_header_rows = 1 + length(hdr1) + 1 + length(hdr2) + ...
  1 + length(special_comments) + 1 + length(normal_comments);

filename = ['DCOTSS-HAL_ER2_' flightdate '_' revision '.ict'];
fp = fopen(filename,'w');
if fp == -1; error('Cannot write to file %s', filename); end
fprintf(fp,'%d,1001\n',total_header_rows);
fprintf(fp,'%s\n',hdr1{:});
fprintf(fp,'%s,%s,%s,%s,%s,%s\n',YYYY,MM,DD,revYYYY,revMM,revDD);
fprintf(fp,'%s\n',hdr2{:});

fprintf(fp,'%d\n',length(special_comments));
if ~isempty(special_comments)
  fprintf(fp,'%s\n',special_comments{:});
end

% Interpolate revision into normal comments:
fprintf(fp,'%d\n',length(normal_comments));
for i=1:length(normal_comments)
  if startsWith(normal_comments{i},'REVISION:')
    fprintf(fp,'REVISION: %s\n', revision);
  else
    fprintf(fp, '%s\n', normal_comments{i});
  end
end

time_start = D.time - 35;
time_stop = D.time;
time_mid = time_start + 18;
D.clo(isnan(D.clo)) = -999999.9;
D.clono2(isnan(D.clono2)) = -999999.9;
for i=1:length(time_start)
  fprintf(fp,'%9.2f,%9.2f,%9.2f,%9.1f,%9.1f\n', ...
    time_start(i), time_stop(i), time_mid(i), ...
    D.clo(i), D.clono2(i));
end
fclose(fp);

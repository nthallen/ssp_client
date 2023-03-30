function Dout = load_ssp( cpci )
% Dout = load_ssp(cpci);
if nargin < 1 || isempty(cpci)
  cpci = cpci_list('LOG');
end
if size(cpci,1) > 1
  cpci = cpci';
end
Dout =  struct( 'N', 0, 'NWordsHdr', 0, ...
      'FormatVersion', 0, ...
      'NChannels', 0, ...
      'NSamples', 0, ...
      'NCoadd', 0, ...
      'NAvg', 0, ...
      'NSkL', 0, ...
      'NSkP', 0, ...
      'ScanNum', 0, ...
      'Spare', 0, ...
      'OVF', 0, ...
      'Data', [] );
Dout(length(cpci)) = Dout(1);
for i = 1:length(cpci)
  path = mlf_path( 'LOG', cpci(i) );
  if exist(path,'file')
    S = load(path);
    if length(S) > 12
      D = S(12:end);
      NCh = S(3);
      NS = S(4);
      if length(D) ~= NCh*NS
        error('Incorrect length of scan: cpci: %d NS:%d NCh:%d len:%d', ...
          i, NS, NCh, length(D));
      end
      D = reshape(D,NCh,NS)';
      Dout(i) = struct( 'N', cpci(i), 'NWordsHdr', S(1), ...
        'FormatVersion', S(2), ...
        'NChannels', NCh, ...
        'NSamples', NS, ...
        'NCoadd', S(5), ...
        'NAvg', S(6)+1, ...
        'NSkL', S(7), ...
        'NSkP', S(8), ...
        'ScanNum', S(9), ...
        'Spare', S(10), ...
        'OVF', S(11), ...
        'Data', D );
    else
      fprintf(1,'Scan %d (cpci %d) is short\n', i, cpci(i));
      Dout = Dout(1:i-1);
      if i < length(cpci)
        fprintf(1,'Ending before last scan: %d of %d\n',i,length(cpci));
      end
      return;
    end
  end
end

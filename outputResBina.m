function outputResBina(u,sumNode,sumElem,node,elem,mnode,ndim)
% 二进制格式输出结果

data = [node,u'];
ZoneType = 5; %'FEBRICK';
file.varName = {'x','y','z','ux','uy','uz'};

% 输出云图至指定文件
file.name = 'solution.plt';
file.title = 'solution';
file.zoneName = 'Step 1 Incr 1';
tecplotBinary(file,data,ZoneType,ndim,mnode,sumNode,sumElem,elem);


function tecplotBinary(file,data,ZoneType,ndim,mnode,sumNode,sumElem,elem)
% 输出二进制结果至 file
fid = fopen(file.name,'w');
% i. Magic number, Version number
fwrite(fid,'#!TDV112');
% ii. Integer value of 1.
fwrite(fid,1,'int32');
% iii. Title and variable names.
fwrite(fid,0,'int32'); % FileType
fwrite(fid,[abs(file.title),0],'int32'); % The TITLE
NumVar = size(data,2);
if NumVar~= size(file.varName,2)
    error('var name is not equal to the data');
end
fwrite(fid,NumVar,'int32'); % Number of variables (NumVar) in the datafile.
for n = 1:NumVar
    fwrite(fid,[abs(file.varName{n}),0],'int32');% Variable names.
end
fwrite(fid,299.0,'float32'); % Zone marker. Value = 299.0
fwrite(fid,[abs(file.zoneName),0],'int32'); % Zone name.
fwrite(fid,-1,'int32'); % ParentZone
fwrite(fid,0,'int32'); % StrandID
fwrite(fid,1.0,'float64'); % Solution time
fwrite(fid,-1,'int32'); % Not used. Set to -1.
fwrite(fid,ZoneType,'int32'); % ZoneType
fwrite(fid,0,'int32'); % Specify Var Location.0 = Don’t specify, all data is located at the nodes.
fwrite(fid,0,'int32'); % Are raw local 1-to-1 face neighbors supplied
fwrite(fid,0,'int32'); % Number of miscellaneous user-defined face neighbor connections
fwrite(fid,sumNode,'int32'); % NumPts
fwrite(fid,sumElem,'int32'); % NumElements
fwrite(fid,[0,0,0],'int32'); % ICellDim,JCellDim, KCellDim (for future use; set to zero)
fwrite(fid,0,'int32'); % No more Auxiliary name/value pairs.
% DATA SECTION
fwrite(fid,357.0,'float32');% EOHMARKER, eparate the header from the data
fwrite(fid,299.0,'float32'); % Zone marker. Value = 299.0
fwrite(fid,2*ones(1,NumVar),'int32'); % Variable data format, N=Total number of vars. All are Double.
fwrite(fid,0,'int32'); % Has passive variables: 0 = no, 1 = yes.
fwrite(fid,0,'int32'); % Has variable sharing 0 = no, 1 = yes
fwrite(fid,-1,'int32'); % Zero based zone number to share connectivity list with (-1 = no sharing).
for n = 1:NumVar % Compressed list of min/max pairs for each non-shared and non-passive variable.
    fwrite(fid,min(data(:,n)),'float64'); % Min value
    fwrite(fid,max(data(:,n)),'float64'); % Max value
end
fwrite(fid,data,'float64'); % Zone Data. Each variable is in data format as specified above.
if ndim == 2
    if mnode == 8
        elem(:,5:end) = [];
    end
else
    if mnode == 20
        elem(:,9:end) = [];
    end
end
fwrite(fid,elem'-1,'int32');




fclose(fid);



function [EUR,BHP] = forward_EUR_grad(counter_var,damp)
%  Input BHP as a row vector and get cumulative oil production at last t

% Clear everything and specify CMG pathes
%gem_path1 = '"/project/jafarpou_227/CMG/2022/2022.101.GU/imex/2022.10/linux_x64/exe/mx202210.exe"';
%gem_path2 = '"/project/jafarpou_227/CMG/2022/2022.101.GU/br/2022.10/linux_x64/exe/report.exe"';
aa=randi(999999999);
rng(aa);
gem_path1 = '"C:\Program Files\CMG\IMEX\2022.10\Win_x64\EXE\mx202210.exe"';
gem_path2 = '"C:\Program Files\CMG\RESULTS\2022.10\Win_x64\EXE\Report.exe"';


% Initialize variables
n_var=19;
ir=1:n_var;

% Create a new dat file
file_orig = 'hard_hard_hard_long.dat';
a=counter_var;
copied=[num2str(a),'.dat'];
oldpath=cd;
source = fullfile(oldpath,file_orig);

%create a folder and copy dat file to there
name=[num2str(a)];
mkdir(name);
cd(name);
newpath=cd;
destination = fullfile(newpath,copied);
copyfile(source,destination)
filename1=[' -f ',copied];


% Generate and write BHP input files
bhp_realiz_j=[];
for i=1:length(ir)
    if (i==1)
        bhp_time_i=5000;
    else
        bhp_time_i=(damp)*bhp_realiz_j(i-1)+ randn(1)*300;
    end
    bhp_time_i(bhp_time_i>5000)=5000;
    bhp_time_i(bhp_time_i<500)=500;
    FIDPERM = fopen(['well_bhp',num2str(a),num2str(ir(i)),'a.IN'],'w'); % write new BHP file
    fprintf(FIDPERM,'OPERATE *MIN *BHP %.4f CONT\n',bhp_time_i);  % OPERATE *MAX *BHP 7636.0000 CONT
    fclose(FIDPERM);
    bhp_realiz_j=[bhp_realiz_j bhp_time_i];
end


% replace bhp names with bhp_forward
fid  = fopen(copied,'r');
f=fread(fid,'*char')';
fclose(fid); 
for i=1:length(ir)
    f = strrep(f,['well_bhp',num2str(ir(i)),'.IN'],['well_bhp',num2str(a),num2str(ir(i)),'a.IN']);
end

fid  = fopen(copied,'w');
fprintf(fid,'%s',f);
fclose(fid);
%disp('scooby')
% run
[status, m]=system([gem_path1, filename1]);
if status~=0
    pause(10)
    disp(m);
    [status, m]=system([gem_path1, filename1]);
end

% specify timesteps
time1=15:15:30;
time2=30:30:90;
time3=90:60:210;
time4=210:90:390;
time5=390:120:630;
time6=630:180:990;
time7=990:365:3545;
timet=[time1 time2 time3 time4 time5 time6 time7];
%timet=3:1:5;
% 
% Create rwd file to extract needed data from results
FIDPERM = fopen(['Fluidrates',num2str(a),'.rwd'],'w');
copied2=[num2str(a) '.sr3'];
copied2=['''',copied2,'''' ];
filename2=['FILE ',copied2,' \n'];

fprintf(FIDPERM,filename2);
%fprintf(FIDPERM,'FILE ''1.sr3'' \n'); 
fprintf(FIDPERM,'*TIMES-FOR \n');  
fprintf(FIDPERM,'%d ',timet);
fprintf(FIDPERM,'\n');
fprintf(FIDPERM,'*TABLE-FOR   *WELLS  *ALL\n');   
fprintf(FIDPERM,'*COLUMN-FOR  *PARAMETERS ''Cumulative Oil SC'' *PRECISION 8 *WIDTH 16\n');  
fprintf(FIDPERM,'*TABLE-END\n');  
fclose(FIDPERM); 

% Run CMG to generate the data in needed format
STATUS=0;
[STATUS, ~]=system([gem_path2,[' -f Fluidrates',num2str(a),'.rwd -o Fluidrates',num2str(a),'.rwo']]);


while STATUS~=0
    pause(30)
    [STATUS, ~]=system([gem_path2,[' -f Fluidrates',num2str(a),'.rwd -o Fluidrates',num2str(a),'.rwo']]);
    disp(STATUS);
    disp('See rwd file')
end


% Open text file, write data into struct line by line 

fid = fopen(['Fluidrates',num2str(a),'.rwo'], 'r');
C = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
%
for iiii=8:length(C{1, 1})
    s{iiii-7,1} = C{1, 1}{iiii, 1};
end

% Extract rates
rates=[];
% length was 20 in for loop
for iii=2:20
    rates(iii,:) = str2double(split(s(iii,1))');
end

rates = rates(any(rates,2),:);
mm=transpose(rates);
mm=mm(:);

% Store inputs and output in matrices
EUR=mm';
BHP=bhp_realiz_j;
cd(oldpath);
fclose('all');
rmdir(num2str(a),'s');
end
function [skiplist]=Candy2MatCnn(folder,temlib)
% given the path in the folder sring
% given the output file name created in current folder (optional)
% this function look for all .tem files and try to convert
% all the templates into a templib.m file
% uncompatible .tem names will be listed as output

if nargin < 2
    temlib='templib'
end

cur_folder=pwd;
dirs=dir([folder '\*.tem']);  %get the list
temlibM=fopen([temlib '.m'],'w+'); %open a new file for the converted information
skiplist={};
skip=0;
continueM=0;
for i=1:size(dirs,1)    %for each file
    skip=0;
    currfile=fopen([ folder '\' dirs(i).name],'r');  %opef file for reading
    temname=dirs(i).name(1:end-4); % get the name of the template from the string of the file
    disp(['Converting' temname '.tem ...']);
    outTMP=['\n%%****************************** ', temname ,' *****************************']; %start new definition part for output to file
    while (continueM || ~feof(currfile)) %for each line in file
        if ~continueM; %if it continued from a block
            lineM = fgetl(currfile); %read a line
        else
            continueM=0; %else let it continue
        end

        if ~length(lineM) %if empty line skip
            continue;

        elseif  length(regexpi(lineM,'(\s*.*)', 'tokens', 'once')) %if end of file sign... skip line
            continue;

        elseif length(regexpi(lineM,'\s*%(.*)', 'tokens', 'once')) %if comment store it
            outTMP=[outTMP '\n%' lineM ];

        elseif length(regexpi(lineM,'\s*neighborhood(.*)', 'tokens', 'once')) %if found neighborhood def, store it as comment
            outTMP=[outTMP '\n%%' lineM ];

        elseif length(regexpi(lineM,'\s*nonlin_(.*)', 'tokens', 'once')) %if nonlin_ identifier found
            skiplist{end+1}=temname; %skip this is complicated
            skip=1;
            disp(['  skipped because NONLIN_ identifier found!']);
            break;

        elseif length(regexpi(lineM,'\s*feedback:(.*)', 'tokens', 'once')) %if feedback _A matrix found
            outTMP=[outTMP '\n' temname '_A = [']; %start define feedback  matrix
            outTMPtmp=[];  %collect comments
            while (~continueM && ~feof(currfile))%find the matrix rows or detect end os file
                lineM = fgetl(currfile); %get new line
                if ~length(lineM) %if empty line skip
                    continue;
                elseif  length(regexpi(lineM,'\s*%(.*)', 'tokens', 'once')) %if comment line write to temp
                    outTMPtmp=[outTMPtmp '\n%' lineM ];
                elseif  length(regexpi(lineM,'[ \t]*([a-z][a-z]*)', 'tokens', 'once')) %if new definition detected keep line and continue closing matrixdef
                    continueM=1;
                    break;
                elseif  length(regexpi(lineM,'\s*([-\d.][-\d. \t]*)', 'tokens', 'once')) %if numbers
                    outTMP=[outTMP '\n' lineM];
                else
                    outTMPtmp=[outTMPtmp '\n%%' lineM ]; %else collect to comments
                end
            end
            outTMP=[outTMP '];\n'];
            if length(outTMPtmp)
                outTMP=[outTMP '\n%' outTMPtmp];
            end

        elseif length(regexpi(lineM,'\s*control:(.*)', 'tokens', 'once')) %if control _B matrix found
            outTMP=[outTMP '\n' temname '_B = [']; %start define control matrix
            outTMPtmp=[];  %collect comments
            while (~continueM && ~feof(currfile)) %find the matrix rows or detect end of file
                lineM = fgetl(currfile); %get new line
                if ~length(lineM) %if empty line skip
                    continue;
                elseif  length(regexpi(lineM,'\s*%(.*)', 'tokens', 'once')) %if comment line write to temp
                    outTMPtmp=[outTMPtmp '\n%' lineM ];
                elseif  length(regexpi(lineM,'[ \t]*([a-z][a-z]*)', 'tokens', 'once')) %if new definition detected keep line and continue closing matrixdef
                    continueM=1; %set flag not to override actual line
                    break;
                elseif  length(regexpi(lineM,'\s*([-\d.][-\d. \t]*)', 'tokens', 'once')) %if numbers store them
                    outTMP=[outTMP '\n' lineM ];
                else
                    outTMPtmp=[outTMPtmp '\n%%' lineM ]; %else collect to comments
                end
            end
            outTMP=[outTMP '];\n'];
            if length(outTMPtmp)
                outTMP=[outTMP '\n%' outTMPtmp];
            end

        elseif  length(regexpi(lineM,'\s*(nrlayers)', 'tokens', 'once')) % if nlayers definition found
            numtempM=regexpi(lineM,'\s*nrlayers:?\s*(\d*)', 'tokens', 'once');
            if str2num(numtempM{1})>1
                skiplist{end+1}=temname; %number of layers > 1 yelds to skipping
                skip=1;
                disp(['  skipped because NRLAYERS > 1!']);
                break;
            else
                outTMP=[outTMP '\n%%' lineM ];
            end

        elseif  length(regexpi(lineM,'\s*(current)', 'tokens', 'once'))
            numtemp=regexpi(lineM,'\s*current:?\s*([-\d.]*)', 'tokens', 'once');
            outTMP=[outTMP '\n' temname '_I = ' numtemp{1} ';']; %start define current value

        else %not defined statement yelds to skipping
            skiplist{end+1}=temname; %not defined statement yelds to skipping
            skip=1;
            disp(['  skipped because UNRECOGNISED token was found!']);
            break;
        end  %search for definition for actual line
        
    end %end of file lines
    fclose(currfile); %close current file
    if ~skip
        fprintf(temlibM,outTMP);
        disp(['   DONE!']);
    end

end %end of foreach file
fclose(temlibM); %close output file
cd(cur_folder); %go back to the current folder

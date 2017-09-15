function NewsTitleSet=GetNewsTitle_HERALD(Name)
% clear all
% Name='Hillary+Clinton';
NewsTitleSet=0;
DelSTR={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u' ...
    'v','w','x','y','z','1','2','3','4','5','6','7','8','9','0', ...
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U',...
    'V','W','X','Y','Z','.',',',':',';','''','/','?','(',')'};

for Page=1:50
    WebSource=webread(sprintf('http://www.koreaherald.com/search/?q=%s&dt=2&nt=1&np=%d',Name,Page));
    WebSource_Start=strfind(WebSource,'"ntitle"');
    WebSource=WebSource(min(WebSource_Start):end);
    WebSource_Start=strfind(WebSource,'"ntitle"');
    for i=1:10
        PreFindWebSource=WebSource(WebSource_Start(i):WebSource_Start(i)+200);
        PreWebSource_End=strfind(PreFindWebSource,'</a></p>');
        WebSource_End(i)=min(PreWebSource_End);
        NewsTitle{i}=PreFindWebSource(74:WebSource_End(i)-1);
    end
    
    
    
    for i=1:length(NewsTitle)
        SplitedStr=strsplit(NewsTitle{i});
        
        for k=1:length(SplitedStr)
            j=1;StopCondition=0;
            if isempty(SplitedStr{k})==0
                while(1)
                    
                    %                     for j=1:length(DelSTR)
                    dummy=strfind(DelSTR,SplitedStr{k}(j));
                    dummy=cell2mat(dummy);
                    if isempty(dummy)
%                         fprintf('%s\n',SplitedStr{k});
                        SplitedStr{k}=[];
                        StopCondition=1;
                    end
                    
                    j=j+1;
                    if j>length(SplitedStr{k}) || StopCondition==1;break;end;
                    %
                    %                         break;
                    %                     end
                    %                     if StopCondition==1;break;end
                end
            end
        end
        SplitedStr=SplitedStr(~cellfun('isempty',SplitedStr));
        NewsTitle{i}=strjoin(SplitedStr);
        
    end
    NewsTitle=NewsTitle(~cellfun('isempty',NewsTitle));
    % for i=1:length(NewsTitle)
    %     DelNews=strfind(NewsTitle{i},'<');
    %     if isempty(DelNews)~=1
    %        NewsTitle{i}=[];
    %     end
    % end
    % NewsTitle=NewsTitle(~cellfun('isempty',NewsTitle));
    % for i=1:length(NewsTitle)
    %     DelNews=strfind(NewsTitle{i},'$');
    %     if isempty(DelNews)~=1
    %        NewsTitle{i}=[];
    %     end
    % end
    % NewsTitle=NewsTitle(~cellfun('isempty',NewsTitle));
    % for i=1:length(NewsTitle)
    %     DelNews=strfind(NewsTitle{i},'_');
    %     if isempty(DelNews)~=1
    %        NewsTitle{i}=[];
    %     end
    % end
    % NewsTitle=NewsTitle(~cellfun('isempty',NewsTitle));
    % for i=1:length(NewsTitle)
    %     DelNews=strfind(NewsTitle{i},'''');
    %     if isempty(DelNews)~=1
    %        NewsTitle{i}=[];
    %     end
    % end
    % NewsTitle=NewsTitle(~cellfun('isempty',NewsTitle));
    % for i=1:length(NewsTitle)
    %     DelNews=strfind(NewsTitle{i},'™s');
    %     if isempty(DelNews)~=1
    %        NewsTitle{i}=[];
    %     end
    % end
    % NewsTitle=NewsTitle(~cellfun('isempty',NewsTitle));
    % for i=1:length(NewsTitle)
    %     DelNews=strfind(NewsTitle{i},'?');
    %     if isempty(DelNews)~=1
    %        NewsTitle{i}=[];
    %     end
    % end
    % NewsTitle=NewsTitle(~cellfun('isempty',NewsTitle));
    NewsTitleSet=[NewsTitleSet;NewsTitle'];
end
NewsTitleSet(1)=[];
end
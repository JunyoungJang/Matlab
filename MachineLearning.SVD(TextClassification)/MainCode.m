clear all,clc,close all
LSA = LSA_Ftn();

NewsTitleSet=GetNewsTitle_HERALD('Clinton');
% NewsTitleSet_T=GetNewsTitle_HERALD('japan');
% NewsTitleSet_C=GetNewsTitle_HERALD('Korea');
% NewsTitleSet_T=GetNewsTitle_HERALD('Japan');
% NewsTitleSet=[NewsTitleSet_C;NewsTitleSet_T];

for i=1:length(NewsTitleSet)
    NewsTitleSet{i}=strtrim(NewsTitleSet{i});
    if isempty(str2num(cell2mat(NewsTitleSet(i))))~=1
        NewsTitleSet{i}=[];
    end
end
NewsTitleSet=NewsTitleSet(~cellfun('isempty',NewsTitleSet));
tokenized = LSA.tokenizer(NewsTitleSet);
% before=NewsTitleSet(1)
% after={strjoin(tokenized{1},' ')}
[word_lists,word_counts] = LSA.indexer(tokenized);
docterm = LSA.docterm(word_lists,word_counts,2);
tfidf = LSA.tfidf(docterm);A=tfidf';
[U,S,V] = svd(A);



explained = cumsum(S.^2/sum(S.^2));
[~,SelectRank]=min(abs(explained-0.70));
figure(1)
plot(1:size(S,1),explained);hold on;xlim([0 length(explained)]);ylim([0 explained(end)]);
Rank=SelectRank;
line([Rank Rank],[0 explained(Rank)],'Color','r')
line([0 Rank],[explained(Rank) explained(Rank)],'Color','r')
title('Cumulative sum of \sigma^2 divided by sum of \sigma^2')
xlabel('Rank')
ylabel('% variance explained')
figure(2)
title('Clinton and Trump')
xlabel('Dimension 1')
ylabel('Dimension 2')
DocVector=(S);
% scatter(DocVector(1:Rank,1)*10,V(1:Rank,2)*10);hold on

% xlim([min(DocVector(1:Rank,1)./sum(DocVector(1:Rank,1))) max(DocVector(1:Rank,1)./sum(DocVector(1:Rank,1)))]);ylim([min(V(1:Rank,2)./sum(V(1:Rank,2))) max(V(1:Rank,2)./sum(V(1:Rank,2)))]);
xlim([-0.025 0.005]);ylim([-0.02 0.05]);
hold on;
TermVector=(U);
for i=1:Rank
%     text(V(i,1)./sum(V(1:Rank,1)), V(i,2)./sum(V(1:Rank,2)), LSA.vocab(i))
%     text(U(i,1), U(i,2), LSA.vocab(i))
%     if abs(TermVector(i,1)./sum(TermVector(1:Rank,1)))<0.04 && abs(TermVector(i,2)./sum(TermVector(1:Rank,2)))<0.04
%     scatter((DocVector(i,1)./sum(DocVector(:,1))),(DocVector(i,2)./sum(DocVector(:,2))),'go');hold on
%     text((TermVector(i,1)./sum(TermVector(:,1))), (TermVector(i,2)./sum(TermVector(:,2))), LSA.vocab(i))
    if TermVector(i,1)> -0.025
%       scatter(DocVector(i,1),DocVector(i,2),'go');hold on
      text(TermVector(i,1), TermVector(i,2), LSA.vocab(i))
    end
%     end
end
% line([-0.01 -0.01],[-0.02 0.05],'Color','r')
hold off
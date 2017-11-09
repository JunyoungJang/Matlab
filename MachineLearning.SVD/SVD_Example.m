clear all;close all;
A = imread('ngc6543a.jpg'); 
A = double(A); 
A_Red=A(:,:,1);
A_Green=A(:,:,2);
A_Blue=A(:,:,3);
[U_Red,S_Red,V_Red] = svd(A_Red);
[U_Green,S_Green,V_Green] = svd(A_Green);
[U_Blue,S_Blue,V_Blue] = svd(A_Blue);
VarSigma=sum(sum(S_Red.^2))+sum(sum(S_Green.^2))+sum(sum(S_Blue.^2));
for Rank=1:size(A,1)
    Compressed_Image_Red = U_Red(:,1:Rank)*S_Red(1:Rank,1:Rank)*V_Red(:,1:Rank)';
    Compressed_Image_Green = U_Green(:,1:Rank)*S_Green(1:Rank,1:Rank)*V_Green(:,1:Rank)';
    Compressed_Image_Blue = U_Blue(:,1:Rank)*S_Blue(1:Rank,1:Rank)*V_Blue(:,1:Rank)';
    Compreesed_VarSigma=sum(sum(S_Red(1:Rank,1:Rank).^2))+sum(sum(S_Green(1:Rank,1:Rank).^2)) ...
                            +sum(sum(S_Blue(1:Rank,1:Rank).^2));
    Ratio(Rank)=Compreesed_VarSigma/VarSigma;
    Compressed_Image(:,:,1)=Compressed_Image_Red;
    Compressed_Image(:,:,2)=Compressed_Image_Green;
    Compressed_Image(:,:,3)=Compressed_Image_Blue;
    Fig1=figure(1);set(Fig1, 'Position', [0 50 0 0])
    imshow(uint8(Compressed_Image));pause(0.1);
    Fig2=figure(2);set(Fig2, 'Position', [850 50 400 400])
    if Rank==1
        figure(2);hold on;plot([0,Rank],[0,Ratio(Rank)],'r');pause(0.1);hold off;
    else
        figure(2);hold on;plot([Rank-1,Rank],[Ratio(Rank-1),Ratio(Rank)],'r');pause(0.1);hold off;
    end
end
% Numerical Experiment 4

% Reference:
%   Paper   = Fast random vector transform within Wiener filtering paradigm. (Submitted paper - 2023)
%   Authors = Soto-Quiros, Pablo and Torokhti, Anatoli


clc; clear; close all


%%%% Step 1: Load source and noisy image %%%%

m=1; %Choose between 1, 2 or 3

Xsource=imread(['sourceImageNo',num2str(m),'.png']);
Ynoisy=imread(['noisyImageNo',num2str(m),'.png']);

subplot(1,5,1)
imshow(Xsource)
title('Source Image')

subplot(1,5,2)
imshow(Ynoisy)
title('Noisy Image')

%%%% Step 2: Load training data %%%%

p=85; %number of persons (total = 200)
q=13; %number of faces per person (total = 13)

numRows=96; numColumns=128; %dimension of each image

X_total=zeros(numRows,numColumns,p,q); Y_total=zeros(numRows,numColumns,p,q);

X_IMP=[]; Y_IMP=[];

for j=1:p
    for k=1:q
        text1=['Source_Images/person_',num2str(j),'/P',num2str(j),'_F',num2str(k),'.jpg'];
        text2=['Noisy_Images/person_',num2str(j),'/P',num2str(j),'_F',num2str(k),'.jpg'];
        auxX=im2double(imread(text1));
        auxY=im2double(imread(text2));
        X_total(:,:,j,k)=auxX;
        Y_total(:,:,j,k)=auxY;
        X_IMP=[X_IMP auxX(:)];
        Y_IMP=[Y_IMP auxY(:)];
    end
end

%%%% Step 3: Filtering noisy image using the multi-filtering transform %%%%

sizeBlocks=32;
blockRow=numRows/sizeBlocks; blockColums=numColumns/sizeBlocks;

F=zeros(sizeBlocks^2,sizeBlocks^2,blockRow,blockColums);

t1=0;

for j=1:blockRow
    for k=1:blockColums
        Exy=zeros(sizeBlocks^2,sizeBlocks^2,p);
        Eyy=zeros(sizeBlocks^2,sizeBlocks^2,p);
        for r=1:p %Number of person
            X=[]; Y=[];
            for s=1:q %Number of image per person
                Xaux=X_total((j-1)*sizeBlocks+1:j*sizeBlocks,(k-1)*sizeBlocks+1:k*sizeBlocks,r,s);
                Yaux=Y_total((j-1)*sizeBlocks+1:j*sizeBlocks,(k-1)*sizeBlocks+1:k*sizeBlocks,r,s);
                X=[X Xaux(:)];
                Y=[Y Yaux(:)];
            end
            Exy(:,:,r)=(1/q)*(X*Y');
            Eyy(:,:,r)=(1/q)*(Y*Y');
        end
        tic; F(:,:,j,k)=mft(Exy,Eyy); taux=toc;
        t1=t1+taux;
    end
end



tic
Xcleaned=zeros(sizeBlocks,sizeBlocks,blockRow,blockColums);
Ximg=zeros(numRows,numColumns);
for j=1:blockRow
    for k=1:blockColums
        Yaux=im2double(Ynoisy((j-1)*sizeBlocks+1:j*sizeBlocks,(k-1)*sizeBlocks+1:k*sizeBlocks));
        Aux1=F(:,:,j,k)*Yaux(:);
        Xcleaned(:,:,j,k)=reshape(Aux1,sizeBlocks,sizeBlocks);
        Ximg((j-1)*sizeBlocks+1:j*sizeBlocks,(k-1)*sizeBlocks+1:k*sizeBlocks)=Xcleaned(:,:,j,k);
    end
end
taux0=toc;
t1=t1+taux0;

Ximg_rec_MultiFilter=im2uint8(Ximg);
subplot(1,5,3)
imshow(Ximg_rec_MultiFilter)
title('Reconstruction with multi-filtering transform')

error1MSE=(1/12288)*norm(im2double(Xsource)-im2double(Ximg_rec_MultiFilter),'fr');
error1SSIM=ssim(Xsource,Ximg_rec_MultiFilter);

disp(['Time to filter the noisy image using the multi-filtering transform = ',num2str(t1), ' seconds'])
disp(['Erro given by the MSE of the multi-filtering transform= ' num2str(error1MSE)])
disp(['Error given by the SSIM of the multi-filtering transform= ' num2str(error1SSIM)])
disp('.')

%%%% Step 4: Filtering noisy image using the IMP transform %%%%

tic;
s1=rank(Y_IMP);
[~,~,V]=svd(Y_IMP);
P=X_IMP*V(:,1:s1)*(V(:,1:s1))';
[U1,S1,V1]=svd(P);
r1=500;
Pr1=U1(:,1:r1)*S1(1:r1,1:r1)*(V1(:,1:r1))';
F=Pr1*pinv(Y_IMP);

t2=toc;
Yaux=im2double(Ynoisy(:));
Ximg_rec_LowRank=im2uint8(reshape(F*Yaux,[numRows,numColumns]));

subplot(1,5,4)
imshow(Ximg_rec_LowRank)
title('Reconstruction with IMP method')

error2MSE=norm(im2double(Xsource)-im2double(Ximg_rec_LowRank),'fr');
error2SSIM=ssim(Xsource,Ximg_rec_LowRank);

disp(['Time to filter the noisy image using the IMP method = ',num2str(t2), ' seconds'])
disp(['Error given by the MSE of the IMP method = ' num2str(error2MSE)])
disp(['Error given by the SSIM of the IMP method = ' num2str(error2SSIM)])
disp('.')

%%%% Step 5: Filtering noisy image using the DnCNN transform %%%%

tic; net = denoisingNetwork("dncnn"); Ximg_rec_DnCNN = im2uint8(denoiseImage(Ynoisy,net)); t3=toc;

subplot(1,5,5)
imshow(Ximg_rec_DnCNN)
title('Reconstruction with DnCNN method')

error3MSE=norm(im2double(Xsource)-im2double(Ximg_rec_DnCNN),'fr');
error3SSIM=ssim(Xsource,Ximg_rec_DnCNN);

disp(['Time to filter the noisy image using the DnCNN method = ',num2str(t3), ' seconds'])
disp(['Error given by the MSE of the DnCNN method = ' num2str(error3MSE)])
disp(['Error given by the SSIM of the DnCNN method = ' num2str(error3SSIM)])

% Numerical Experiment 2

% Reference:
%   Paper   = Fast random vector transform within Wiener filtering paradigm. (Submitted paper - 2023)
%   Authors = Soto-Quiros, Pablo and Torokhti, Anatoli

clc; clear; close all

%%%% Step 1: Specify dimensions %%%%

p=10; dim=500:500:2000;

timesM1=zeros(length(dim),1);
timesM2=zeros(length(dim),1);
speedup=zeros(length(dim),1);
percent_difference=zeros(length(dim),1);

k=0;

for m=dim
    k=k+1;

    %%%% Step 2: Compute the covariance matrices %%%%

    Exx=zeros(m,m,p);
    Exy=zeros(m,m,p);
    Eyy=zeros(m,m,p);
    for i=1:p
        rho=rand(1);
        Exixi=rho*ones(m,m)+diag(ones(m,1)-rho*ones(m,1));
        Exx(:,:,i)=Exixi;
        A=rand(m);
        Exy(:,:,i)=Exixi*A';
        sigma=10*rand(1);
        Enini=sigma^2*eye(m);
        Eyy(:,:,i)=A*Exixi*A'+Enini;
    end
    %%%% Step 3: Comuputing the multi-filtering transform using fast implementation and original formula %%%%

    tic; F1=mft(Exy,Eyy); timesM1(k)=toc;
    tic; F=mftNaive(Exy,Eyy); timesM2(k)=toc;
    speedup(k)=timesM2(k)/timesM1(k);
    percent_difference(k)=100*(timesM2(k)-timesM1(k))/timesM2(k);
end

%%%% Step 4: Display the results obtained  %%%%

hold on
plot(dim,timesM1,"b")
plot(dim,timesM2,"r")
set(gca,'FontSize',14)
xlabel('Dimension (m)','FontSize',14)
ylabel('Execution Time (s)','FontSize',14)
grid on
legend('Formula (18)', 'Theorem 1')

figure
plot(dim,timesM1,"b")
set(gca,'FontSize',14)
xlabel('Dimension (m)','FontSize',14)
ylabel('Execution Time (s)','FontSize',14)
grid on
legend('Formula (18)')

figure
plot(dim,speedup)
set(gca,'FontSize',14)
xlabel('Dimension (m)','FontSize',14)
ylabel('Speedup','FontSize',14)
grid on

figure
plot(dim,percent_difference)
set(gca,'FontSize',14)
xlabel('Dimension (m)','FontSize',14)
ylabel('Percent Diference','FontSize',14)
grid on

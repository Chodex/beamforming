%******************example2.1*************
close all
clear all
clc

N=10;
lambda=1;  %����
theta0=10;  %��Ƶ�ź����䷽��
v0=[-sind(theta0),cosd(theta0)];  %��������
k0=2*pi./lambda*v0;
sig=1000;
noise=1;

%*************************����λ��******************************************
position=zeros(2,N);
position(2,:)=0;
for mm=1:N
    position(1,mm)=(mm-1)*lambda./2;   
    as(mm)=exp(-i*(k0*position(:,mm)));   %������Ӧ����
end
as=as';%������
Rx0 =sig*as*as'+noise*eye(N);%+ sigma_i*a_i*a_i';  %�����ź�Э�������
w_beamforming=inv(Rx0)*as/(as'*inv(Rx0)*as);  %MVDR������Ȩ����
% w_beamforming=as/N;  %���沨����Ȩ����

%***************************����ɨ�跽��************************************
theta = (-90:0.1:90).';
ptheta=zeros(1,length(theta));
v = [-sind(theta) cosd(theta)];
k = 2*pi/lambda*v;   
for nn=1:N
    a_theta(:,nn)=exp(i*(k*position(:,nn))) ;
end
%**************************************************************************
ptheta= w_beamforming'*a_theta.';  %������Ӧ  pthata=��Ȩʸ��*������������   ������������ģ���÷����Ƿ����ź��޹�
figure
plot(theta,20*log10(abs(ptheta)),'LineWidth',1.5);%%%%�����ź�10�ȷ���Ĳ���ͼ
grid on
% xlim([-90 90]);ylim([-90 10])
xlabel('����ͼ  ��λ');ylabel('����/dB');
% title('10Ԫ����MVDR�����γ�')



%***********��λ��**********************
theta_0=-90:1:90;
figure
P=zeros(1,length(theta_0));
a=zeros(N,1);
for mm=1:length(theta_0)
    vd=[-sind(theta_0(mm)),cosd(theta_0(mm))];
    kd=2*pi./lambda*vd;
    for nn=1:N
        a(nn)=exp(-i*(kd*position(:,nn)));
    end
%     Rx = sig*as*as'+noise*eye(N);
   w_beamforming=inv(Rx0)*a/(a'*inv(Rx0)*a); 
  ww(mm,:)=inv(Rx0)*a/(a'*inv(Rx0)*a); 
   P(mm)=w_beamforming'*Rx0*w_beamforming;
end
figure(2)
plot(theta_0,10*log10(abs(P)),'LineWidth',1.5);
grid on;
xlim([-90,90]);ylim([-15,40])
xlabel('��λ/(^o)');ylabel('��λ��/dB')
title('��λ��')
figure
 plot(theta_0,10*log10(ww(1:181,:).^2),'LineWidth',1.5);figure(gcf)
 grid on;
 xlabel('��Ȩ��������');ylabel('l0lg(||w||^2)')
% plot(theta_0,10*log10(abs(w_beamforming.^2)),'LineWidth',1.5)
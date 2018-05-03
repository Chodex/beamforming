%**************example2.4***********************************************
close all
clear all
clc


N=10;
lambda=1;
noise = 1;
sig1 = 10^1.5;
theta1=-10;  
v1=[-sind(theta1),cosd(theta1)];
k1=2*pi/lambda*v1;

sig2 = 10^3;
theta2=10;
v2=[-sind(theta2),cosd(theta2)];
k2=2*pi/lambda*v2;

%*************************����λ��******************************************
position=zeros(2,N);
position(2,:)=0;
for mm=1:N
    position(1,mm)=(mm-1)*lambda./2;   
    as1(mm)=exp(-i*(k1*position(:,mm)));   %�ź�1 15dB -10�Ȼ�����Ӧ����
    as2(mm)=exp(-i*(k2*position(:,mm)));   %�ź�2 30dB 10�Ȼ�����Ӧ����
end
as1=as1';%������
as2=as2';
as=as1+as2;
Rx0 =sig1*as1*as1'+sig2*as2*as2'+noise*eye(N);%+ sigma_i*a_i*a_i';  %�����ź�Э�������

w_beamforming=inv(Rx0)*as/(as'*inv(Rx0)*as);  %MVDR������Ȩ����
w2_beamforming=as/N;  %���沨����Ȩ����

%*******************************MVDR��λ��**********************************
theta_0=-90:1:90;
P=zeros(1,length(theta_0));
a=zeros(N,1);
for mm=1:length(theta_0)
    vd=[-sind(theta_0(mm)),cosd(theta_0(mm))];
    kd=2*pi./lambda*vd;
    for nn=1:N
        a(nn)=exp(-i*(kd*position(:,nn)));
    end
%     Rx = sig1*as*as'+noise*eye(N);
   w_beamforming=inv(Rx0)*a/(a'*inv(Rx0)*a); 
  ww(mm,:)=inv(Rx0)*a/(a'*inv(Rx0)*a); 
   P(mm)=w_beamforming'*Rx0*w_beamforming;
end
figure(2)
plot(theta_0,10*log10(abs(P)),'LineWidth',1.5);
grid on;
% xlim([-90,90]);ylim([-15,40])
xlabel('��λ/(^o)');ylabel('��λ��/dB')
title('��λ��')
%**************************************************************************
%*******************************���淽λ��**********************************
 w_beamforming= w2_beamforming;
theta_0=-90:1:90;
% figure
P=zeros(1,length(theta_0));
a=zeros(N,1);
for mm=1:length(theta_0)
    vd=[-sind(theta_0(mm)),cosd(theta_0(mm))];
    kd=2*pi./lambda*vd;
    for nn=1:N
        a(nn)=exp(-i*(kd*position(:,nn)));
    end
%     Rx = sig1*as*as'+noise*eye(N);
   w_beamforming=a/N; 
  ww(mm,:)=a/N; 
   P(mm)=w_beamforming'*Rx0*w_beamforming;
end
figure()
plot(theta_0,10*log10(abs(P)),'LineWidth',1.5);
grid on;
% xlim([-90,90]);ylim([-15,40])
xlabel('��λ/(^o)');ylabel('��λ��/dB')
title('��λ��')

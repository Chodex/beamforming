%*************************example2.2*************************************
close all
clear all
clc

N=10;
lambda=1;
theta0=10;
v0=[-sind(theta0),cosd(theta0)];  %��������
k0=2*pi./lambda*v0;
sig=1;
%*************************����λ��******************************************
position=zeros(2,N);
position(2,:)=0;
for mm=1:N
    position(1,mm)=(mm-1)*lambda./2;   
    as(mm)=exp(-i*(k0*position(:,mm)));   %������Ӧ����
end
as=as';%������
Rx0 =sig*as*as' ;%+ sigma_i*a_i*a_i';  %�����ź�Э�������
% w_beamforming=as/(as'*as);  %���沨����Ȩ����
w_beamforming=as/N;  %���沨����Ȩ����

%***************************����ɨ�跽��**********************************
theta = (-90:0.1:90).';
ptheta=zeros(1,length(theta));
v = [-sind(theta) cosd(theta)];
k = 2*pi/lambda*v;   
for nn=1:N
    a_theta(:,nn)=exp(i*(k*position(:,nn))) ;
end
% a_theta = [exp(-(k*p1)*i),exp(-(k*p2)*i),exp(-(k*p3)*i),exp(-(k*p4)*i),exp(-(k*p5)*i),exp(-(k*p6)*i),exp(-(k*p7)*i),exp(-(k*p8)*i),exp(-(k*p9)*i),exp(-(k*p10)*i)];
ptheta= w_beamforming'*a_theta.';  %������Ӧ  pthata=��Ȩʸ��*������������   ������������ģ���÷����Ƿ����ź��޹�
figure
plot(theta,20*log10(abs(ptheta)),'LineWidth',1.5);%%%%�����ź�10�ȷ���Ĳ���ͼ
grid on;xlabel('����ͼ  ��λ');ylabel('����/dB');


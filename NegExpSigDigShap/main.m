clc;
close all;
clear all;


% ��������
Ts = 0.05; % ��������
tao = 1.5; % ˥��ʱ�䳣��
nr = 50; % ����б��ʱ��
nf = 0; % ����ƽ�����ȣ�Ϊ0��Ϊ�����γ��Σ�
vmax = 100; % ����ֵ

zN = 30;
N = 500;
noise_value = 1;
k = 18;

% ���ɸ�ָ���ź�
vi1 = NegExpSigGen( vmax, Ts, tao, zN, N, 0 );
vi2 = NegExpSigGen( vmax, Ts, tao, zN, N, 1 ); 
% vi3 = NegExpSigGen( vmax, Ts, tao, zN, N, 0 ); 
% vi4 = NegExpSigGen( vmax, Ts, tao, zN, N, 0 ); 

% ���γ���
vo1_tra = TraAndTriDigShaping( vi1, Ts, tao, 35, 30);
vo2_tra = TraAndTriDigShaping( vi2, Ts, tao, 35, 30);

% �����γ���
vo1_tri = TraAndTriDigShaping( vi1, Ts, tao, nr, nf);
vo2_tri = TraAndTriDigShaping( vi2, Ts, tao, nr, nf);

% ��˹����
vo1 = SKfilter( vi1, zN, N, k );
vo2 = SKfilter( vi2, zN, N, k );

% ���������
snr_orig = SNRcal(vi1, vi2);
snr_tra = SNRcal(vo1_tra, vo2_tra);
snr_tri = SNRcal(vo1_tri, vo2_tri);
snr_SK = SNRcal(vo1, vo2);

plot(1:N, vi1, 1:N, vo1, 250:N+249, vi2, 250:N+249, vo2, 'linewidth', 2); % 40:N+39, vi3, 60:N+59, vi4,
grid
axis([-inf inf -10 110])
legend('δ���������������', '��δ���ӣ���˹�����ź�', '���������������', '�����ӣ���˹�����ź�')

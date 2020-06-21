
% Set a fake state 
% q = [theta; phi; alpha1; alpha2];
% dq = [dtheta; dphi; dalpha1; dalpha2];
q = [0, 0*pi/180, pi/4, pi/4];
dq = [0, 0, 0, 0];
X = [q, dq]';

time = 0;

% Draw robot model
draw_bb_w2DOFArm(time,X);
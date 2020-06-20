
% Set a fake state 
% q = [theta; phi; alpha1; alpha2];
% dq = [dtheta; dphi; dalpha1; dalpha2];
q = [0, 0, pi/2, 0];
dq = [0, 0, 0, 0];
X = [q, dq]';

time = 0;

% Draw robot model
draw_bb_w2DArm(time,X);
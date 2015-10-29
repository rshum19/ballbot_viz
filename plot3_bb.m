function h = plot3_bb(X, varargin)

persistent last_X last_ball

x_theta = X(1);
x_phi = -X(2);

y_theta = X(3);
y_phi = -X(4);

r_s = 0.106;
l = 0.69;

r_b = .184;
h_b = 1.41;

x_s = -r_s*x_theta;
y_s = -r_s*y_theta;
z_s = r_s;

%ball
ball = [x_s y_s z_s]';


R_phix = [cos(x_phi) 0 sin(x_phi); 0 1 0; -sin(x_phi) 0 cos(x_phi)];
R_phiy = [1 0 0; 0 cos(-y_phi) -sin(-y_phi); 0 sin(-y_phi) cos(-y_phi)];

R = R_phiy*R_phix; 

%COM
com = ball + R*[0 0 l]';



%body
hb2 = h_b/2;
body_bot = com - R*([0 0 h_b/2]');
body_top = com + R*([0 0 h_b/2]');

body_c = [.8 .4 .1];
body_a = .75;
body_f = 25;

ball_c = [.5 .1 .1];
ball_a = .7;
ball_f = 15;

if(nargin == 1)	
	h = [0 0];
	h(1) = cylinder3( body_bot , body_top, r_b, body_f, body_c, 0, body_a);
	hold on
	h(2) = sphere3(ball, [x_theta y_theta], r_s, ball_f, ball_c, 1, ball_a);
	hold off
	axis equal;
	
	last_X = X;
	last_ball = ball;
else
	h = varargin{1};
	cylinder3( body_bot , body_top, r_b, body_f, body_c, 0, body_a, h(1));
	% 	sphere3(ball, [x_theta y_theta], r_s, ball_f, ball_c, 1, ball_a,h(2));
	
	set(h(2),'XData', get(h(2),'XData')+(ball(1)-last_ball(1)));
	set(h(2),'YData', get(h(2),'YData')+(ball(2)-last_ball(2)));
	
	x_th_diff = X(1) - last_X(1);
	y_th_diff = X(3) - last_X(3);
	rotate(h(2),[0 -1 0]', x_th_diff*180/pi, ball);
	rotate(h(2),[1 0 0]', y_th_diff*180/pi, ball);
	
	last_X = X;
	last_ball = ball;
end




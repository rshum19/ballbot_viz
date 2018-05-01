function draw_bb(time,X)
theta = X(1);
phi = X(2);
beta = 0;

r_s = 0.106;
l = 0.69;

r_b = .184;
h_b = 1.41;

x_s = r_s*(theta + phi);
y_s = r_s;

L_armp = 0.85; %m
l_arm = 0.457; %m 

m_body = 51.663126;
m_arm = 3;

%ball
%t=0:(2*pi/30):2*pi;
%ball_x = [x_s + r_s*cos(t+theta+phi) x_s];
%ball_y = [y_s + r_s*sin(t+theta+phi) y_s];

t=2*pi:(-2*pi/30):0;
ball_x = [x_s + r_s*cos(t+theta+phi) x_s];
ball_y = [y_s - r_s*sin(t+theta+phi) y_s];

%COM
com_x = x_s + l*sin(phi);
com_y = y_s + l*cos(phi);

%body
body_x = com_x + [-r_b r_b r_b -r_b -r_b].*cos(phi) + ...
	([h_b h_b -h_b -h_b h_b]./2).*sin(phi);
body_y = com_y - [-r_b r_b r_b -r_b -r_b].*sin(phi) + ...
	([h_b h_b -h_b -h_b h_b]./2).*cos(phi);

%system CoM
bb_com_x = x_s + l*sin(phi + beta);
bb_com_y = y_s + l*cos(phi + beta);

COM_x = [x_s bb_com_x];
COM_y = [y_s bb_com_y];

% Center line
cl_x  = [x_s x_s + h_b*sin(phi)];
cl_y  = [y_s y_s + h_b*cos(phi)];


if(nargin == 2)
    plot(cl_x,cl_y,'LineWidth',2,'Color',[.2 .2 .7]);
	hold on;
    plot(COM_x,COM_y,'--o','LineWidth',2,'Color',[.7 .2 .18],...
		'MarkerSize',15);
	plot(body_x,body_y,'LineWidth',3,'Color',[.2 .2 .7]);
    plot(ball_x,ball_y,'LineWidth',3,'Color',[.75 .4 .1]);
	
    % Formate the figure
    title(sprintf(' t = %6.4f', time));
    grid off;
	axis equal;
    
    hold off;
end





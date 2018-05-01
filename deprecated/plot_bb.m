function h = plot_bb(X, varargin)
theta = X(1);
phi = X(2);

r_s = 0.106;
l = 0.69;

r_b = .184;
h_b = 1.41;

x_s = r_s*theta;
y_s = r_s;

%ball
t=0:(2*pi/30):2*pi;
ball_x = [x_s - r_s*cos(t-theta) x_s];
ball_y = [y_s - r_s*sin(t-theta) y_s];

%COM
com_x = x_s + l*sin(phi);
com_y = y_s + l*cos(phi);
COM_x = [x_s com_x];
COM_y = [y_s com_y];

%body
body_x = com_x + [-r_b r_b r_b -r_b -r_b].*cos(phi) + ...
	([h_b h_b -h_b -h_b h_b]./2).*sin(phi);
body_y = com_y - [-r_b r_b r_b -r_b -r_b].*sin(phi) + ...
	([h_b h_b -h_b -h_b h_b]./2).*cos(phi);

if(nargin ==1)
	h(1) = plot(COM_x,COM_y,'--o','LineWidth',2,'Color',[.7 .2 .18],...
		'MarkerSize',15);
	hold on;
	h(2) = plot(body_x,body_y,'LineWidth',3,'Color',[.2 .2 .7]);
	h(3) = plot(ball_x,ball_y,'LineWidth',3,'Color',[.75 .4 .1]);
	hold off;
	axis equal;
else
	h = varargin{1};
	set(h(1),'XData',COM_x,'YData',COM_y);
	set(h(2),'XData',body_x,'YData',body_y);
	set(h(3),'XData',ball_x,'YData',ball_y);
end



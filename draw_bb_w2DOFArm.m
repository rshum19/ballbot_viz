function draw_bb_w2DOFArm(time,X)


%% Define colors
orangeColor = [.7 .2 .18];
bodyColor = [.2 .2 .7];
ballColor = [.75 .4 .1];
armColor = [.75 .4 .1];

%% Unpack state variables:
theta = X(1);
phi = X(2);
alpha = X(3);

%% Get ballbot w2DArm parameters
params = get_ballbot2D_model_params(1);

%% Perform forward kinematics
[p_ball,p_body,p_shoulder,p_arm1,p_arm2,p_com] = ballbot2D_w2DOFArm_kinematics_wrap(X,params);

%% Unpack Robot Dimension Parameters

% Body dimensions
r_b = params.r_body;
h_b = params.h_body;


%% Perform forward kinematics
%ball
t=0:(2*pi/30):2*pi;
ball_x = [p_ball(1) + params.r*cos(t+theta) p_ball(1)];
ball_y = [p_ball(2) + params.r*sin(t+theta) p_ball(2)];

%COM
% com_x = p_body(1);
% com_y = p_body(2);

%body rectangle shape
body_x = p_body(1) + [-r_b r_b r_b -r_b -r_b].*cos(phi) + ...
	([h_b h_b -h_b -h_b h_b]./2).*sin(phi);
body_y = p_body(2) - [-r_b r_b r_b -r_b -r_b].*sin(phi) + ...
	([h_b h_b -h_b -h_b h_b]./2).*cos(phi);

%body center line
cl_x  = [p_ball(1) p_ball(1) + h_b*sin(phi)];
cl_y  = [p_ball(2) p_ball(2) + h_b*cos(phi)];

%arm
arm1_x = [p_shoulder(1) p_arm1(1)];
arm1_y = [p_shoulder(2) p_arm1(2)];

arm2_x = [arm1_x(2) p_arm2(1)];
arm2_y = [arm1_y(2) p_arm2(2)];

%system CoM
COM_x = [p_ball(1) p_com(1)];
COM_y = [p_ball(2) p_com(2)];

%% Plot
    plot(cl_x,cl_y,'LineWidth',2,'Color',[.2 .2 .7]);
	hold on;
    plot(COM_x,COM_y,'--o','LineWidth',2,'Color',[.7 .2 .18],'MarkerSize',15);
	plot(body_x,body_y,'LineWidth',3,'Color',[.2 .2 .7]);
    plot(ball_x,ball_y,'LineWidth',3,'Color',[.75 .4 .1]);
    plot(arm1_x,arm1_y,'-o','LineWidth',3,'Color',[.75 .4 .1]);
    plot(arm2_x,arm2_y,'-o','LineWidth',3,'Color',[.75 .4 .1]);
    
    % Formate the figure
    title(sprintf(' t= %6.4f',time));
    grid on;
    axis equal;
    
    hold off;
end


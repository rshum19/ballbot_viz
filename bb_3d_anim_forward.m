function h = bb_3d_anim_forward(theta_x, phi_x, theta_y, phi_y, t_0, t_f, h, ptf)

get_bb_consts;

dt = .01;

if(nargin < 8)
    ptf = t_f;
end

if(nargin < 7)
	
	xr = -polyval(theta_x,[0 t_f])*r;
	yr = -polyval(theta_y,[0 t_f])*r;
	bounds = [min(xr)-.5 max(xr)+.5 min(yr)-.5 max(yr)+.5 0 2];
	
	
	x_theta = polyval(theta_x,0);
	x_phi = polyval(phi_x,0);
	y_theta = polyval(theta_y,0);
	y_phi = polyval(phi_y,0);
	
	X = [x_theta x_phi y_theta y_phi]';
	h = plot3_bb(X);
    
	axis equal;
	axis(bounds);
    
    hold on
    floor_opts = {'-','Color',[0.8 0.8 0],'LineWidth',2.5};
    h(3) = plot3(-x_theta*r, -y_theta*r, 0, floor_opts{:});
    
    
    %ball
    ball = [-polyval(x_theta,0)*r -polyval(y_theta,0)*r r]';

    x_p = -x_phi;
    y_p = -y_phi;    
    R_phix = [cos(x_p) 0 sin(x_p); 0 1 0; -sin(x_p) 0 cos(x_p)];
    R_phiy = [1 0 0; 0 cos(-y_p) -sin(-y_p); 0 sin(-y_p) cos(-y_p)];
    R = R_phiy*R_phix; 

    %COM
    com = ball + R*[0 0 l]';
    com_opts = {'-','Color',[0.9 0.1 0],'LineWidth',2.5};
    h(4) = plot3(com(1),com(2),com(3), com_opts{:});
    
    forward_opts = {'-','Color',[0.1 0.2 0.7],'LineWidth',2.5};
    h(5) = plot3(-polyval(x_theta,0)*r, -polyval(y_theta,0)*r, 0, forward_opts{:});
    
    t = 0;
    tt = t:dt:t_f;
    set(h(5),'XData',-polyval(theta_x,tt')*r);
    set(h(5),'YData',-polyval(theta_y,tt')*r);
    set(h(5),'ZData', 0.*tt');
    hold off
    
    drawnow
else
    t = t_0;
    tic
    while(t < t_f)
        t = toc+t_0;
        x_theta = polyval(theta_x,t);
        x_phi = polyval(phi_x,t);
        y_theta = polyval(theta_y,t);
        y_phi = polyval(phi_y,t);

        X = [x_theta x_phi y_theta y_phi]';
        plot3_bb(X,h);


        set(h(3),'XData',[get(h(3),'XData') -x_theta*r]);
        set(h(3),'YData',[get(h(3),'YData') -y_theta*r]);
        set(h(3),'ZData',[get(h(3),'ZData') 0]);


        %ball
        ball = [-x_theta*r -y_theta*r r]';
        
        
        x_phi = -x_phi;
        y_phi = -y_phi;
        R_phix = [cos(x_phi) 0 sin(x_phi); 0 1 0; -sin(x_phi) 0 cos(x_phi)];
        R_phiy = [1 0 0; 0 cos(-y_phi) -sin(-y_phi); 0 sin(-y_phi) cos(-y_phi)];
        R = R_phiy*R_phix; 

        %COM    
        com = ball + R*[0 0 l]';

        set(h(4),'XData',[get(h(4),'XData') com(1)]);
        set(h(4),'YData',[get(h(4),'YData') com(2)]);
        set(h(4),'ZData',[get(h(4),'ZData') com(3)]);
        
        tt = t:dt:ptf;
        set(h(5),'XData', -polyval(theta_x,tt)*r);
        set(h(5),'YData', -polyval(theta_y,tt)*r);
        set(h(5),'ZData', 0.*tt);

        drawnow;
%         pause(dt);
    end

end




    
    
    
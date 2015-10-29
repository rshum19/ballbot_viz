x_theta = 0;
x_phi = 0;
y_theta = 0;
y_phi = 0;
X = [x_theta;x_phi;y_theta;y_phi];

%%
h = plot3_bb(X);

%%
axis([-2 2 -2 2 0 2]);

%%
for x_theta=[0:.1:4*pi]
    X = [x_theta;x_phi;y_theta;y_phi];
    plot3_bb(X,h);
    drawnow;
    pause(.01);
end
%%
for y_theta=[0:.1:2*pi]
    X = [x_theta;x_phi;y_theta;y_phi];
    plot3_bb(X,h);
    drawnow;
    pause(.01);
end
%%
for x_phi=.1*sin(0:.1:4*pi)
    X = [x_theta;x_phi;y_theta;y_phi];
    plot3_bb(X,h);
    drawnow;
    pause(.01);
end

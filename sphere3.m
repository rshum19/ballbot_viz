 function [Sphere] = sphere3(X,Theta,r,n,sph_color,lines,alpha, h)
 % function [Sphere] = sphere3(X,r,n,color, lines,alpha)

 Theta = [Theta(2) -Theta(1)];
 %Theta = [-Theta(2) Theta(1)];
 
 Rx = [1 0 0; 0 cos(Theta(1)) -sin(Theta(1)); 0 sin(Theta(1)) cos(Theta(1))];
 Ry = [cos(Theta(2)) 0 sin(Theta(2)); 0 1 0; -sin(Theta(2)) 0 cos(Theta(2))];
 
 [x1, x2, x3] = sphere(n);
 
 XX = [reshape(x1,(n+1)^2, 1), ...
	 reshape(x2,(n+1)^2, 1), ...
	 reshape(x3,(n+1)^2, 1)];
 
 XX = (Rx*Ry*XX')';
 %XX = XX*Ry*Rx;
 
 x1 = reshape(XX(:,1), n+1, n+1);
 x2 = reshape(XX(:,2), n+1, n+1);
 x3 = reshape(XX(:,3), n+1, n+1);
 
 xx1 = (x1.*r) + X(1); 
 xx2 = (x2.*r) + X(2);  
 xx3 = (x3.*r) + X(3);
 
  
 if(nargin == 7)
	 Sphere = surf(xx1,xx2,xx3);
 else
	 set(h, 'XData', xx1);
	 set(h, 'YData', xx2);
	 set(h, 'ZData', xx3);
 end
 
 %{
 x_ax = [1 0 0]; y_ax = [0 1 0];
 Theta = Theta.*180/pi;
 rotate(Sphere, y_ax, Theta(2), X);
 rotate(Sphere, x_ax, Theta(1), X);
 %}
 
 % Setting the color to the cylinder and the end plates
 set(Sphere,'FaceColor',sph_color)
 
 % If lines are not needed making it disapear
 set(Sphere,'EdgeColor','k');
 
 if lines==0
	 set(Sphere,'EdgeAlpha',0)
 end
 
 set(Sphere, 'FaceAlpha',alpha);
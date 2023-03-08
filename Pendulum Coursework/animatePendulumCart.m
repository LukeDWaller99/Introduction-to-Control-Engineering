function animatePendulumCart(thetaIn, xIn, L, t, range, kickFlag, titleMessage)

%checking the lengths of theta
if (length(thetaIn) ~= length (xIn))
    disp('Error in AnimatePendulumCart: length(thetaIn) ~=  length(xIn)');
    return
end 
if( length(thetaIn) ~=  length(t))
    disp('Error in AnimatePendulumCart: length(thetaIn) ~=  length(t)');
    return
end
if( length(thetaIn) >  length(kickFlag))
    disp('Error in AnimatePendulumCart: length(thetaIn) > length(kickFlag)');
    return
end
if(length(L) > 1)
        disp('Error in AnimatePendulumCart: length(L) > 1)');
    return
end
if(length(range) > 1)
        disp('Error in AnimatePendulumCart: range(L) > 1)');
    return
end
if(length(titleMessage) < 1)
        disp('Error in AnimatePendulumCart: titleMessage(L) < 1)');
    return
end
  
%set font size
fontSize = 15;

%set arrow size
arrowSize = 75;

%width of the cart in m 
W = 8/100;

%height of the cart in m
H = 8/100;

%endpoint of the mass radius
mr = 2/100; 

%cart vertical poistion
y = H/2;

%location of the kick arrow
kickLocation = L + mr + H/2;

%diameter of the rail 
railDiameter = 6/100;

%diameter of the rod 
rodDiameter = 6/100;

%animating all the results for the all time point
points = length(t);
for k = 2 : points
    
    %calculating the time step 
    timeStep = t(k) - t(k-1);
    
    %get postion and angle values
    theta = thetaIn(k);
    x = xIn(k);
    
    %use this to draw the rails
    h = plot([- range range], [0,0],'w'); %sets the rails lines to white
    set(h,'LineWidth', railDiameter);
    
    hold on
    
    %scale the arrow
    arrowSizeScaled = arrowSize * sqrt(abs(kickFlag(k)));
    
    %draw exciting arrow to represent initial kick
    if (kickFlag(k) > 0)
        %place at the top of the pendulum on right
        h = text(0, kickLocation, '\rightarrow', 'HorizontalAlignment', 'right');
        set(h, 'FontSize', arrowSizeScaled, 'Color', 'w');
        
    elseif (kickFlag(k) < 0)
        %place at the top of the pendulum on the left
        h = text(0, kickLocation, '\leftarrow', 'HorizontalAlignment', 'left');
        set(h, 'FontSize', arrowSizeScaled, 'Color', 'w');
    end
    
    %printing the frame count
    message = sprintf('Frame: %d/%d ', k, points);
    h = text(1, 0.5, message);
    set(h,'FontSize', fontSize, 'Color','w'); %printing the frame count in white
    
    %write the title 
    h = title(titleMessage);
    set(h,'FontSize', fontSize, 'Color','w');
    
    %draw the carriage
    rectangle('Position', [x-W/2,y-H/2,W,H], 'Curvature', 0.1, 'FaceColor', [1 0.1 0.1], 'EdgeColor', [1 1 1]);
    
    %location of the end of the rod
    px = x + L * sin(theta);
    py = y - L * cos(theta);

    %draw the rod
    h=plot([x px], [y py], 'w');
    set(h,'LineWidth', rodDiameter);
    
    %drawing the carriage onto the display
    rectangle('Position', [px-mr/2, py-mr/2,mr, mr], 'Curvature', 1, 'FaceColor', [0.3 0.3 1], 'EdgeColor', [1 1 1]);
    
    %drawing the pivot onto the display 
    rectangle('Position', [x-mr/2, y-mr/2, mr, mr], 'Curvature', 1, 'FaceColor', [0.4 0.4 1], 'EdgeColor', [1 1 1]);
    
    %set the axis range in cm
    xlim([-range range]);
    ylim([-range range]); 
    %axis range ([-45 45 to -75 75])
    
    axis equal; %keeps the scailing of the axis
    
    %setting the colours of the plot 
    %Black for the background (k)
    %White for the X and Y axis (w)
    set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w');
    
    %setting the position and size of the display window bigger than the
    %default
    set(gcf,'Position',[10 200 1000 500]);
    
    %setting the outside to black
    set(gcf,'Color','k');
    
    %label for the x-axis
    h = xlabel('Horizontal location [m]');
    set(h,'FontSize', fontSize);
    
    %label for the y-axis
    h = ylabel('Vertical position [arbirtary units]');
    set(h,'FontSize', fontSize);
    
    %setting the size of the the axis numbering
    set(gca, 'FontSize', fontSize);
    
    %wait for the time step to give real-time animation, this only works
    %when step time is roughly > 1/20 of a second
    pause(timeStep)
    
    %box off
    drawnow;
    
    hold off;
    
end
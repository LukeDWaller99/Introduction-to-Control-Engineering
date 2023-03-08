function plotStateVariable(xData, tData, titleMessage)

minLength = nanmin([length(xData) length(tData)]);
xData = xData(:,1:minLength);
time = tData(1:minLength);

%setting the font size 
params.fontSize = 20;

close all;
figure
hold on
h = plot(time, xData(1,:), 'b'); %plots line in blue (theta, angle of the pendulum)
set(h, 'LineWidth', 3); %sets width of the theta line 
h = plot(time, xData(2,:), 'r'); %plots line in red (angular velocity of the pedulum)
set(h, 'LineWidth', 3); %sets width of the angular velocity line

h = legend('theta[radians]', 'x2'); %creates the legend for the graph
set(h,'FontSize', params.fontSize); %sets the font size to params.fontSize

%label the x-axis
h = xlabel('Time [s]'); %set the x-axis title to Time [s]
set(h, 'FontSize', params.fontSize); %sets the font size to params.fontSize

%label the y-axis
h = ylabel('Angle, Angular Velocity, Displacement'); %set the y-axis title
set(h, 'FontSize', params.fontSize); %sets the font size to params.fontSize

%label title of the graph
h = title(titleMessage); %sets the title of the graph
set(h, 'FontSize', params.fontSize); %sets the font soze to params.fontSize

%set size of the numbers on the axis
set(gca, 'FontSize', params.fontSize);

%draw the y-axis line
h = myDrawXLine(0, 0, time(end), 'k:');
set(h, 'LineWidth', 3);

end 
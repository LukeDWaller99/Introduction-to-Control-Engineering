function handle = myDrawXLine (yPos, xMin, xMax, lineProperties)

%this is used to draw a line along the y-axis at the specified x postion
y = [yPos yPos];
x = [xMin, xMax]; 
handle = plot(x, y, lineProperties);

end 
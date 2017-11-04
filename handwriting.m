% Anish Saha - 11/03/17 - MATLAB
% Function that uses a set handwriting template letters, and given a 
% string, outputs a graphical representation of it in handwriting form
% using spline interpolation on 30 uniformly spaced points.
function handwriting(x)
    for j = 1:length(x)
        % Initialize a new fullscreen figure
        if rem(j,64) == 1
            figure('units','normalized','outerposition',[0 0 1 1]);
        end
        % Continue to next plot for spaces
        if x(j) == ' '
            continue
        end    
        % Process the appropriate letter
        fileName = strcat(x(j), '.png');
        letter = imread(fileName);
        % Change image to grayscale if necessary
        if size(letter,3) == 3
            letter = rgb2gray(letter);
        end
        % Binarize image and create boundaries
        l = imbinarize(letter); 
        im = bwboundaries(1 - l);
        im_cell = cell(length(im),1);
        % Store 30 evenly spaced points from letter into a cell
        for i = 1:length(im)
            im_cell{i} = im{i}(1:ceil(length(im{i})/30):end, :);
        end
        % Create splines of the boundaries and plot them on a graph
        set(gca,'Visible','off');
        subplot(8,8,j);
        % Perform spline interpolation on boundary i
        for i = 1:length(im)
            s1 = spline(1:ceil(length(im{i})/30):length(im{i}),im_cell{i}(:,1),1:length(im{i}));
            s2 = spline(1:ceil(length(im{i})/30):length(im{i}),im_cell{i}(:,2),1:length(im{i}));
            plot(s1, s2); hold on;
        end
        % Rotate the graph to have the correct orientation
        view(90,90)       
    end
    % Make the handwriting representation more clear by removing borders
    set(gcf,'color','w');
    set(gca,'Visible','off')
    % Save the resulting image as result.png
    saveas(gcf, 'result', 'png')
end

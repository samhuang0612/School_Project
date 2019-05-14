% =========================================================================
% AUTHOR ..... Huang, Lishan  Han, Jiarong Brown, Fraser Chen, Yushan 
% DATE .... March 22
%
% Description: Numerically evaluation of graph length
% =========================================================================
%%
% *Script*
    clear all
    % load the data in jelly.mat
    load jelly.mat
    n = numel(xdat);
    %initialize the length
    size = 0;
    %plot graph
    plot(xdat,ydat)
    title("filament's position")
    xlabel("x")
    ylabel("y")
    %calculate the length between each two point
        for i = 1:length(xdat)-1
          size = size + sqrt( (xdat(i+1)-xdat(i))^2 + (ydat(i+1)-ydat(i))^2 );
        end
    %display the result
    disp(['The length is ', num2str(size)])
    
        if size>30
            disp('The length is more than 30, Eunice can not live')
        else
            disp('The length is less than 30, so Eunice can live')
        end


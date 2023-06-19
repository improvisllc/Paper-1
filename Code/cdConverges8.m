clc; clear;
csvFiles = dir(fullfile('CDConferge','*.csv'));
cells1 = [26718,45540,86027,166345];
cells2 = [166345,328144,665275,1308296];
cells3 = [313155,583369,1156622,1510492];
leg0 = [];
leg1 = [];
leg2 = [];
leg3 = [];
ctr0 = 1;
ctr1 = 1;
ctr2 = 1;
ctr3 = 1;

for k = 1:length(csvFiles)
    fName = csvFiles(k).name;
    data = csvread(['CDConferge\',fName]);
    if(fName(1) == '0')        
        subplot(4,1,1);
        plot(data(:,1), data(:,2)); grid on; hold on;
        xlabel('iterations');
        ylabel('C_D_0');
        title('C_D_0 convergence at {\itMa} 0.5');
        leg0 = [leg0, {num2str(cells1(ctr0))}];  
        legend(leg0);
        ctr0 = ctr0 + 1;
    elseif (fName(1) == '1')
        if (fName(3) == '0')            
            subplot(4,1,2);
            plot(data(:,1), data(:,2)); grid on; hold on;
            xlabel('iterations');
            ylabel('C_D_0');
            title('C_D_0 convergence at {\itMa} 1.0');
            leg1 = [leg1, {num2str(cells2(ctr1))}];  
            legend(leg1);
            ctr1 = ctr1 + 1;
        else            
            subplot(4,1,3);
            plot(data(:,1), data(:,2)); grid on; hold on;
            xlabel('iterations');
            ylabel('C_D_0');
            title('C_D_0 convergence at {\itMa} 1.6');
            leg2 = [leg2, {num2str(cells2(ctr2))}];  
            legend(leg2);            
            ctr2 = ctr2 + 1;
        end
    elseif (fName(1) == '3')        
        subplot(4,1,4);
        plot(data(:,1), data(:,2)); grid on; hold on;
        xlabel('iterations');
        ylabel('C_D_0');
        title('C_D_0 convergence at {\itMa} 3.0');
        leg3 = [leg3, {num2str(cells3(ctr3))}];
        legend(leg3);
        ctr3 = ctr3 + 1;
    end
end
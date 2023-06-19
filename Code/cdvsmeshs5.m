clc; clear;

Cells1 = [12644,22156,39768,70792];
Cells2 = [12644,22156,39768,70792,101632];
Cells3 = [22156,39768,70792,132076,181799];

cells1 = Cells1(1):Cells1(4);
cells2 = Cells2(1):Cells2(5);
cells3 = Cells3(1):Cells3(5);

Cd03 = [0.798214,0.840966,0.879612,0.893759];
Cd05 = [0.818802,0.863613,0.877776,0.908221];
Cd07 = [0.847152,0.898067,0.920872,0.957501];
Cd09 = [0.894485,0.950079,0.974366,1.01733,1.03215];
Cd10 = [0.929676,0.998814,1.03098,1.08844,1.10802];
Cd11 = [0.960837,1.02929,1.06514,1.12396,1.13246];
Cd12 = [0.92859,0.981713,1.01796,1.07533,1.08824];
Cd14 = [0.876449,0.912011,0.934225,0.975028,1.02241];
Cd16 = [0.859573,0.899855,0.9278,0.997888,1.01266];
Cd18 = [0.790749,0.822302,0.863383,0.934445,0.967812];
Cd20 = [0.748331,0.778436,0.838815,0.92744,0.938896];
Cd25 = [0.655313,0.710141,0.766345,0.822538,0.840942];
Cd30 = [0.556768,0.609702,0.670411,0.736311,0.762824];
Cd35 = [0.481696,0.533535,0.594883,0.661005,0.693651];
Cd40 = [0.424122,0.474036,0.534646,0.602764,0.635641];

dCd03 = zeros(1,3); dCd05 = dCd03; dCd07 = dCd05; dCd09 = dCd07; dCd10 = dCd09; dCd11 = dCd10; dCd12 = dCd11; dCd14 = dCd12;
dCd16 = dCd14; dCd18 = dCd16; dCd20 = dCd18; dCd25 = dCd20; dCd30 = dCd25; dCd35 = dCd30; dCd40 = dCd35;

for i=2:4
    dCd03(i-1) = (Cd03(i) - Cd03(i-1)) * 100 / Cd03(i-1);
    dCd05(i-1) = (Cd05(i) - Cd05(i-1)) * 100 / Cd05(i-1);
    dCd07(i-1) = (Cd07(i) - Cd07(i-1)) * 100 / Cd07(i-1);
end
for i=2:5    
    dCd09(i-1) = (Cd09(i) - Cd09(i-1)) * 100 / Cd09(i-1);
    dCd10(i-1) = (Cd10(i) - Cd10(i-1)) * 100 / Cd10(i-1);
    dCd11(i-1) = (Cd11(i) - Cd11(i-1)) * 100 / Cd11(i-1);
    dCd12(i-1) = (Cd12(i) - Cd12(i-1)) * 100 / Cd12(i-1);
    dCd14(i-1) = (Cd14(i) - Cd14(i-1)) * 100 / Cd14(i-1);
    dCd16(i-1) = (Cd16(i) - Cd16(i-1)) * 100 / Cd16(i-1);
    dCd18(i-1) = (Cd18(i) - Cd18(i-1)) * 100 / Cd18(i-1);
    dCd20(i-1) = (Cd20(i) - Cd20(i-1)) * 100 / Cd20(i-1);
    dCd25(i-1) = (Cd25(i) - Cd25(i-1)) * 100 / Cd25(i-1);
    dCd30(i-1) = (Cd30(i) - Cd30(i-1)) * 100 / Cd30(i-1);
    dCd35(i-1) = (Cd35(i) - Cd35(i-1)) * 100 / Cd35(i-1);
    dCd40(i-1) = (Cd40(i) - Cd40(i-1)) * 100 / Cd40(i-1);
end

dCells1 = Cells1(2:4);
dCells2 = Cells2(2:5);
dCells3 = Cells3(2:5);

dcells1 = dCells1(1):dCells1(3);
dcells2 = dCells2(1):dCells2(4);
dcells3 = dCells3(1):dCells3(4);

cd03 = pchip(Cells1,Cd03,cells1);
cd05 = pchip(Cells1,Cd05,cells1);
cd07 = pchip(Cells1,Cd07,cells1);
cd09 = pchip(Cells2,Cd09,cells2);
cd10 = pchip(Cells2,Cd10,cells2);
cd11 = pchip(Cells2,Cd11,cells2);
cd12 = pchip(Cells2,Cd12,cells2);
cd14 = pchip(Cells2,Cd14,cells2);
cd16 = pchip(Cells2,Cd16,cells2);
cd18 = pchip(Cells2,Cd18,cells2);
cd20 = pchip(Cells2,Cd20,cells2);
cd25 = pchip(Cells3,Cd25,cells3);
cd30 = pchip(Cells3,Cd30,cells3);
cd35 = pchip(Cells3,Cd35,cells3);
cd40 = pchip(Cells3,Cd40,cells3);

dcd03 = pchip(dCells1,dCd03,dcells1);
dcd05 = pchip(dCells1,dCd05,dcells1);
dcd07 = pchip(dCells1,dCd07,dcells1);
dcd09 = pchip(dCells2,dCd09,dcells2);
dcd10 = pchip(dCells2,dCd10,dcells2);
dcd11 = pchip(dCells2,dCd11,dcells2);
dcd12 = pchip(dCells2,dCd12,dcells2);
dcd14 = pchip(dCells2,dCd14,dcells2);
dcd16 = pchip(dCells2,dCd16,dcells2);
dcd18 = pchip(dCells2,dCd18,dcells2);
dcd20 = pchip(dCells2,dCd20,dcells2);
dcd25 = pchip(dCells3,dCd25,dcells3);
dcd30 = pchip(dCells3,dCd30,dcells3);
dcd35 = pchip(dCells3,dCd35,dcells3);
dcd40 = pchip(dCells3,dCd40,dcells3);


subplot(3,2,1);
plot(cells1,cd03,cells1,cd05,cells1,cd07); grid on;
xlabel('Number of contacting cells');
ylabel('C_D_0');
title('C_D_0 at different numbers of contacting cells');
legend('{\itMa} = 0.3','{\itMa} = 0.5','{\itMa} = 0.7');
axis([min(cells1) max(cells1) min(cd03) - 0.05 max(cd07) + 0.05]);

subplot(3,2,3);
plot(cells2,cd09,cells2,cd10,cells2,cd11,cells2,cd12,cells2,cd14,...
    cells2,cd16,cells2,cd18,cells2,cd20); grid on;
xlabel('Number of contacting cells');
ylabel('C_D_0');
title('C_D_0 at different numbers of contacting cells');
legend('{\itMa} = 0.9','{\itMa} = 1.0','{\itMa} = 1.1','{\itMa} = 1.2','{\itMa} = 1.4',...
    '{\itMa} = 1.6','{\itMa} = 1.8','{\itMa} = 2.0'); 
axis([min(cells2) max(cells2) min(cd09) - 0.05 max(cd11) + 0.05]);

subplot(3,2,5);
plot(cells3,cd25,cells3,cd30,cells3,cd35,cells3,cd40); grid on;
xlabel('Number of contacting cells');
ylabel('C_D_0');
title('C_D_0 at different numbers of contacting cells');
legend('{\itMa} = 2.5','{\itMa} = 3.0','{\itMa} = 3.5','{\itMa} = 4.0');
axis([min(cells3) max(cells3) min(cd40) - 0.05 max(cd25) + 0.05]);

subplot(3,2,2)
plot(dcells1,dcd03,dcells1,dcd05,dcells1,dcd07); grid on;
xlabel('Number of contacting cells');
ylabel('\DeltaC_D_0, %');
title('\DeltaC_D_0 at different numbers of contacting cells');
legend('{\itMa} = 0.3','{\itMa} = 0.5','{\itMa} = 0.7');
axis([min(dcells1) max(dcells1) min([dcd03,dcd05,dcd07]) - 0.005 max([dcd03,dcd05,dcd07]) + 0.005]);

subplot(3,2,4)
plot(dcells2,dcd09,dcells2,dcd10,dcells2,dcd11,dcells2,dcd12,dcells2,dcd14,...
    dcells2,dcd16,dcells2,dcd18,dcells2,dcd20); grid on;
xlabel('Number of contacting cells');
ylabel('\DeltaC_D_0, %');
title('\DeltaC_D_0 at different numbers of contacting cells');
legend('{\itMa} = 0.9','{\itMa} = 1.0','{\itMa} = 1.1','{\itMa} = 1.2','{\itMa} = 1.4',...
    '{\itMa} = 1.6','{\itMa} = 1.8','{\itMa} = 2.0');
axis([min(dcells2) max(dcells2) min([dcd09,dcd10,dcd11,dcd12,dcd14,dcd16,dcd18,dcd20]) - 0.005 max([dcd09,dcd10,dcd11,dcd12,dcd14,dcd16,dcd18,dcd20]) + 0.005]);

subplot(3,2,6)
plot(dcells3,dcd25,dcells3,dcd30,dcells3,dcd35,dcells3,dcd40); grid on;
xlabel('Number of contacting cells');
ylabel('\DeltaC_D_0, %');
title('\DeltaC_D_0 at different numbers of contacting cells');
legend('{\itMa} = 2.5','{\itMa} = 3.0','{\itMa} = 3.5','{\itMa} = 4.0');
axis([min(dcells3) max(dcells3) min([dcd25,dcd30,dcd35,dcd40]) - 0.005 max([dcd25,dcd30,dcd35,dcd40]) + 0.005]);

clc; clear;

Cells1 = [10234,17297,34050,59515];
Cells2 = [10234,17297,34050,59515,111752,211409,380141];
Cells3 = [17297,34050,59515,112634,204302,368034,666559];

cells1 = Cells1(1):Cells1(4);
cells2 = Cells2(1):Cells2(7);
cells3 = Cells3(1):Cells3(7);

Cd03 = [0.35766,0.379667,0.396643,0.390983];
Cd05 = [0.36755,0.390846,0.409916,0.40527];
Cd07 = [0.40312,0.418652,0.435671,0.430913];
Cd09 = [0.468717,0.486846,0.505751,0.512049,0.522508,0.537649,0.54496];
Cd10 = [0.610001,0.605418,0.653668,0.72112,0.726294,0.757583,0.768891];
Cd11 = [0.609256,0.607326,0.639818,0.644319,0.657889,0.711803,0.882938];
Cd12 = [0.679079,0.731573,0.791016,0.819357,0.843959,0.880104,0.910153];
Cd14 = [0.663717,0.707697,0.758621,0.790361,0.813652,0.846188,0.876173];
Cd16 = [0.627188,0.664843,0.712387,0.737972,0.760901,0.793723,0.812518];
Cd18 = [0.588992,0.622332,0.662968,0.687508,0.711868,0.750773,0.774398];
Cd20 = [0.555622,0.583185,0.623372,0.647391,0.675636,0.708492,0.769444];
Cd25 = [0.504934,0.528317,0.537813,0.554241,0.57444,0.591139,0.602187];
Cd30 = [0.440421,0.463046,0.471516,0.486136,0.506696,0.521781,0.534602];
Cd35 = [0.393291,0.414902,0.42436,0.4369,0.456561,0.472608,0.484685];
Cd40 = [0.359422,0.378459,0.388954,0.400336,0.418432,0.434654,0.447292];

dCd03 = zeros(1,3); dCd05 = dCd03; dCd07 = dCd05; dCd09 = dCd07; dCd10 = dCd09; dCd11 = dCd10; dCd12 = dCd11; dCd14 = dCd12;
dCd16 = dCd14; dCd18 = dCd16; dCd20 = dCd18; dCd25 = dCd20; dCd30 = dCd25; dCd35 = dCd30; dCd40 = dCd35;

for i=2:4
    dCd03(i-1) = (Cd03(i) - Cd03(i-1)) * 100 / Cd03(i-1);
    dCd05(i-1) = (Cd05(i) - Cd05(i-1)) * 100 / Cd05(i-1);
    dCd07(i-1) = (Cd07(i) - Cd07(i-1)) * 100 / Cd07(i-1);
end
for i=2:7    
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
dCells2 = Cells2(2:7);
dCells3 = Cells3(2:7);

dcells1 = dCells1(1):dCells1(3);
dcells2 = dCells2(1):dCells2(6);
dcells3 = dCells3(1):dCells3(6);

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

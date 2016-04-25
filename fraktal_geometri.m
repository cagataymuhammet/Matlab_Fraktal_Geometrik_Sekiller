clc;
fprintf('1 - kar tanesi\n');
fprintf('2 - tek yapraklý eðrelti otu\n');
fprintf('3 - L Fraktal Yapýsý\n');
fprintf('4 - carpet halý deseni\n');
fprintf('5 - eðrinin fraktalý\n');
fprintf('6 - sierpinski üçgeni\n');
fprintf('7 - ifs logosu\n');
fprintf('---------------------------\n');

try
sekil_no=input('çizmek istediðiniz fraktal þeklinin numarasýný giriniz : ');
catch
    display('hata');
end
fraktal_sekil_ciz(sekil_no,100000);





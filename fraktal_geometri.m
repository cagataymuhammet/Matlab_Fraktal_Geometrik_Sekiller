clc;
fprintf('1 - kar tanesi\n');
fprintf('2 - tek yaprakl� e�relti otu\n');
fprintf('3 - L Fraktal Yap�s�\n');
fprintf('4 - carpet hal� deseni\n');
fprintf('5 - e�rinin fraktal�\n');
fprintf('6 - sierpinski ��geni\n');
fprintf('7 - ifs logosu\n');
fprintf('---------------------------\n');

try
sekil_no=input('�izmek istedi�iniz fraktal �eklinin numaras�n� giriniz : ');
catch
    display('hata');
end
fraktal_sekil_ciz(sekil_no,100000);





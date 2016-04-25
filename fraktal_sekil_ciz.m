%% Fonksiyon http://www.massey.ac.nz/~ctuffley/fractals/ sitesinden alınıp uyarlanmıştır
%%%%%%% FONKSİYONUMUZ BURADA BAsLIYOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fraktal_sekil_ciz(sekil,max_interasyon_sayisi)

	varsayilan_interasyon_sayisi=10000;
	maximum_varsayilan_interasyon_sayisi=1000000;
	order=1;
	if (nargin==0) % eğer giriş parametrelerinin sayısı 0 ise ( yani parametreler boş girildi ise)
			
			parametreler =[ 0.95	0.95	0	 10	1	-1/2
						   1/4	-1/8	1	-40	0	 4.8 ];
					   
	elseif(sekil==1)

			x_buzulmesi = [ 1/3 1/3 0.35 0.35 1/3 ];
			y_buzulmesi = x_buzulmesi; %[ 0.25 0.25 0.4 0.4 0.25 0.25 ];
			aci = [ 0 0 60 -60 0  ];
			shear  = [ 0 0 0 0 0 ];
			cevirmeler = [ [0;0] [ 0; 1 ] [0; 2]  [ 0 ; 2] [0; 2]];
			parametreler = [ x_buzulmesi ; y_buzulmesi ; shear ; aci ; cevirmeler ]';
			order = 6;
			
	elseif(sekil==2)

			tilt = 5;
			stalk = 0.05;
			left = 0.3;
			right = 0.3;
			body =0.85;
			height = 1;
			x_buzulmesi = [ 0 -left right 0.95*body ];
			y_buzulmesi = [ 3.8*stalk left right body ];
			aci = [ 0 100 -85 tilt ];
			shear  = [ 0 0 0 0];
			cevirmeler = [ [0;0] [ 0; 1 ] [0; 1.3 ]  [ 0 ; 1.8 ]  ];
			parametreler = [ x_buzulmesi ;y_buzulmesi ; shear ;aci ;cevirmeler ]';
			
	elseif(sekil==3)
			
			parametreler=[
			1/2 	1/2	0	0	0	0
			1/2	1/2	0	0	-1	0
			1/2	1/2	0	90	0	2
			];

	elseif(sekil==4)

			parametreler = [
			1/3	1/3	0	0	0	0 
			1/3	1/3	0	0	2	0
			1/3	1/3	0	0	0	2
			1/3	1/3	0	0	2	2
			1/3	1/3	0	0	1       0
			1/3	1/3	0	0	0       1
			1/3	1/3	0	0	1       2
			1/3	1/3	0	0	2       1
			];
			
	elseif(sekil==5)
		
			parametreler =[
			0.95	0.95	0	 10	1	-1/2
			-1/8	-1/8	0	-40	0	4
			];
			
	elseif(sekil==5)
				
			parametreler=[
			0.66	0.66	0	40	0	1.5
			0.66	0.66	0	40	0	0
			];

	elseif(sekil==6)

			x_buzulmesi = [ 1/2 1/2 1/2];
			y_buzulmesi = x_buzulmesi;
			aci = [ 0 0 0 ];
			shear  = [ 0 0 0 ];
			cevirmeler = [ 0 0 ; 1/2 0 ; 1/2*cosd(60) 1/2*sind(60) ]';
			parametreler = [ x_buzulmesi ;y_buzulmesi ; shear ;aci ;cevirmeler ]';

	elseif(sekil==7)
		
			x_buzulmesi = [ 0.3 0.28 0.3 0.3 0.39 0.15 0.3 0.18 0.19 0.19 0.19 ];
			y_buzulmesi = [ 1/5 1/5  1/5 1/5 1/5  1/5  1/5 1/5 1/5 1/5 1/5];
			aci = [ 0   90   0   0   90   0    0   90  0   90   0];
			shear  = [ 0 0 0 0 0 0 0 0 0 0 0  ];
			cevirmeler = [ [0;0] [ 0.2 ; 0.11 ] [0;0.4] [0.35 ; 0.4 ] [ 0.45 ;0] [ 0.46 ; 0.2] [0.7; 0.4] [0.8;0.2] [ 0.81;0.2] [1;0] [0.7;0]];
			parametreler = [ x_buzulmesi ;y_buzulmesi ; shear ;aci ;cevirmeler ]';
			
	end

	
	if (nargin<2) % eğer sadece 1 tane parametre girildi ise yani şekil numarası tek girildi ise
		 max_interasyon_sayisi =varsayilan_interasyon_sayisi ;
	else
		 if ischar(max_interasyon_sayisi) %% interasyon sayısı yazı ise sayıya çevir
				max_interasyon_sayisi=str2num(max_interasyon_sayisi);
		 end
		 max_interasyon_sayisi = min(max_interasyon_sayisi,maximum_varsayilan_interasyon_sayisi); % burada yukarıda belirlediğimiz sabit değişkenler ile kıyaslama yapıp maximumu alıyoruz
	end


	[n,m]  = size(parametreler);
	if m<6
		error('girilen parametrenin sutun sayisi 6 dan kucuk olamaz.')
	elseif m>6
		warning('girilen parametrenin sutun sayisi 6 dan fazla olamaz.')
	end

	%%%%%%% BURAYA KADAR KONTROLLER VE sEKİLLER İcİN PARAMETRELER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


	x_buzulmesi = parametreler(:,1);
	y_buzulmesi = parametreler(:,2);
	shear  = parametreler(:,3);
	teta_acisi  = parametreler(:,4);
	shift  = [ parametreler(:,5)' ; parametreler(:,6)' ];

	if max(abs([x_buzulmesi ; y_buzulmesi])) >= 1
		   error('parametredeki değerler 1 ila -1 arasında olmalı')
	end

	Map = zeros(2,2,n);

	for i=1:n
		dondurme = [ cosd(teta_acisi(i)) -sind(teta_acisi(i)) ; sind(teta_acisi(i)) cosd(teta_acisi(i)) ];
		Shear    = [ 1 shear(i) ; 0 1 ];
		olcek    = [ x_buzulmesi(i) 0 ; 0 y_buzulmesi(i) ];
		Map(:,:,i) = dondurme*Shear*olcek;
	end


	d1=sprintf('\n%d tekrarlama ile %d tane interasyon uygulandi',n,max_interasyon_sayisi);
	disp(d1)

	detvec = abs(x_buzulmesi.*y_buzulmesi);
	tol = 0.25*min(detvec(detvec>0));
	detvec = detvec+tol;
	weights = detvec/sum(detvec)
	cweights = cumsum(weights);

	x = zeros(2,max_interasyon_sayisi);
	y = [0;0];

	for i = 1:100
	map = ornek_uret(cweights);
		 y = Map(:,:,map)*y + shift(:,map);
	end

	x(:,1) = y;

	for i = 2:max_interasyon_sayisi
	map = ornek_uret(cweights);
		 x(:,i) = Map(:,:,map)*x(:,i-1) + shift(:,map);
	end

	plot(x(1,:),x(2,:),'b.','MarkerSize',0.1)
	axis equal
	%axis off

	
	%Döndürme Simetrisi bu fonksiyon kar tanesi gibi şekillerde aynı şekli cevirerek yapıştırır
	order = floor(order);
	if order > 1
		aci = 360/order;
		rot = [ cosd(aci) -sind(aci) ; sind(aci) cosd(aci) ];
		hold on
		for i = 1:order
			x = rot*x;
			plot(x(1,:),x(2,:),'b.','MarkerSize',0.1)
		end
		hold off
	end
end

function uretilen = ornek_uret(cumweight)
     r = rand;
     uretilen = min(find(cumweight>r));
end
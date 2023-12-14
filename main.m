% Bulanık mantık sistemi oluşturuluyor
fis = newfis('restoranDolulukModeli');

% Girdi değişkenleri tanımlanıyor
fis = addvar(fis, 'input', 'musteriSayisi', [0 50]);
fis = addmf(fis, 'input', 1, 'Dusuk', 'gaussmf', [5 0]);
fis = addmf(fis, 'input', 1, 'Orta', 'gaussmf', [5 25]);
fis = addmf(fis, 'input', 1, 'Yuksek', 'gaussmf', [5 50]);

fis = addvar(fis, 'input', 'gununZamani', [0 24]);
fis = addmf(fis, 'input', 2, 'Sabah', 'trimf', [0 6 12]);
fis = addmf(fis, 'input', 2, 'Ogle', 'trimf', [10 12 14]);
fis = addmf(fis, 'input', 2, 'Aksam', 'trimf', [12 18 24]);

% Çıkış değişkeni tanımlanıyor
fis = addvar(fis, 'output', 'doluluk', [0 100]);
fis = addmf(fis, 'output', 1, 'Bos', 'trimf', [0 25 50]);
fis = addmf(fis, 'output', 1, 'Ortalama', 'trimf', [30 50 70]);
fis = addmf(fis, 'output', 1, 'Dolu', 'trimf', [50 75 100]);

% Kurallar tanımlanıyor
rules = [
    1 1 1 1 1;
    1 2 2 1 1;
    1 3 3 1 1;
    2 1 2 1 1;
    2 2 3 1 1;
    2 3 3 1 1;
    3 1 3 1 1;
    3 2 3 1 1;
    3 3 3 1 1;
];
fis = addrule(fis, rules);

% Sistemi değerlendiriyoruz
figure;
subplot(3,1,1), plotmf(fis, 'input', 1);
title('Müşteri Sayısı Üyelik Fonksiyonları');
subplot(3,1,2), plotmf(fis, 'input', 2);
title('Günün Zamanı Üyelik Fonksiyonları');
subplot(3,1,3), plotmf(fis, 'output', 1);
title('Doluluk Üyelik Fonksiyonları');

% Örnek girdi değerleriyle sistemi çalıştırıyoruz
input = [20 15]; % 20 müşteri, saat 15:00 (Öğleden sonra)
output = evalfis(fis, input);
disp(['Restorandaki Doluluk Oranı: ', num2str(output), '%']);

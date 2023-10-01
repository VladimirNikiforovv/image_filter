clc
clearvars
cla
close all

%% Работа с данными

% Загрузка изображения
imag = imread('4.jpg');

% выделение размеров
size_x = length(imag(:,1,1));

size_y = length(imag(1,:,1));

% выделение цветов
red = imag(1,1,1);

green = imag(1,1,2);

blue= imag(1,1,3);

%% Обьявление ядра свертки

% Ядра Гаусса
w = 1/16; % Для теории w = 1/16

KernelGauss = w.*[1 , 2, 1;
                  2 , 4, 2;
                  1 , 2, 1;];
%% Реализация свертки

ots = length(KernelGauss);

% Размытие по Гауссу
imag_gr = uint8(zeros(size_x,size_y,3));


% Цикл реализующий свертку с обрезанием по границы
for color = 1:3
    for u = 1:size_x
        for v = 1:size_y

            acum_X = 0;

            for i = 1:ots

                for j = 1:ots

                    if (u > ots && v > ots && u < size_x - ots && v < size_y - ots)

                        % Свертка по определению
                        acum_X = acum_X + imag(u - i , v - j, color) * KernelGauss(i, j);
                        
                    end
                end
            end

            % Величина с размытием
            imag_gr(u, v, color) = acum_X;

        end
    end
end



%% вывод изображения

% оригинал
figure(1)
image(imag);
hold off

% Величина с размытием
figure(2)
image(imag_gr); 
hold off

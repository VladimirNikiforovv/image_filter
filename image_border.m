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

% Ядра оператора Собеля и вес
w = 1/100; % Для теории w = 1

KernelSobelX = w.*[-1 , 0, 1;
                -2 , 0, 2;
                -1 , 0, 1;];

KernelSobelY  = w.*[-1, -2, -1;
                  0,  0,  0;
                  1,  2,  1;];

%% Реализация свертки

ots = length(KernelSobelX);

% Величина градиента
imag_gr = uint8(zeros(size_x,size_y,3));

% Направление градиента
teta = zeros(size_x,size_y,3);

% Цикл реализующий свертку с обрезанием по границы
for color = 1:3
    for u = 1:size_x
        for v = 1:size_y

            acum_X = 0;

            for i = 1:ots

                for j = 1:ots

                    if (u > ots && v > ots && u < size_x - ots && v < size_y - ots)

                        % Свертка по определению
                        acum_X = acum_X + imag(u - i , v - j, color) * KernelSobelX(i, j);
                        
                    end
                end
            end

            acum_Y = 0;

            for i = 1:ots

                for j = 1:ots

                    if (u > ots && v > ots && u < size_x - ots && v < size_y - ots)
                        
                        % Свертка по определению
                        acum_Y = acum_Y + imag(u - i , v - j, color) * KernelSobelY(i, j);

                    end
                end
            end

            % Величина градиента
            imag_gr(u, v, color) = (acum_X ^ 2 + acum_Y ^ 2) ^ 1/2;

            % Направление градиента
            teta(u, v, color) = atan2(double(acum_X^2), double(acum_Y^2));

        end
    end
end



%% вывод границ изображения

% оригинал
figure(1)
image(imag);
hold off

% Величина градиента
figure(2)
mesh(imag_gr(:,:,2)); 
hold off

% Направление градиента
figure(3)
mesh(teta(:,:,2)); 
hold off

% Величина градиента
figure(4)
image(imag_gr); 
hold off

% Направление градиента
figure(5)
image(teta); 
hold off
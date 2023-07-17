SELECT * FROM cars;

-- 1. Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE VIEW cars1 AS
SELECT * FROM cars
WHERE cost <= 25000;

SELECT * FROM cars1;

-- 2.Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW cars1 AS
SELECT * FROM cars
WHERE cost <= 30000;

SELECT * FROM cars1;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW cars3 AS
SELECT * FROM cars
WHERE name IN ('Skoda', 'Audi');

SELECT * FROM cars3;

-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

SELECT a.an_name, a.an_price
FROM Analysis a
JOIN Orders o
ON a.an_id = o.ord_an
WHERE o.ord_datetime BETWEEN '2023-02-05' AND '2023-02-12';

/*
Добавьте новый столбец под названием «время до следующей станции». Чтобы получить это значение, 
мы вычитаем время станций для пар смежных станций. Мы можем вычислить это значение без использования
оконной функции SQL, но это может быть очень сложно. 
Проще это сделать с помощью оконной функции LEAD. 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/

SELECT train_id, station, station_time
SUBTIME(LEAD(station_time) OVER(PARTITION BY train_id ORDER BY station_time), station_time) AS time_to_next_station
FROM trains;

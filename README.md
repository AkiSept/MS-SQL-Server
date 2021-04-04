# Работа с MS SQL Server

В базе следующие сущности:
1)	Agents - Агенты
2)	Goods – Товары
3)	GoodPrices – Изменение цены товара со временем
4)	Orders – Заказы
5)	OrderDetails - Детализация заказа  

Задания_1_a.sql - Заполнить таблицы агентов, товаров  произвольными значениями

Задание_1_b.sql - Заполнить таблицы заказов и детализации заказов: 
Условия:
1. Количество заказов для каждого агента в диапазоне от 10 до 40;
2. Дата создания заказа от 01.01.2018 до 31.03.2020;
3. Для каждого заказа 1-5 строчек детализации, ссылающихся на разные товары ( в одном заказе только один раз встречается товар);
4. Количество товара в заказе от 1 до 10.

Задание_1_c.sql - Заполнить таблицу с изменением цены. У каждого товара от 2-х изменений цен и произвольная дата

Задание_2_3.sql - 
1. Список товаров без цена на заданную дату  
2. Список товаров, у кторых есть пересечение действия цен  
3. Список агентов, количество заказов которых в указанных год больше 10  
4. Список агентов и информации от последней заказе Агент/Дата заказа/ Сумма заказа  
5. Список количество товаров купленныз помесячно за определенны период  
Пример:   
Дата		Наименование Кол-во в месяце	Итог  
31.01.2020	 Товар1 		2		2  
29.02.2020	 Товар1		3		5  


/* Задания 2*/
/* a)	Список товаров, у которых на заданную дату не задана цена. */
DECLARE @Date date = '2019-01-01'
SELECT Goods.Name
FROM Goods WHERE NOT Goods.Id IN (SELECT GoodPrices.GoodId FROM GoodPrices 
WHERE GoodPrices.Bdate <= @Date AND GoodPrices.Edate >= @Date);


/* b)	Проверка корректности заведённых данных: 
		у каждого товара на любом периоде должна быть задана только одна цена. 
		Вывести товары, у которых есть пересечение периодов действия цен.*/
WITH Price AS
(
SELECT GP1.*
FROM GoodPrices GP1 
	JOIN GoodPrices GP2 ON GP1.GoodId = GP2.GoodId
		AND GP1.Bdate <= GP2.Edate
		AND GP1.Edate >= GP2.Bdate
		AND GP1.id != GP2.id
)

SELECT Goods.Name
FROM Goods JOIN Price ON Price.GoodId = Goods.Id
GROUP BY Goods.Name;


/*c)	Список агентов, количество заказов которых за 2019 год более 10.*/
SELECT Agents.Name, COUNT(*) as [Количество заказов]
FROM Agents
	JOIN Orders ON Agents.Id = Orders.AgentId
	WHERE  YEAR(Orders.CreateDate) = 2019
GROUP BY
	Agents.Name
HAVING COUNT(*) > 10;


/* d)	Список агентов с информацией о последнем заказе: Агент / Дата заказа / сумма заказа */

/* Получить последние заказы агента */
WITH OrdersInfo AS
(
SELECT Ord.id, Age.Name, Ord.CreateDate
FROM Agents AS Age LEFT JOIN Orders AS Ord ON Age.Id = Ord.AgentId 
AND Ord.Id = (SELECT TOP 1 id
        FROM Orders
        WHERE Orders.AgentId = Age.Id
        ORDER BY CreateDate DESC, id DESC) 
)

SELECT OrdersInfo.Name, OrdersInfo.CreateDate,  SUM(Detail.GoodCount * GoodPrices.Price) AS Summ
FROM  OrdersInfo  
LEFT JOIN OrderDetails AS Detail ON OrdersInfo.Id = Detail.OrderId
LEFT JOIN Goods ON Detail.GoodId = Goods.Id
LEFT JOIN GoodPrices ON GoodPrices.GoodId = Goods.Id
WHERE OrdersInfo.CreateDate BETWEEN  GoodPrices.Bdate AND GoodPrices.Edate
GROUP BY OrdersInfo.Name, OrdersInfo.CreateDate;


/* Задание 3.	Вывести количество купленных товаров накопительным итогом помесячно за период с 01.01.2020 по 31.03.2020. */
DECLARE @FromDate date = '2020-01-01';
DECLARE @ToDate date = '2020-03-01';

WITH DetailOrder AS
(
	SELECT EOMONTH(Orders.CreateDate) AS DayMounth, OrderDetails.GoodId, Sum(OrderDetails.GoodCount) AS CountMounth/*, Sum(CountMounth)*/
	FROM OrderDetails
	LEFT JOIN Orders ON Orders.Id = OrderDetails.OrderId
	WHERE Orders.CreateDate BETWEEN  @FromDate AND EOMONTH(@ToDate)
	GROUP BY OrderDetails.GoodId, EOMONTH(Orders.CreateDate)
),
GoodOrder AS
(
SELECT DetailOrder.DayMounth, Goods.Id, Goods.Name, DetailOrder.CountMounth, Sum(DetailOrder.CountMounth) AS Result FROM DetailOrder 
LEFT JOIN Goods ON Goods.Id = DetailOrder.GoodId
GROUP BY DetailOrder.DayMounth, Goods.Name, DetailOrder.CountMounth, Goods.Id 
)

SELECT Ord1.DayMounth, Ord1.Name, Ord1.CountMounth, SUM(Ord2.CountMounth) AS Result
FROM GoodOrder AS Ord1
  JOIN GoodOrder AS Ord2 ON Ord2.Name = Ord1.Name AND Ord2.DayMounth <= Ord1.DayMounth
GROUP BY Ord1.Name, Ord1.Id, Ord1.CountMounth, Ord1.DayMounth
ORDER BY Ord1.Name, Ord1.DayMounth

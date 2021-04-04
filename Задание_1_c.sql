
/* c)	Заполнить таблицу с изменением цены*/
DECLARE @FromDate date = '2018-01-01', /* Дата заказа - от */
		@ToDate date = '2019-12-31', /* Дата заказа - до */
		@AddDate int = 3, /* Добавить n месяцев, для даты окончания цены */
		@BeginDate date, /* Дата начала цены */
		@EndDate date, /* Дата окончания цены */
		@Price money,
		@Counter int = 1, /* Счетчик для товаров */
		@CounterPrice int /* Счетчик для цен - количество изменений цен */
		
 WHILE @Counter <= 10
	BEGIN
		SET @CounterPrice = 1
		WHILE @CounterPrice <= 3
			BEGIN
				SET @BeginDate = dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate);
				SET @EndDate = dateadd(month, @AddDate, @BeginDate); 
				SET @Price = (SELECT FLOOR(RAND()*(100-10)+10));
				INSERT INTO GoodPrices(GoodId, Price, Bdate, Edate) VALUES (@Counter, @Price, @BeginDate, @EndDate);
				SET @CounterPrice = @CounterPrice + 1
			END;
		SET @Counter = @Counter + 1
	END;
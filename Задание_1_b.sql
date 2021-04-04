
/* Создать процедуру   */ 
CREATE PROCEDURE AddOrder
	@ID INT
AS
/* Случайное число записей от 10 до 40 */
DECLARE @upper INT = 40, 
		@lower INT = 10,
		@number INT
SET @number = (SELECT FLOOR(RAND()*(@upper-@lower)+@lower));
PRINT 'Количество заказов агента ' + CAST(@number AS varchar);

/* Определение переменных */
DECLARE	@Good table(value int) /* Табличная переменная для id товаров чтобы не повторялись товары*/
DECLARE @FromDate date = '2018-01-01', /* Дата заказа - от */
		@ToDate date = '2020-03-31', /* Дата заказа - до */
		@RandDate date /* Дата заказа*/
DECLARE @Up INT = 5, /* Количество деталей заказа - до */
		@Low INT = 1, /* Количество деталей заказа - от */
		@Num INT /* Количество деталей заказа */
DECLARE @OrderID INT /* Id заказа*/
DECLARE @GoodID INT /* Id товара*/
DECLARE @GoodCount INT, /* Количество товара */
		@UpperCount INT = 10, /* Количество товара - до */
		@LowerCount INT = 1 /* Количество товара - от */
/* Создать заказы */
 WHILE @number > 0
	BEGIN
		/* Список товаров*/
		insert into @Good(value) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)
		/* Случайная дата от от 01.01.2018 до 31.03.2020 */
		/*SET @rdate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 364 ), '2018-01-01');*/
		SET @RandDate = dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate);
		PRINT 'Дата заказа ' + CAST(@RandDate AS varchar)

		INSERT INTO Orders(AgentId,CreateDate) VALUES (@ID, @RandDate);
		/* Создать детали заказа */
		/* Случайное количество записей таблицы OrderDetails от 1 до 5 */ 
		SET @Num = (SELECT FLOOR(RAND()*(@Up-@Low)+@Low));
		PRINT 'Количество деталей заказа ' + CAST(@Num AS varchar)

		WHILE @Num > 0
			BEGIN
				SET @OrderID = (SELECT TOP 1 id FROM Orders ORDER BY id DESC);
				/* Случайное товары для заказа */ 
				SET @GoodID = (SELECT TOP 1 value FROM @Good ORDER BY newid());
				PRINT 'ID товара ' + CAST(@GoodID AS varchar)
				DELETE @Good WHERE value=@GoodID

				/* Случайное количество товара от 1 до 10 */
				SET @GoodCount = (SELECT FLOOR(RAND()*(@UpperCount-@LowerCount)+@LowerCount));
				PRINT 'Количество товара ' + CAST(@GoodCount AS varchar)
					
				INSERT INTO OrderDetails(OrderId, GoodId, GoodCount) VALUES (@OrderID, @GoodID, @GoodCount);
				SET @Num = @Num - 1
			END;
		DELETE FROM @Good
		SET @number = @number - 1
	END;

/* Вызвать процедуру для каждого агента - Передавать параметр id агента*/
/*EXEC AddOrder 6*/

/*SELECT * FROM OrderDetails*/

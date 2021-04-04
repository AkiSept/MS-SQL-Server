
/* ������� ���������   */ 
CREATE PROCEDURE AddOrder
	@ID INT
AS
/* ��������� ����� ������� �� 10 �� 40 */
DECLARE @upper INT = 40, 
		@lower INT = 10,
		@number INT
SET @number = (SELECT FLOOR(RAND()*(@upper-@lower)+@lower));
PRINT '���������� ������� ������ ' + CAST(@number AS varchar);

/* ����������� ���������� */
DECLARE	@Good table(value int) /* ��������� ���������� ��� id ������� ����� �� ����������� ������*/
DECLARE @FromDate date = '2018-01-01', /* ���� ������ - �� */
		@ToDate date = '2020-03-31', /* ���� ������ - �� */
		@RandDate date /* ���� ������*/
DECLARE @Up INT = 5, /* ���������� ������� ������ - �� */
		@Low INT = 1, /* ���������� ������� ������ - �� */
		@Num INT /* ���������� ������� ������ */
DECLARE @OrderID INT /* Id ������*/
DECLARE @GoodID INT /* Id ������*/
DECLARE @GoodCount INT, /* ���������� ������ */
		@UpperCount INT = 10, /* ���������� ������ - �� */
		@LowerCount INT = 1 /* ���������� ������ - �� */
/* ������� ������ */
 WHILE @number > 0
	BEGIN
		/* ������ �������*/
		insert into @Good(value) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)
		/* ��������� ���� �� �� 01.01.2018 �� 31.03.2020 */
		/*SET @rdate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 364 ), '2018-01-01');*/
		SET @RandDate = dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate);
		PRINT '���� ������ ' + CAST(@RandDate AS varchar)

		INSERT INTO Orders(AgentId,CreateDate) VALUES (@ID, @RandDate);
		/* ������� ������ ������ */
		/* ��������� ���������� ������� ������� OrderDetails �� 1 �� 5 */ 
		SET @Num = (SELECT FLOOR(RAND()*(@Up-@Low)+@Low));
		PRINT '���������� ������� ������ ' + CAST(@Num AS varchar)

		WHILE @Num > 0
			BEGIN
				SET @OrderID = (SELECT TOP 1 id FROM Orders ORDER BY id DESC);
				/* ��������� ������ ��� ������ */ 
				SET @GoodID = (SELECT TOP 1 value FROM @Good ORDER BY newid());
				PRINT 'ID ������ ' + CAST(@GoodID AS varchar)
				DELETE @Good WHERE value=@GoodID

				/* ��������� ���������� ������ �� 1 �� 10 */
				SET @GoodCount = (SELECT FLOOR(RAND()*(@UpperCount-@LowerCount)+@LowerCount));
				PRINT '���������� ������ ' + CAST(@GoodCount AS varchar)
					
				INSERT INTO OrderDetails(OrderId, GoodId, GoodCount) VALUES (@OrderID, @GoodID, @GoodCount);
				SET @Num = @Num - 1
			END;
		DELETE FROM @Good
		SET @number = @number - 1
	END;

/* ������� ��������� ��� ������� ������ - ���������� �������� id ������*/
/*EXEC AddOrder 6*/

/*SELECT * FROM OrderDetails*/

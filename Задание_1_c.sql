
/* c)	��������� ������� � ���������� ����*/
DECLARE @FromDate date = '2018-01-01', /* ���� ������ - �� */
		@ToDate date = '2019-12-31', /* ���� ������ - �� */
		@AddDate int = 3, /* �������� n �������, ��� ���� ��������� ���� */
		@BeginDate date, /* ���� ������ ���� */
		@EndDate date, /* ���� ��������� ���� */
		@Price money,
		@Counter int = 1, /* ������� ��� ������� */
		@CounterPrice int /* ������� ��� ��� - ���������� ��������� ��� */
		
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
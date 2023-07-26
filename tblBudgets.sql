SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BudgetHistory](
	[CurrentSpend] [smallmoney] NOT NULL,
	[Date] [datetime] NULL,
	[BudgetFK] [int] NULL,
 CONSTRAINT [unq_BudgetHistory_BudgetFK] UNIQUE NONCLUSTERED 
(
	[BudgetFK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[BudgetHistory] ADD  DEFAULT (getdate()) FOR [Date]
GO

CREATE TABLE [dbo].[Budgets](
	[PK] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[ID] [nvarchar](max) NOT NULL,
	[Category] [varchar](25) NOT NULL,
	[Amount] [money] NULL,
	[CurrentSpend] [money] NULL,
	[TimeGrain] [varchar](25) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [pk_Budgets] PRIMARY KEY CLUSTERED 
(
	[PK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Budgets] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[Budgets]  WITH CHECK ADD  CONSTRAINT [fk_Budgets_BudgetHistory] FOREIGN KEY([PK])
REFERENCES [dbo].[BudgetHistory] ([BudgetFK])
GO

ALTER TABLE [dbo].[Budgets] CHECK CONSTRAINT [fk_Budgets_BudgetHistory]
GO


CREATE OR ALTER   PROC [dbo].[usp_InsertBudget]
(
@Name as nvarchar(max) = Null,
@Id as nvarchar(max) = Null,
@Category as nvarchar(max) = Null,
@Amount as nvarchar(max) = Null,
@CurrentSpend as nvarchar(max) = Null,
@TimeGrain as nvarchar(max) = Null,
@StartDate as nvarchar(max) = Null,
@EndDate as nvarchar(max) = Null
)
AS

BEGIN

    SET NOCOUNT ON;
	SET XACT_ABORT ON;

	DECLARE @BudgetId INT

	IF EXISTS (SELECT 1 FROM [Budgets] WHERE Id = @Id)
		BEGIN
			UPDATE [Budgets] SET
				Name = @Name,
				Id = @Id,
				Category = @Category,
				Amount = @Amount,
				CurrentSpend = @CurrentSpend,
				TimeGrain = @TimeGrain,
				StartDate = @StartDate,
				EndDate = @EndDate
			SET @BudgetId = SCOPE_IDENTITY()

			INSERT INTO [BudgetHistory]	(CurrentSpend, BudgetFK) VALUES (@CurrentSpend, @BudgetId);
		END

	ELSE
		BEGIN
			INSERT INTO [Budgets]
				(Name, Id, Category, Amount, CurrentSpend, TimeGrain, StartDate, EndDate)
			VALUES
				(@Name, @Id, @Category, @Amount, @CurrentSpend, @TimeGrain, @StartDate, @EndDate)
			SET @BudgetId = SCOPE_IDENTITY()

			INSERT INTO [BudgetHistory]	(CurrentSpend, BudgetFK) VALUES (@CurrentSpend, @BudgetId);
		END
	END
GO

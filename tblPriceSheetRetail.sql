SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PricesheetRetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ArmRegionName] [nvarchar](50) NULL,
	[ArmSkuName] [nvarchar](max) NULL,
	[CurrencyCode] [nvarchar](5) NULL,
	[EffectiveStartDate] [date] NULL,
	[EffectiveEndDate] [date] NULL,
	[Location] [nvarchar](50) NULL,
	[TierMinimumUnits] [float] NULL,
	[RetailPrice] [money] NULL,
	[UnitPrice] [money] NULL,
	[ReservationTerm] [nvarchar](15) NULL,
	[MeterId] [nvarchar](75) NOT NULL,
	[MeterName] [nvarchar](max) NOT NULL,
	[ProductId] [nvarchar](150) NULL,
	[ProductName] [nvarchar](150) NULL,
	[ServiceName] [nvarchar](150) NULL,
	[ServiceId] [nvarchar](150) NULL,
	[ServiceFamily] [nvarchar](150) NULL,
	[SkuId] [nvarchar](150) NULL,
	[SkuName] [nvarchar](max) NULL,
	[SavingsPlan] [nvarchar](max) NULL,
	[UnitOfMeasure] [nvarchar](150) NULL,
	[Type] [nvarchar](150) NULL,
	[IsPrimaryMeterRegion] [nvarchar](150) NULL,
	[StartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[EndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([StartTime], [EndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[PricesheetRetail_History])
)
GO

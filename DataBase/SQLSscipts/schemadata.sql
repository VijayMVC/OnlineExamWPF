USE [OnlineExam]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculatePersianDate]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[CalculatePersianDate] ( @intDate DATETIME )
RETURNS NVARCHAR(max)
BEGIN

DECLARE @shYear AS INT ,@shMonth AS INT ,@shDay AS INT ,@intYY AS INT ,@intMM AS INT ,@intDD AS INT ,@Kabiseh1 AS INT ,@Kabiseh2 AS INT ,@d1 AS INT ,@m1 AS INT, @shMaah AS NVARCHAR(max),@shRooz AS NVARCHAR(max),@DayCnt AS INT
DECLARE @DayDate AS NVARCHAR(max)

SET @intYY = DATEPART(yyyy, @intDate)

IF @intYY < 1000 SET @intYY = @intYY + 2000

SET @intMM = MONTH(@intDate)
SET @intDD = DAY(@intDate)
SET @shYear = @intYY - 622
SET @DayCnt = 5

IF ( ( @intYY - 1992 ) % 4 = 0) SET @Kabiseh1 = 0 ELSE SET @Kabiseh1 = 1

IF ( ( @shYear - 1371 ) % 4 = 0) SET @Kabiseh2 = 0 ELSE SET @Kabiseh2 = 1

SET @m1 = 1
SET @d1 = 1
SET @shMonth = 10
SET @shDay = 11

IF ( ( @intYY - 1993 ) % 4 = 0 ) SET @shDay = 12


WHILE ( @m1 != @intMM ) OR ( @d1 != @intDD )
BEGIN

  SET @d1 = @d1 + 1
  SET @DayCnt = @DayCnt + 1

  IF 
  (@d1 = 32 AND (@m1 = 1 OR @m1 = 3 OR @m1 = 5 OR @m1 = 7 OR @m1 = 8 OR @m1 = 10 OR @m1 = 12))
  OR
  (@d1 = 31 AND (@m1 = 4 OR @m1 = 6 OR @m1 = 9 OR @m1 = 11))
  OR
  (@d1 = 30 AND @m1 = 2 AND @Kabiseh1 = 1)
  OR
  (@d1 = 29 AND @m1 = 2 AND @Kabiseh1 = 0)
  BEGIN
    SET @m1 = @m1 + 1
    SET @d1 = 1
  END

  IF @m1 > 12
  BEGIN
    SET @intYY = @intYY + 1
    SET @m1 = 1
  END

  IF @DayCnt > 7 SET @DayCnt = 1

 SET @shDay = @shDay + 1

  IF
  (@shDay = 32 AND @shMonth < 7)
  OR
  (@shDay = 31 AND @shMonth > 6 AND @shMonth < 12)
  OR
  (@shDay = 31 AND @shMonth = 12 AND @Kabiseh2 = 1)
  OR
  (@shDay = 30 AND @shMonth = 12 AND @Kabiseh2 = 0)
  BEGIN
    SET @shMonth = @shMonth + 1
    SET @shDay = 1
  END

  IF @shMonth > 12
  BEGIN
    SET @shYear = @shYear + 1
    SET @shMonth = 1
  END

END

IF @shMonth=1 SET @shMaah=N'فروردین'
IF @shMonth=2 SET @shMaah=N'اردیبهشت'
IF @shMonth=3 SET @shMaah=N'خرداد'
IF @shMonth=4 SET @shMaah=N'تیر'
IF @shMonth=5 SET @shMaah=N'مرداد'
IF @shMonth=6 SET @shMaah=N'شهریور'
IF @shMonth=7 SET @shMaah=N'مهر'
IF @shMonth=8 SET @shMaah=N'آبان'
IF @shMonth=9 SET @shMaah=N'آذر'
IF @shMonth=10 SET @shMaah=N'دی'
IF @shMonth=11 SET @shMaah=N'بهمن'
IF @shMonth=12 SET @shMaah=N'اسفند'

IF @DayCnt=1 SET @shRooz=N'شنبه'
IF @DayCnt=2 SET @shRooz=N'یکشنبه'
IF @DayCnt=3 SET @shRooz=N'دوشنبه'
IF @DayCnt=4 SET @shRooz=N'سه‌شنبه'
IF @DayCnt=5 SET @shRooz=N'چهارشنبه'
IF @DayCnt=6 SET @shRooz=N'پنجشنبه'
IF @DayCnt=7 SET @shRooz=N'جمعه'

--SET @DayDate = @shRooz + " " + LTRIM(STR(@shDay,2)) + " " + @shMaah + " " + STR(@shYear,4)
--پنجشنبه 17 اردیبهشت 1394

/*
SET @DayDate = LTRIM(STR(@shDay,2)) + " " + @shMaah + " " + STR(@shYear,4)
--17 اردیبهشت 1394

SET @DayDate = STR(@shYear,4) + "/"+LTRIM(STR(@shMonth,2)) + "/" + LTRIM(STR(@shDay,2))
--1394/2/17


--1394/02/17
*/
SET @DayDate = REPLACE(RIGHT(STR(@shYear, 4), 4), ' ', '0') + '/'+ REPLACE(STR(@shMonth, 2), ' ', '0') + '/' + REPLACE(( STR(@shDay,2) ), ' ', '0')
RETURN @DayDate
END
GO
/****** Object:  UserDefinedFunction [dbo].[CreateStoreProcedure]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CreateStoreProcedure] (@input nVARCHAR(250),@input1 nvarchar(250))
RETURNS nVARCHAR(max)
AS BEGIN
declare @TableName sysname = @input
declare @storename sysname= @input1
declare @Result varchar(max) = 'public MessageDataBase Insert'+@TableName +'StoreProcedure(' + @TableName +' '+ lower(@TableName) + ')
{
	SQLDataBaseOperation operation = new SQLDataBaseOperation(); 
	List<SqlParameter> listParams = new List<SqlParameter>();
	' 
select @Result = @Result + '	listParams.Add(new SqlParameter("@' + Column_Name + '",'+LOWER(@TableName) + '.'+  Column_Name+'));
'
from
(
select COLUMN_NAME,ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION<>1

)t 
order by ORDINAL_POSITION
SET @Result = LEFT(@Result, LEN(@Result) - 1) 

set @Result = @Result +'	MessageDataBase result=operation.RunStoreProcedure("'+@storename+'",listParams);

	return result;
}'


    RETURN @Result

END
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateAllCommand]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateAllCommand] (@input VARCHAR(max))
RETURNS VARCHAR(max)
AS BEGIN
	Declare @Result nvarchar(max)=[dbo].[GenerateInsertCommand](@input)+'
	'
	Set @Result=@Result+[dbo].[GenerateUpdateCommand](@input)+'
	'
	Set @Result=@Result+[dbo].[GenerateDeleteCommand](@input)

    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateDeleteCommand]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateDeleteCommand] (@input VARCHAR(max))
RETURNS VARCHAR(max)
AS BEGIN
declare @TableName sysname = @input
declare @Result varchar(max) = 'public MessageDataBase Delete'+@TableName +'(' + @TableName +' '+ lower(@TableName) + ')
{
	string sql=string.Format("delete from ' + @TableName +' Where '
	select @Result = @Result + '[' + Column_Name + ']'+'={0}"'
from
(
	select COLUMN_NAME,ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION=1
)t 
order by ORDINAL_POSITION

select @Result = @Result +',' + lower(@TableName) +'.'+ Column_Name
from
(
	select COLUMN_NAME,ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION=1
)t 

SET @Result = @Result + ');'
SET @Result = @Result + '
	MessageDataBase message = operation.DeleteCommand(sql);
    return message;
}'


    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateInsertCommand]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateInsertCommand] (@input VARCHAR(max))
RETURNS VARCHAR(max)
AS BEGIN
declare @TableName sysname = @input
declare @Result varchar(max) = 'public MessageDataBase Insert'+@TableName +'(' + @TableName +' '+ lower(@TableName) + ')
{
	string sql=string.Format("Insert Into ' + @TableName + '('
select @Result = @Result + '[' + Column_Name + ']'+ ',' 
from
(
select COLUMN_NAME,ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION<>1

)t 
order by ORDINAL_POSITION
SET @Result = LEFT(@Result, LEN(@Result) - 1) 

set @Result = @Result +') Values ('

--select @Result = @Result + '''{'+ cast(ColumnId-1 as nvarchar(2)) + '}'','
select @Result=@Result+  NullableSign
from
( 
	select COLUMN_NAME,ORDINAL_POSITION,	
       case 
           when DATA_TYPE in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
           then '{'+ cast((ORDINAL_POSITION-2) as nvarchar(2) ) +'},' 
           else '''{'+ cast((ORDINAL_POSITION-2) as nvarchar(2) ) +'}'',' 
       end NullableSign
    FROM INFORMATION_SCHEMA.COLUMNS 

    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION<>1
) t
order by ORDINAL_POSITION

SET @Result = LEFT(@Result, LEN(@Result) - 1)
set @Result = @Result +')" , ';

select @Result = @Result +lower(@TableName)+'.'+  COLUMN_NAME + ','

from
(
select COLUMN_NAME,ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION<>1

)t 
order by ORDINAL_POSITION

SET @Result = LEFT(@Result, LEN(@Result) - 1)
SET @Result = @Result + ');'
SET @Result = @Result + '
	MessageDataBase message = operation.InsertCommand(sql);
    return message;
}'

    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateUpdateCommand]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateUpdateCommand] (@input VARCHAR(max))
RETURNS VARCHAR(max)
AS BEGIN
declare @TableName sysname = @input
declare @Result varchar(max) = 'public MessageDataBase Update'+@TableName +'(' + @TableName +' '+ lower(@TableName) + ')
{
	string sql=string.Format("update ' + @TableName + ' Set  ' select @Result = @Result + '[' + Column_Name + ']'+'='+ NullableSign  
from
(
	select COLUMN_NAME,ORDINAL_POSITION,	
       case 
           when DATA_TYPE in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
           then '{'+ cast((ORDINAL_POSITION-2) as nvarchar(2) ) +'},' 
           else '''{'+ cast((ORDINAL_POSITION-2) as nvarchar(2) ) +'}'',' 
       end NullableSign
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION<>1
)t 
order by ORDINAL_POSITION

Declare @RowCount1 int;
select @RowCount1=
(
	select 	count(COLUMN_NAME) from INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @TableName
) 

SET @Result = LEFT(@Result, LEN(@Result) - 1)

select @Result = @Result +  ' Where ' + Column_Name +'={' + cast(@RowCount1-1 as nvarchar(2)) +'}'
from
(
	select COLUMN_NAME,ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION=1
)t 
SET @Result = @Result + '",'

select @Result = @Result +  lower(@TableName) +'.' + Column_Name +','
from
(
	select COLUMN_NAME,ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION<>1
)t 
order by ORDINAL_POSITION

select @Result = @Result +lower(@TableName)+'.' + Column_Name 
from
(
	select COLUMN_NAME,ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION=1
)t 

SET @Result = @Result + ');'
SET @Result = @Result + '
	MessageDataBase message = operation.UpdateCommand(sql);
    return message;
}'

    RETURN @Result
END
GO
/****** Object:  Table [dbo].[Chapter]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapter](
	[ChapterID] [int] IDENTITY(1,1) NOT NULL,
	[ChapterNo] [int] NULL,
	[ChapterTitle] [nvarchar](300) NULL,
	[LessonID] [int] NULL,
	[Description] [nvarchar](1000) NULL,
	[IsDisabled] [bit] NULL,
 CONSTRAINT [PK_Poodman] PRIMARY KEY CLUSTERED 
(
	[ChapterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contest]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contest](
	[ContestID] [int] IDENTITY(1,1) NOT NULL,
	[ExamID] [int] NULL,
	[ContestText] [nvarchar](1000) NULL,
	[StudentID] [int] NULL,
	[IsDisabled] [bit] NULL,
	[RegisterDate] [datetime2](7) NULL,
	[IsTeacherResponse] [bit] NULL,
	[TeacherResponse] [nvarchar](1000) NULL,
	[DesingerID] [int] NULL,
 CONSTRAINT [PK_Contest] PRIMARY KEY CLUSTERED 
(
	[ContestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
	[IsDisabled] [bit] NULL,
 CONSTRAINT [PK_Feild] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Designer]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designer](
	[DesignerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CodeMeli] [nvarchar](10) NULL,
	[Official] [nvarchar](100) NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Mobile] [nvarchar](12) NULL,
	[Email] [nvarchar](100) NULL,
	[IsDisabled] [bit] NULL,
	[RegisterDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Designer] PRIMARY KEY CLUSTERED 
(
	[DesignerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ExamID] [int] IDENTITY(1,1) NOT NULL,
	[ExamName] [nvarchar](200) NULL,
	[Level] [nvarchar](20) NULL,
	[ChapterID] [int] NULL,
	[Date] [date] NULL,
	[Duration] [int] NULL,
	[StartTime] [time](7) NULL,
	[QuestionType] [nvarchar](30) NULL,
	[ExamType] [nvarchar](30) NULL,
	[SupervisorName] [nvarchar](30) NULL,
	[RepeatTestCount] [int] NULL,
	[OptionalQuestionCount] [int] NULL,
	[OptionalQuestionScore] [float] NULL,
	[DescriptionQuestionCount] [int] NULL,
	[DescriptionQuestionScore] [float] NULL,
	[BlankQuestionCount] [int] NULL,
	[BlankQuestionScore] [float] NULL,
	[TrueFalseQuestionCount] [int] NULL,
	[TrueFalseQuestionScore] [float] NULL,
	[PracticalQuestionCount] [int] NULL,
	[PracticalQuestionScore] [float] NULL,
	[TotalScore] [float] NULL,
	[Status] [nvarchar](30) NULL,
	[Difficulty] [nvarchar](20) NULL,
	[StartDate] [datetime2](7) NULL,
	[DelayTime] [int] NULL,
	[IsDisabled] [bit] NULL,
 CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lesson]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lesson](
	[LessonID] [int] IDENTITY(1,1) NOT NULL,
	[LessonName] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
	[Level] [nvarchar](20) NULL,
	[IsDisabled] [bit] NULL,
 CONSTRAINT [PK_Lesson] PRIMARY KEY CLUSTERED 
(
	[LessonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LessonCourse]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LessonCourse](
	[CourseID] [int] NULL,
	[LessonID] [int] NULL,
	[LessonCourseID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_LessonCourse] PRIMARY KEY CLUSTERED 
(
	[LessonCourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participant]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participant](
	[ParticipantID] [int] IDENTITY(1,1) NOT NULL,
	[ExamID] [int] NULL,
	[StudentID] [int] NULL,
	[Grade] [float] NULL,
	[TimeIn] [time](7) NULL,
	[ResponseTime] [time](7) NULL,
	[RegisterDate] [datetime2](7) NULL,
	[IsFinishTest] [bit] NULL,
	[IsDisabled] [bit] NULL,
 CONSTRAINT [PK_Participant] PRIMARY KEY CLUSTERED 
(
	[ParticipantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[DesignerID] [int] NULL,
	[ChapterID] [int] NULL,
	[QuestionType] [nvarchar](20) NULL,
	[Difficulty] [nvarchar](20) NULL,
	[BookPage] [int] NULL,
	[RegistrationDate] [datetime2](7) NULL,
	[TextQuestion] [nvarchar](max) NULL,
	[DisplayCount] [int] NULL,
	[Score] [float] NULL,
	[IsDisabled] [bit] NULL,
	[LanguageDirection] [nvarchar](20) NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionExam]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionExam](
	[QuestionExamID] [int] IDENTITY(1,1) NOT NULL,
	[ExamID] [int] NULL,
	[StudentID] [int] NULL,
	[QuestionID] [int] NULL,
	[StudentAnswer] [nvarchar](2000) NULL,
	[TeacherScore] [float] NULL,
	[DidTeacherCheck] [bit] NULL,
	[IsDisabled] [bit] NULL,
 CONSTRAINT [PK_QuestionTest] PRIMARY KEY CLUSTERED 
(
	[QuestionExamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[NameFamily] [nvarchar](40) NULL,
	[CodeMeli] [nvarchar](10) NULL,
	[StudentCode] [nvarchar](15) NULL,
	[DadName] [nvarchar](30) NULL,
	[Mobile] [nvarchar](12) NULL,
	[UserName] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Class] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[IsGraguated] [bit] NULL,
	[GraduateDate] [datetime2](7) NULL,
	[RegisterDate] [datetime2](7) NULL,
	[IsDisabled] [bit] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentExamPermision]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentExamPermision](
	[StudentExamPermisionID] [int] NOT NULL,
	[ExamID] [int] NULL,
	[StudentID] [int] NULL,
 CONSTRAINT [PK_StudentTestPermision] PRIMARY KEY CLUSTERED 
(
	[StudentExamPermisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Chapter] ON 

INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (1, 1, N'پیاده سازی پایگاه داده', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (2, 2, N'مدیریت مجموعه داده ', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (3, 3, N'طراحی واسط گرافیکی', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (4, 4, N'شایستگی کار با کنترلهای پیشرفته', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (5, 5, N'مدیریت پایگاه داده', 5, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (6, 1, N'سواد فناورانه', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (7, 2, N'فناوری اطلاعات و ارتباطات', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (8, 3, N'فناوری هم گرا و مواد نوترکیب', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (9, 4, N'انرژی های تجدید پذیر', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (10, 5, N'از ایده تامحصول', 9, N'ندارد', 0)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (14, 0, N'1', 1, N'2', 1)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (15, 0, N'1', 1, N'2', 1)
INSERT [dbo].[Chapter] ([ChapterID], [ChapterNo], [ChapterTitle], [LessonID], [Description], [IsDisabled]) VALUES (16, 0, N'1', 1, N'2', 0)
SET IDENTITY_INSERT [dbo].[Chapter] OFF
SET IDENTITY_INSERT [dbo].[Contest] ON 

INSERT [dbo].[Contest] ([ContestID], [ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID]) VALUES (1, 1, N'اعتراض دارم به آزمون و به سوال شماره 2', 1, 0, CAST(N'2631-04-25T00:00:00.0000000' AS DateTime2), 0, N'برو دروغ میگی', 1)
INSERT [dbo].[Contest] ([ContestID], [ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID]) VALUES (2, 1, N'اعتراض دارم به سوال 2', 2, 0, CAST(N'2641-04-25T00:00:00.0000000' AS DateTime2), 0, N'دروغ نمیگی اینو', 1)
INSERT [dbo].[Contest] ([ContestID], [ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID]) VALUES (3, 2, N'اعتراض دارم به ', 3, 0, CAST(N'2631-07-27T00:00:00.0000000' AS DateTime2), 0, N'راست میگی', 2)
SET IDENTITY_INSERT [dbo].[Contest] OFF
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (1, N'الکترونیک', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (2, N'رایانه و و نرم افزار', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (3, N'الکتروتکنیک', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (4, N'حسابداری', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (5, N'باغداری و امور دام', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (6, N'کشاورزی', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (7, N'ریاضی فیزیک', N'ندارد', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (8, N'جغرافيا', N'ندارد', 1)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (9, N'رياضي', N'', 0)
INSERT [dbo].[Course] ([CourseID], [CourseName], [Description], [IsDisabled]) VALUES (10, N'جغرافيا', N'ندارد', 1)
SET IDENTITY_INSERT [dbo].[Course] OFF
SET IDENTITY_INSERT [dbo].[Designer] ON 

INSERT [dbo].[Designer] ([DesignerID], [Name], [CodeMeli], [Official], [UserName], [Password], [Mobile], [Email], [IsDisabled], [RegisterDate]) VALUES (1, N'محمد سبزواری', N'119', N'دبیر', N'admin', N'admin', N'0913', N'k@g.com', 0, NULL)
INSERT [dbo].[Designer] ([DesignerID], [Name], [CodeMeli], [Official], [UserName], [Password], [Mobile], [Email], [IsDisabled], [RegisterDate]) VALUES (2, N'کریم رحیمیان', N'118', N'دبیر', N'user1', N'user1', N'0914', N'l@g.com', 0, NULL)
INSERT [dbo].[Designer] ([DesignerID], [Name], [CodeMeli], [Official], [UserName], [Password], [Mobile], [Email], [IsDisabled], [RegisterDate]) VALUES (3, N'محمد شفیعی', N'117', N'دبیر', N'user2', N'user2', N'0915', N'l@g.com', 0, NULL)
SET IDENTITY_INSERT [dbo].[Designer] OFF
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([ExamID], [ExamName], [Level], [ChapterID], [Date], [Duration], [StartTime], [QuestionType], [ExamType], [SupervisorName], [RepeatTestCount], [OptionalQuestionCount], [OptionalQuestionScore], [DescriptionQuestionCount], [DescriptionQuestionScore], [BlankQuestionCount], [BlankQuestionScore], [TrueFalseQuestionCount], [TrueFalseQuestionScore], [PracticalQuestionCount], [PracticalQuestionScore], [TotalScore], [Status], [Difficulty], [StartDate], [DelayTime], [IsDisabled]) VALUES (1, N'آزمون مستمر برنامه سازی و پایگاه داده', N'11', 2, CAST(N'2641-01-05' AS Date), 40, CAST(N'08:30:00' AS Time), N'ترکیبی', N'مستمر', N'حسام صادقی', 3, 10, 10, 5, 10, 5, 5, 5, 5, 0, 0, 20, N'در صف', N'سخت', CAST(N'2642-03-03T00:00:00.0000000' AS DateTime2), 40, 0)
INSERT [dbo].[Exam] ([ExamID], [ExamName], [Level], [ChapterID], [Date], [Duration], [StartTime], [QuestionType], [ExamType], [SupervisorName], [RepeatTestCount], [OptionalQuestionCount], [OptionalQuestionScore], [DescriptionQuestionCount], [DescriptionQuestionScore], [BlankQuestionCount], [BlankQuestionScore], [TrueFalseQuestionCount], [TrueFalseQuestionScore], [PracticalQuestionCount], [PracticalQuestionScore], [TotalScore], [Status], [Difficulty], [StartDate], [DelayTime], [IsDisabled]) VALUES (2, N'آزمون پایانی پودمان 5', N'11', 10, CAST(N'2631-04-25' AS Date), 60, CAST(N'09:00:00' AS Time), N'تستی', N'پایانی', N'کریم رحیمیان', 3, 0, 0, 0, 0, 0, 0, 0, 0, 5, 20, 20, N'اتمام', N'سخت', CAST(N'2641-03-21T00:00:00.0000000' AS DateTime2), 40, 0)
INSERT [dbo].[Exam] ([ExamID], [ExamName], [Level], [ChapterID], [Date], [Duration], [StartTime], [QuestionType], [ExamType], [SupervisorName], [RepeatTestCount], [OptionalQuestionCount], [OptionalQuestionScore], [DescriptionQuestionCount], [DescriptionQuestionScore], [BlankQuestionCount], [BlankQuestionScore], [TrueFalseQuestionCount], [TrueFalseQuestionScore], [PracticalQuestionCount], [PracticalQuestionScore], [TotalScore], [Status], [Difficulty], [StartDate], [DelayTime], [IsDisabled]) VALUES (3, N'آزمون پایانی پودمان 3', N'11', 8, CAST(N'2636-03-21' AS Date), 60, CAST(N'10:00:00' AS Time), N'تستی', N'پایانی', N'کریم رحیمیان', 3, 10, 20, 0, 0, 0, 0, 0, 0, 0, 0, 20, N'درصفا', N'آسان', CAST(N'2642-04-21T00:00:00.0000000' AS DateTime2), 40, 0)
SET IDENTITY_INSERT [dbo].[Exam] OFF
SET IDENTITY_INSERT [dbo].[Lesson] ON 

INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (1, N'تفکر و سواد رسانه ای', N'ندارد', N'11', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (5, N'برنامه سازی و پایگاه داده ها', N'ندارد', N'11', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (6, N'نصب و راه اندازی سیستم های رایانه ای', N'ندارد', N'11', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (7, N'دانش فنی پایه', N'ندارد', N'10', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (8, N'دانش فنی تخصصی', N'ندارد', N'12', 0)
INSERT [dbo].[Lesson] ([LessonID], [LessonName], [Description], [Level], [IsDisabled]) VALUES (9, N'کارگاه فن آوری های نوین', N'ندارد', N'11', 0)
SET IDENTITY_INSERT [dbo].[Lesson] OFF
SET IDENTITY_INSERT [dbo].[LessonCourse] ON 

INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (1, 1, 1)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 1, 2)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (3, 1, 3)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (4, 1, 4)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (5, 1, 5)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (6, 1, 6)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (7, 1, 7)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (1, 9, 8)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 9, 9)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (3, 9, 10)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (4, 9, 11)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (5, 9, 12)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (6, 9, 13)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (7, 9, 14)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 5, 15)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 6, 16)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 7, 17)
INSERT [dbo].[LessonCourse] ([CourseID], [LessonID], [LessonCourseID]) VALUES (2, 8, 18)
SET IDENTITY_INSERT [dbo].[LessonCourse] OFF
SET IDENTITY_INSERT [dbo].[Participant] ON 

INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (1, 1, 1, 20, CAST(N'02:40:00' AS Time), CAST(N'12:20:00' AS Time), CAST(N'3873-10-11T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (2, 1, 2, 18, CAST(N'08:30:00' AS Time), CAST(N'13:30:00' AS Time), CAST(N'2640-08-16T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (3, 1, 3, 17, CAST(N'09:40:00' AS Time), CAST(N'14:00:00' AS Time), CAST(N'0840-08-16T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (4, 2, 1, 17, CAST(N'10:20:00' AS Time), CAST(N'15:15:00' AS Time), CAST(N'2640-08-18T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (5, 2, 2, 16, CAST(N'11:30:00' AS Time), CAST(N'16:15:00' AS Time), CAST(N'2640-08-19T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (6, 2, 3, 15, CAST(N'12:30:00' AS Time), CAST(N'17:15:00' AS Time), CAST(N'2640-08-21T00:00:00.0000000' AS DateTime2), 1, 0)
INSERT [dbo].[Participant] ([ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]) VALUES (7, 3, 1, 10, CAST(N'14:50:00' AS Time), CAST(N'18:30:00' AS Time), CAST(N'2640-08-06T00:00:00.0000000' AS DateTime2), 1, 0)
SET IDENTITY_INSERT [dbo].[Participant] OFF
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (1, 1, 1, N'تستی', N'سخت', 20, CAST(N'2640-10-08T00:00:00.0000000' AS DateTime2), N'سوال1', 2, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (2, 1, 1, N'تستی', N'سخت', 21, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال2', 1, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (3, 1, 1, N'تستی', N'آسان', 23, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال3', 1, 2, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (4, 1, 1, N'تشریحی', N'سخت', 25, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال4', 1, 3, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (5, 2, 1, N'تستی', N'متوسط', 36, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال5', 1, 2, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (6, 2, 1, N'تشریحی', N'آسان', 50, CAST(N'3261-12-28T00:00:00.0000000' AS DateTime2), N'سوال6', 1, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (7, 2, 2, N'عملی', N'آسان', 10, CAST(N'2639-04-25T00:00:00.0000000' AS DateTime2), N'سوال7', 2, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (8, 2, 2, N'تستی', N'آسان', 12, CAST(N'2640-05-27T00:00:00.0000000' AS DateTime2), N'سوال8', 0, 2, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (9, 2, 2, N'جای خالی', N'آسان', 13, CAST(N'0841-05-28T00:00:00.0000000' AS DateTime2), N'سوال9', 0, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (10, 2, 3, N'تشریحی', N'آسان', 15, CAST(N'2643-03-09T00:00:00.0000000' AS DateTime2), N'سوال10', 0, 2, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (11, 3, 3, N'تشریحی', N'سخت', 20, CAST(N'2636-03-21T00:00:00.0000000' AS DateTime2), N'سوال11', 0, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (12, 3, 3, N'تستی', N'سخت', 21, CAST(N'2636-03-22T00:00:00.0000000' AS DateTime2), N'سوال12', 0, 2, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (13, 3, 4, N'عملی', N'متوسط', 22, CAST(N'2637-03-21T00:00:00.0000000' AS DateTime2), N'سوال13', 0, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (14, 3, 4, N'عملی', N'متوسط', 23, CAST(N'2637-12-08T00:00:00.0000000' AS DateTime2), N'سوال14', 1, 3, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (15, 1, 5, N'جای خالی', N'متوسط', 24, CAST(N'2652-03-05T00:00:00.0000000' AS DateTime2), N'سوال15', 1, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (16, 1, 5, N'جای خالی', N'متوسط', 25, CAST(N'2634-03-08T00:00:00.0000000' AS DateTime2), N'سوال16', 1, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (17, 1, 5, N'جای خالی', N'آسان', 16, CAST(N'2630-09-06T00:00:00.0000000' AS DateTime2), N'سوال17', 2, 2, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (18, 2, 6, N'تستی', N'آسان', 17, CAST(N'2628-05-24T00:00:00.0000000' AS DateTime2), N'سوال18', 2, 1, 0, NULL)
INSERT [dbo].[Question] ([QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]) VALUES (19, 2, 6, N'تستی', N'آسان', 19, CAST(N'2629-04-22T00:00:00.0000000' AS DateTime2), N'سوال19', 3, 2, 0, NULL)
SET IDENTITY_INSERT [dbo].[Question] OFF
SET IDENTITY_INSERT [dbo].[QuestionExam] ON 

INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (1, 1, 1, 1, N'الف', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (2, 1, 1, 2, N'ب', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (3, 1, 1, 3, NULL, 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (4, 1, 1, 4, N'ج', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (5, 1, 2, 1, N'جواب1', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (6, 1, 2, 2, N'جواب2', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (7, 1, 2, 3, N'جواب3', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (8, 1, 2, 4, N'جوال1', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (9, 1, 3, 1, N'ندارد', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (10, 1, 3, 2, N'فردا', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (11, 1, 3, 3, N'دیروز', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (12, 1, 3, 4, N'رادیو', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (13, 2, 1, 1, N'مانیتور', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (14, 2, 1, 2, N'اسب آبی', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (15, 2, 1, 3, N'آسب قرمز', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (16, 2, 1, 4, N'آسب تراوا', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (17, 2, 1, 5, N'خیر', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (18, 2, 2, 6, N'بله', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (19, 2, 2, 5, N'وارد', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (20, 2, 2, 4, N'ناوارد', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (21, 2, 2, 3, N'زندگی', 1, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (22, 2, 2, 2, N'مردگی', 12, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (23, 2, 2, 1, N'فردا', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (24, 2, 3, 1, N'ب', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (25, 2, 3, 2, N'9', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (26, 2, 3, 3, N'6', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (27, 2, 3, 10, N'213984نصث98', 2, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (28, 2, 3, 1, N'صمنصتب09234نب', NULL, 1, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (29, 3, 1, 1, N'ندارد', 1, 0, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (30, NULL, NULL, NULL, NULL, NULL, 0, 0)
INSERT [dbo].[QuestionExam] ([QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]) VALUES (31, NULL, NULL, NULL, NULL, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[QuestionExam] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (1, N'محمدعلی شفیعی', N'118', N'1235464658', N'رضا', N'0913', N'admin', N'123', N'10', N'e@g.com', 0, CAST(N'2631-04-25T00:00:00.0000000' AS DateTime2), CAST(N'2631-05-02T00:00:00.0000000' AS DateTime2), 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (2, N'علیرضا محمدی', N'117', N'321654', N'عباس', N'0912', N'user1', N'124', N'11', N'skljdf@ldkjfg.o', 0, CAST(N'2641-12-23T00:00:00.0000000' AS DateTime2), CAST(N'2631-07-27T00:00:00.0000000' AS DateTime2), 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (3, N'عباس محمد مشاهی', N'116', N'6548', N'تقی', N'65465', N'klsjdf', N'123', N'10', N'mo@g.com', 0, CAST(N'2632-03-02T00:00:00.0000000' AS DateTime2), CAST(N'2632-03-02T00:00:00.0000000' AS DateTime2), 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (6, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (7, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (8, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (9, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (10, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (11, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (12, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (13, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (14, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (15, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (16, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (17, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (18, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (19, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (20, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (21, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (22, N'محسن رضایی', N'علی اصغر م', N'321564652', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (23, N'علی براهیمی', N'119', NULL, NULL, NULL, NULL, NULL, N'دهم', N'ندارد', NULL, NULL, NULL, NULL)
INSERT [dbo].[Student] ([StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]) VALUES (24, N'علی براهیمی', N'119', NULL, NULL, NULL, NULL, NULL, N'دهم', N'ندارد', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Student] OFF
ALTER TABLE [dbo].[Chapter] ADD  CONSTRAINT [DF_Chapter_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[Contest] ADD  CONSTRAINT [DF_Contest_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[Contest] ADD  CONSTRAINT [DF_Contest_IsTeacherResponse]  DEFAULT ((0)) FOR [IsTeacherResponse]
GO
ALTER TABLE [dbo].[Exam] ADD  CONSTRAINT [DF_Test_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[Participant] ADD  CONSTRAINT [DF_Participant_Grade]  DEFAULT ((0)) FOR [Grade]
GO
ALTER TABLE [dbo].[Participant] ADD  CONSTRAINT [DF_Participant_IsFinishTest]  DEFAULT ((1)) FOR [IsFinishTest]
GO
ALTER TABLE [dbo].[Participant] ADD  CONSTRAINT [DF_Participant_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[Question] ADD  CONSTRAINT [DF_Question_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[QuestionExam] ADD  CONSTRAINT [DF_QuestionTest_DidTeacherCheck]  DEFAULT ((0)) FOR [DidTeacherCheck]
GO
ALTER TABLE [dbo].[QuestionExam] ADD  CONSTRAINT [DF_QuestionTest_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_IsGraguated]  DEFAULT ((0)) FOR [IsGraguated]
GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_IsDisabled]  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[Chapter]  WITH CHECK ADD  CONSTRAINT [FK_Poodman_Lesson] FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Chapter] CHECK CONSTRAINT [FK_Poodman_Lesson]
GO
ALTER TABLE [dbo].[Contest]  WITH CHECK ADD  CONSTRAINT [FK_Contest_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Contest] CHECK CONSTRAINT [FK_Contest_Student]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Test_Poodman] FOREIGN KEY([ChapterID])
REFERENCES [dbo].[Chapter] ([ChapterID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Test_Poodman]
GO
ALTER TABLE [dbo].[LessonCourse]  WITH CHECK ADD  CONSTRAINT [FK_LessonCourse_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[LessonCourse] CHECK CONSTRAINT [FK_LessonCourse_Course]
GO
ALTER TABLE [dbo].[LessonCourse]  WITH CHECK ADD  CONSTRAINT [FK_LessonCourse_Lesson] FOREIGN KEY([LessonID])
REFERENCES [dbo].[Lesson] ([LessonID])
GO
ALTER TABLE [dbo].[LessonCourse] CHECK CONSTRAINT [FK_LessonCourse_Lesson]
GO
ALTER TABLE [dbo].[Participant]  WITH CHECK ADD  CONSTRAINT [FK_Participant_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Participant] CHECK CONSTRAINT [FK_Participant_Student]
GO
ALTER TABLE [dbo].[Participant]  WITH CHECK ADD  CONSTRAINT [FK_Participant_Test] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Participant] CHECK CONSTRAINT [FK_Participant_Test]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Designer] FOREIGN KEY([DesignerID])
REFERENCES [dbo].[Designer] ([DesignerID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Designer]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Poodman] FOREIGN KEY([ChapterID])
REFERENCES [dbo].[Chapter] ([ChapterID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Poodman]
GO
ALTER TABLE [dbo].[QuestionExam]  WITH CHECK ADD  CONSTRAINT [FK_QuestionTest_Question] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Question] ([QuestionID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[QuestionExam] CHECK CONSTRAINT [FK_QuestionTest_Question]
GO
ALTER TABLE [dbo].[QuestionExam]  WITH CHECK ADD  CONSTRAINT [FK_QuestionTest_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionExam] CHECK CONSTRAINT [FK_QuestionTest_Student]
GO
ALTER TABLE [dbo].[QuestionExam]  WITH CHECK ADD  CONSTRAINT [FK_QuestionTest_Test] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionExam] CHECK CONSTRAINT [FK_QuestionTest_Test]
GO
ALTER TABLE [dbo].[StudentExamPermision]  WITH CHECK ADD  CONSTRAINT [FK_StudentTestPermision_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([StudentID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[StudentExamPermision] CHECK CONSTRAINT [FK_StudentTestPermision_Student]
GO
ALTER TABLE [dbo].[StudentExamPermision]  WITH CHECK ADD  CONSTRAINT [FK_StudentTestPermision_Test] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[StudentExamPermision] CHECK CONSTRAINT [FK_StudentTestPermision_Test]
GO
/****** Object:  StoredProcedure [dbo].[usp_ContestInsert]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_ContestInsert] 
    @ExamID int = NULL,
    @ContestText nvarchar(1000) = NULL,
    @StudentID int = NULL,
    @IsDisabled bit = NULL,
    @RegisterDate datetime2(7) = NULL,
    @IsTeacherResponse bit = NULL,
    @TeacherResponse nvarchar(1000) = NULL,
    @DesingerID int = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Contest] ([ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID])
	SELECT @ExamID, @ContestText, @StudentID, @IsDisabled, @RegisterDate, @IsTeacherResponse, @TeacherResponse, @DesingerID
	
	-- Begin Return Select <- do not remove
	SELECT [ContestID], [ExamID], [ContestText], [StudentID], [IsDisabled], [RegisterDate], [IsTeacherResponse], [TeacherResponse], [DesingerID]
	FROM   [dbo].[Contest]
	WHERE  [ContestID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
	Select SCOPE_IDENTITY();
Commit
GO
/****** Object:  StoredProcedure [dbo].[usp_ParticipantInsert]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_ParticipantInsert] 
    @ExamID int = NULL,
    @StudentID int = NULL,
    @Grade float = NULL,
    @TimeIn time(7) = NULL,
    @ResponseTime time(7) = NULL,
    @RegisterDate datetime2(7) = NULL,
    @IsFinishTest bit = NULL,
    @IsDisabled bit = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Participant] ([ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled])
	SELECT @ExamID, @StudentID, @Grade, @TimeIn, @ResponseTime, @RegisterDate, @IsFinishTest, @IsDisabled
	
	-- Begin Return Select <- do not remove
	SELECT [ParticipantID], [ExamID], [StudentID], [Grade], [TimeIn], [ResponseTime], [RegisterDate], [IsFinishTest], [IsDisabled]
	FROM   [dbo].[Participant]
	WHERE  [ParticipantID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
	Select  SCOPE_IDENTITY();              
	COMMIT
GO
/****** Object:  StoredProcedure [dbo].[usp_QuestionExamInsert]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_QuestionExamInsert] 
    @ExamID int = NULL,
    @StudentID int = NULL,
    @QuestionID int = NULL,
    @StudentAnswer nvarchar(2000) = NULL,
    @TeacherScore float = NULL,
    @DidTeacherCheck bit = NULL,
    @IsDisabled bit = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[QuestionExam] ([ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled])
	SELECT @ExamID, @StudentID, @QuestionID, @StudentAnswer, @TeacherScore, @DidTeacherCheck, @IsDisabled
	
	-- Begin Return Select <- do not remove
	SELECT [QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]
	FROM   [dbo].[QuestionExam]
	WHERE  [QuestionExamID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
	Select SCOPE_IDENTITY()        
	COMMIT
               

GO
/****** Object:  StoredProcedure [dbo].[usp_QuestionExamUpdate]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_QuestionExamUpdate] 
    @QuestionExamID int,
    @ExamID int = NULL,
    @StudentID int = NULL,
    @QuestionID int = NULL,
    @StudentAnswer nvarchar(2000) = NULL,
    @TeacherScore float = NULL,
    @DidTeacherCheck bit = NULL,
    @IsDisabled bit = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[QuestionExam]
	SET    [ExamID] = @ExamID, [StudentID] = @StudentID, [QuestionID] = @QuestionID, [StudentAnswer] = @StudentAnswer, [TeacherScore] = @TeacherScore, [DidTeacherCheck] = @DidTeacherCheck, [IsDisabled] = @IsDisabled
	WHERE  [QuestionExamID] = @QuestionExamID
	
	-- Begin Return Select <- do not remove
	SELECT [QuestionExamID], [ExamID], [StudentID], [QuestionID], [StudentAnswer], [TeacherScore], [DidTeacherCheck], [IsDisabled]
	FROM   [dbo].[QuestionExam]
	WHERE  [QuestionExamID] = @QuestionExamID	
	-- End Return Select <- do not remove

	COMMIT
GO
/****** Object:  StoredProcedure [dbo].[usp_QuestionInsert]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_QuestionInsert] 
    @DesignerID int = NULL,
    @ChapterID int = NULL,
    @QuestionType nvarchar(20) = NULL,
    @Difficulty nvarchar(20) = NULL,
    @BookPage int = NULL,
    @RegistrationDate datetime2(7) = NULL,
    @TextQuestion nvarchar(MAX) = NULL,
    @DisplayCount int = NULL,
    @Score float = NULL,
    @IsDisabled bit = NULL,
    @LanguageDirection nvarchar(20) = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Question] ([DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection])
	SELECT @DesignerID, @ChapterID, @QuestionType, @Difficulty, @BookPage, @RegistrationDate, @TextQuestion, @DisplayCount, @Score, @IsDisabled, @LanguageDirection
	
	-- Begin Return Select <- do not remove
	SELECT [QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled], [LanguageDirection]
	FROM   [dbo].[Question]
	WHERE  [QuestionID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
	Select SCOPE_IDENTITY();
	COMMIT
GO
/****** Object:  StoredProcedure [dbo].[usp_QuestionUpdate]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_QuestionUpdate] 
    @QuestionID int,
    @DesignerID int = NULL,
    @ChapterID int = NULL,
    @QuestionType nvarchar(20) = NULL,
    @Difficulty nvarchar(20) = NULL,
    @BookPage int = NULL,
    @RegistrationDate datetime2(7) = NULL,
    @TextQuestion nvarchar(MAX) = NULL,
    @DisplayCount int = NULL,
    @Score float = NULL,
    @IsDisabled bit = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Question]
	SET    [DesignerID] = @DesignerID, [ChapterID] = @ChapterID, [QuestionType] = @QuestionType, [Difficulty] = @Difficulty, [BookPage] = @BookPage, [RegistrationDate] = @RegistrationDate, [TextQuestion] = @TextQuestion, [DisplayCount] = @DisplayCount, [Score] = @Score, [IsDisabled] = @IsDisabled
	WHERE  [QuestionID] = @QuestionID
	
	-- Begin Return Select <- do not remove
	SELECT [QuestionID], [DesignerID], [ChapterID], [QuestionType], [Difficulty], [BookPage], [RegistrationDate], [TextQuestion], [DisplayCount], [Score], [IsDisabled]
	FROM   [dbo].[Question]
	WHERE  [QuestionID] = @QuestionID	
	-- End Return Select <- do not remove

	COMMIT
GO
/****** Object:  StoredProcedure [dbo].[usp_StudentInsert]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_StudentInsert] 
    @NameFamily nvarchar(40) = NULL,
    @CodeMeli nvarchar(10) = NULL,
    @StudentCode nvarchar(15) = NULL,
    @DadName nvarchar(30) = NULL,
    @Mobile nvarchar(12) = NULL,
    @UserName nvarchar(100) = NULL,
    @Password nvarchar(100) = NULL,
    @Class nvarchar(20) = NULL,
    @Email nvarchar(100) = NULL,
    @IsGraguated bit = NULL,
    @GraduateDate datetime2(7) = NULL,
    @RegisterDate datetime2(7) = NULL,
    @IsDisabled bit = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Student] ([NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled])
	SELECT @NameFamily, @CodeMeli, @StudentCode, @DadName, @Mobile, @UserName, @Password, @Class, @Email, @IsGraguated, @GraduateDate, @RegisterDate, @IsDisabled
	
	-- Begin Return Select <- do not remove
	SELECT [StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]
	FROM   [dbo].[Student]
	WHERE  [StudentID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove

	Select SCOPE_IDENTITY();
               
	COMMIT
GO
/****** Object:  StoredProcedure [dbo].[usp_StudentUpdate]    Script Date: 10/01/1398 12:47:52 ب.ظ ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_StudentUpdate] 
    @StudentID int,
    @NameFamily nvarchar(40) = NULL,
    @CodeMeli nvarchar(10) = NULL,
    @StudentCode nvarchar(15) = NULL,
    @DadName nvarchar(30) = NULL,
    @Mobile nvarchar(12) = NULL,
    @UserName nvarchar(100) = NULL,
    @Password nvarchar(100) = NULL,
    @Class nvarchar(20) = NULL,
    @Email nvarchar(100) = NULL,
    @IsGraguated bit = NULL,
    @GraduateDate datetime2(7) = NULL,
    @RegisterDate datetime2(7) = NULL,
    @IsDisabled bit = NULL
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Student]
	SET    [NameFamily] = @NameFamily, [CodeMeli] = @CodeMeli, [StudentCode] = @StudentCode, [DadName] = @DadName, [Mobile] = @Mobile, [UserName] = @UserName, [Password] = @Password, [Class] = @Class, [Email] = @Email, [IsGraguated] = @IsGraguated, [GraduateDate] = @GraduateDate, [RegisterDate] = @RegisterDate, [IsDisabled] = @IsDisabled
	WHERE  [StudentID] = @StudentID
	
	-- Begin Return Select <- do not remove
	SELECT [StudentID], [NameFamily], [CodeMeli], [StudentCode], [DadName], [Mobile], [UserName], [Password], [Class], [Email], [IsGraguated], [GraduateDate], [RegisterDate], [IsDisabled]
	FROM   [dbo].[Student]
	WHERE  [StudentID] = @StudentID	
	-- End Return Select <- do not remove

	COMMIT
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد فصل ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chapter', @level2type=N'COLUMN',@level2name=N'ChapterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'شماره فصل' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chapter', @level2type=N'COLUMN',@level2name=N'ChapterNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'عنوان فصل' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chapter', @level2type=N'COLUMN',@level2name=N'ChapterTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد درس' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chapter', @level2type=N'COLUMN',@level2name=N'LessonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'توضیحات' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chapter', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Chapter', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد ثبت اعتراض' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'ContestID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'ExamID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'متن اعتراض' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'ContestText'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد دانش آموز' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'StudentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ ثبت' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'RegisterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'آیا معلم پاسخ داده است' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'IsTeacherResponse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'پاسخ معلم' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'TeacherResponse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد معلم' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Contest', @level2type=N'COLUMN',@level2name=N'DesingerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد رشته' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course', @level2type=N'COLUMN',@level2name=N'CourseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام رشته' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course', @level2type=N'COLUMN',@level2name=N'CourseName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'توضیحات' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'جدول رشته' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Course'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد طراح سوال' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'DesignerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام و نام خانوادگی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد ملی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'CodeMeli'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'سمت' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'Official'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام کاربری' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'رمزعبور' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تلفن همراه' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'Mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ایمیل' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ ثبت نام' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Designer', @level2type=N'COLUMN',@level2name=N'RegisterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'ExamID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'ExamName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'پایه' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'Level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد پودمان' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'ChapterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ ثبت ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'مدت زمان آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'Duration'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'زمان شروع آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نوع سوالات' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'QuestionType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نوع آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'ExamType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام و نام خانوادگی ناظر' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'SupervisorName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تعداد دفعات تکرار آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'RepeatTestCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تعداد سوالات چند گزینه ای' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'OptionalQuestionCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بارم کلی سوالات چند گزینه ای' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'OptionalQuestionScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تعداد سوالات تشریحی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'DescriptionQuestionCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بارم کلی سوالات تشریحی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'DescriptionQuestionScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تعداد سوالات جای خالی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'BlankQuestionCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بارم کلی سوالات جای خالی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'BlankQuestionScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تعداد سوالات صحیح و غلط' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'TrueFalseQuestionCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بارم کلی سوالات صحیح و غلط' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'TrueFalseQuestionScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تعداد سوالات عملی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'PracticalQuestionCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بارم کلی سوالات عملی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'PracticalQuestionScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بارم کلی سوالات' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'TotalScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'وضعیت آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'سطح دشواری آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'Difficulty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ شروع آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'مدت زمان تاخیر در ابتدای آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'DelayTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exam', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد درس' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Lesson', @level2type=N'COLUMN',@level2name=N'LessonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام درس' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Lesson', @level2type=N'COLUMN',@level2name=N'LessonName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'توضیحات' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Lesson', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'پایه تحصیلی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Lesson', @level2type=N'COLUMN',@level2name=N'Level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Lesson', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد رشته' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LessonCourse', @level2type=N'COLUMN',@level2name=N'CourseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد درس' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LessonCourse', @level2type=N'COLUMN',@level2name=N'LessonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد درس رشته' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LessonCourse', @level2type=N'COLUMN',@level2name=N'LessonCourseID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد شرکت کننده' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'ParticipantID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'ExamID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد دانش آموز' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'StudentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نمره' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'Grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'زمان ورود' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'TimeIn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'مدت زمان پاسخدهی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'ResponseTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ ثبت' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'RegisterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'پایان آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'IsFinishTest'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Participant', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد سوال' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'QuestionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد طراح' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'DesignerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'شماره فصل' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'ChapterID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نوع سوال' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'QuestionType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'درجه سختی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'Difficulty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'شماره صفحه کتاب' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'BookPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ ثبت' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'RegistrationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'متن سوال' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'TextQuestion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تعداد دفعات نمایش ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'DisplayCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بارم سوال' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'Score'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Question', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد سوال آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'QuestionExamID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'ExamID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد دانش آموز' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'StudentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد سوال' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'QuestionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'پاسخ دانش آموز' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'StudentAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نمره معلم' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'TeacherScore'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'بررسی توسط معلم' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'DidTeacherCheck'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'QuestionExam', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد دانش آموز' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'StudentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام و نام خانوادگی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'NameFamily'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد ملی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'CodeMeli'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد دانش آموز' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'StudentCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام پدر' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'DadName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'شماره همراه' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'Mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'نام کاربری' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'رمزعبور' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'پایه' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'آدرس ایمیل' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'وضعیت فارغ التحصیلی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'IsGraguated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ فارغ التحصیلی' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'GraduateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'تاریخ ثبت نام' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'RegisterDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'فعال بودن' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Student', @level2type=N'COLUMN',@level2name=N'IsDisabled'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد مجوز آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StudentExamPermision', @level2type=N'COLUMN',@level2name=N'StudentExamPermisionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد آزمون' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StudentExamPermision', @level2type=N'COLUMN',@level2name=N'ExamID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'کد دانش آموز' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StudentExamPermision', @level2type=N'COLUMN',@level2name=N'StudentID'
GO

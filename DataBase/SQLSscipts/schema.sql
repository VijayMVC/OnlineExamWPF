USE [OnlineExam]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculatePersianDate]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  UserDefinedFunction [dbo].[CreateStoreProcedure]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  UserDefinedFunction [dbo].[GenerateAllCommand]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  UserDefinedFunction [dbo].[GenerateDeleteCommand]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  UserDefinedFunction [dbo].[GenerateInsertCommand]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  UserDefinedFunction [dbo].[GenerateUpdateCommand]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  Table [dbo].[Chapter]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  Table [dbo].[Contest]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  Table [dbo].[Course]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  Table [dbo].[Designer]    Script Date: 10/01/1398 12:46:48 ب.ظ ******/
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
/****** Object:  Table [dbo].[Exam]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  Table [dbo].[Lesson]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  Table [dbo].[LessonCourse]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  Table [dbo].[Participant]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  Table [dbo].[Question]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  Table [dbo].[QuestionExam]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  Table [dbo].[Student]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  Table [dbo].[StudentExamPermision]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ContestInsert]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ParticipantInsert]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_QuestionExamInsert]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_QuestionExamUpdate]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_QuestionInsert]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_QuestionUpdate]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_StudentInsert]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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
/****** Object:  StoredProcedure [dbo].[usp_StudentUpdate]    Script Date: 10/01/1398 12:46:49 ب.ظ ******/
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

declare @TableName sysname = 'Exam'
declare @Result varchar(max) = 'public bool Update'+@TableName +'(' + @TableName +' '+ lower(@TableName) + ')
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

select @Result = @Result + @TableName+'.' + Column_Name 
from
(
	select COLUMN_NAME,ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = @TableName and  ORDINAL_POSITION=1
)t 

SET @Result = @Result + ');'
SET @Result = @Result + '
	Message message = operation.UpdateCommand(sql);
    return message.Check;
}'

print @Result
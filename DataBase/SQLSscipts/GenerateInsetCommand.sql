declare @TableName sysname = 'Chapter'
declare @Result varchar(max) = 'public bool Insert'+@TableName +'(' + @TableName +' '+ lower(@TableName) + ')
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
	Message message = operation.InsertCommand(sql);
    return message.Check;
}'

print @Result
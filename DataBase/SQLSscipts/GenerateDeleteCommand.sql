declare @TableName sysname = 'Exam'
declare @Result varchar(max) = 'public bool Delete'+@TableName +'(' + @TableName +' '+ lower(@TableName) + ')
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
	Message message = operation.DeleteCommand(sql);
    return message.Check;
}'

print @Result
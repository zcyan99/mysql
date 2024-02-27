--unused index 
SELECT database_name, 
       table_name, 
       t1.index_name, 
       format_bytes(stat_value * @@innodb_page_size) size 
FROM mysql.innodb_index_stats t1 
JOIN sys.schema_unused_indexes t2 
ON object_schema = database_name AND object_name = table_name AND t2.index_name = t1.index_name 
WHERE stat_name = 'size'   
ORDER BY stat_value DESC ; 

--duplicate index 
SELECT t2.*, format_bytes(stat_value * @@innodb_page_size) size 
FROM mysql.innodb_index_stats t1 
JOIN sys.schema_redundant_indexes t2 
ON table_schema = database_name AND t2.table_name = t1.table_name AND t2.redundant_index_name = t1.index_name  
WHERE stat_name = 'size'   
ORDER BY stat_value DESC ; 

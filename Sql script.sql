# Create Intermediary table from the original dataset
CREATE TABLE OnlineRetail
AS
SELECT InvoiceNo,StockCode,Description 
FROM dataset04.OnlineRetail 
WHERE InvoiceNo!='0' AND Description NOT LIKE'?%' AND Description NOT LIKE '%?' 
GROUP BY InvoiceNo,StockCode,Description


###
# Remove the duplicate rows from above intermediary table
CREATE TABLE DistinctOnlineRetail
AS
SELECT DISTINCT * FROM OnlineRetail


//FULL AND FINAL
CREATE TABLE ProductCluster
AS
SELECT Stockcode, 
COUNT(DISTINCT InvoiceNo) AS Visits, 
SUM(Quantity) AS Sales, 
SUM(Quantity*UnitPrice) AS Total_Revenue, 
COUNT(DISTINCT CustomerID) AS Distinct_Buyers, 
SUM(Quantity)/Count(DISTINCT InvoiceNo) AS Sales_Frequency
FROM dataset04.OnlineRetail 
WHERE InvoiceNo!="0" AND CustomerID!="0" AND UnitPrice!=0
GROUP BY Stockcode 
ORDER BY Total_Revenue DESC 
LIMIT 2000;


//
CREATE TABLE CustomerCluster AS
SELECT CustomerID,SUM(Quantity) AS Total_Products, 
COUNT(DISTINCT StockCode) AS Distinct_Products, 
SUM(Quantity*UnitPrice) AS Total_Revenue, 
COUNT(DISTINCT InvoiceNo) AS Visits, 
SUM(Quantity*UnitPrice)/COUNT(DISTINCT InvoiceNo) AS Loyalty
FROM dataset04.OnlineRetail 
WHERE CustomerID!="0" AND InvoiceNo!="0" AND UnitPrice!=0
GROUP BY CustomerID 
ORDER BY TOTAL_REVENUE DESC
LIMIT 2000;

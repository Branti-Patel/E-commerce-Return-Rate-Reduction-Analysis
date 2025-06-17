use akshitadb  
go



/* display the data in the tables */
select * from Customer;
select * from Products;
select * from  Orders;
select * from  Transactions;
select * from  Ratings;
select * from  Subscription_Plan;
select * from  Subscription_Details;
select * from  Delievry;
select * from  Returns_Refund;








SELECT
    p.Or_ID,
    p.PName,
    p.Category,
    p.Price,
    r.Prod_Rating,
    rr.Reason AS Return_Reason,
    COUNT(o.Or_ID) AS Total_Issues
FROM Products p
JOIN Orders o ON p.Or_ID = o.Or_ID
LEFT JOIN Ratings r ON o.Or_ID = r.Or_ID
LEFT JOIN Returns_refund rr ON o.Or_ID = rr.Or_ID
WHERE r.Prod_Rating <= 2.5
   
GROUP BY
    p.Or_ID, p.PName, p.Category, p.Price, r.Prod_Rating, rr.Reason
ORDER BY Total_Issues DESC;



SELECT
    Reason,
    COUNT(*) AS Total_Returns
FROM Returns_refund
GROUP BY Reason
ORDER BY Total_Returns DESC;

SELECT
    c.State,
    COUNT(rr.Or_ID) AS Total_Returns
FROM Returns_refund rr
JOIN Orders o ON rr.Or_ID = o.Or_ID
JOIN Customer c ON o.C_ID = c.C_ID
GROUP BY c.State
ORDER BY Total_Returns DESC;


SELECT 
    DATENAME(MONTH, Order_Date) AS Order_Month,
    COUNT(Or_ID) AS Total_Orders
FROM Orders
GROUP BY DATENAME(MONTH, Order_Date), MONTH(Order_Date)
ORDER BY MONTH(Order_Date);


-- Top states with most customers
SELECT State, COUNT(*) AS Customer_Count
FROM Customer
GROUP BY State
ORDER BY Customer_Count DESC;

-- Age distribution
SELECT Age, COUNT(*) AS Count
FROM Customer
GROUP BY Age
ORDER BY Age;


-- Best and worst rated delivery partners
SELECT TOP 5 DP_Name, DP_Ratings
FROM Delievry
ORDER BY DP_Ratings DESC;

SELECT TOP 5 DP_Name, DP_Ratings
FROM Delievry
ORDER BY DP_Ratings ASC;

-- Monthly order count
SELECT FORMAT(Order_Date, 'yyyy-MM') AS Month, COUNT(*) AS Total_Orders
FROM Orders
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY Month;

-- Orders using coupon
SELECT Coupon, COUNT(*) AS Coupon_Usage
FROM Orders
GROUP BY Coupon;


-- Most ordered products
SELECT PName, COUNT(*) AS Total_Orders
FROM Products p
JOIN Orders o ON p.Or_ID = o.Or_ID
GROUP BY PName
ORDER BY Total_Orders DESC;

-- Avg price per category
SELECT Category, AVG(Price) AS Avg_Price
FROM Products
GROUP BY Category;


-- Top return reasons
SELECT Reason, COUNT(*) AS Reason_Count
FROM Returns_refund
GROUP BY Reason
ORDER BY Reason_Count DESC;

-- Return/Refund by Month
SELECT FORMAT(Date, 'yyyy-MM') AS Return_Month, COUNT(*) AS Return_Count
FROM Returns_refund
GROUP BY FORMAT(Date, 'yyyy-MM')
ORDER BY Return_Month;

-- Active subscriptions by plan
SELECT sp.Plan_Name, COUNT(*) AS Subscriber_Count
FROM Subscription_Details sd
JOIN Subscription_Plan sp ON sd.Plan_ID = sp.Plan_ID
WHERE GETDATE() BETWEEN sd.From_Date AND sd.To_Date
GROUP BY sp.Plan_Name;

-- Expired Subscriptions
SELECT COUNT(*) AS Expired_Plans
FROM Subscription_Details
WHERE To_Date < GETDATE();


-- Payment method usage
SELECT Transaction_Mode, COUNT(*) AS Usage_Count
FROM Transactions
GROUP BY Transaction_Mode;



SELECT
    p.Or_ID,
    p.PName,
    p.Category,
    p.Specs1,
    p.Price,

    o.Or_ID AS OrderID,
    o.Order_Date,
    o.Order_Time,
    o.Qty,
    o.Coupon,

    c.C_ID,
    c.C_Name,
    c.Gender,
    c.Age,
    c.City,
    c.State,
    c.Mobile,

    d.DP_Name,
    d.DP_Ratings,

    r.Prod_Rating,
   
    rr.Reason AS Return_Reason,
    rr.Date AS Return_Date,

    t.Transaction_Mode,
    t.Tran_Status,

    sp.Plan_Name,
    sp.Features
FROM Products p
JOIN Orders o ON p.Or_ID = o.Or_ID
JOIN Customer c ON o.C_ID = c.C_ID
JOIN Delievry d ON o.DP_ID = d.DP_ID
LEFT JOIN Ratings r ON o.Or_ID = r.Or_ID
LEFT JOIN Returns_refund rr ON o.Or_ID = rr.Or_ID
LEFT JOIN Transactions t ON o.Or_ID = t.Or_ID
LEFT JOIN Subscription_Details sd ON c.C_ID = sd.C_ID
LEFT JOIN Subscription_Plan sp ON sd.Plan_ID = sp.Plan_ID;




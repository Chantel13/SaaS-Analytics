SaaS ANALYSIS
SQL PORTFOLIO PROJECT

Objective: 
The objective of this project was to use SQL to analyse a SaaS business and understand how customers are acquired, how they use and manage their subscriptions, where revenue is being generated, and what challenges customers experience. I wanted to use real business questions to practise working with multiple related tables and turn the data into useful insights that could support better business decisions.

Tools:
SQL Server / SSMS

Author: MS MNYONI, CHANTEL

1.DATA OVERVIEW

--Check number of customers
SELECT
	COUNT(*) TotalCustomers
FROM Customers;

--Check number of subscriptions
SELECT
	COUNT(*) TotalSubscriptions
FROM Subscriptions

--Check number of payments
SELECT
	COUNT(*) TotalPayments
FROM Payments;

--Check number of product usage
SELECT
	COUNT(*) TotalUsage
FROM ProductUsage;

--Check number of support tickets
SELECT
	COUNT(*) TotalTickets
FROM SupportTickets;

--Check number of marketing campains
SELECT
	COUNT(*) TotalCampaigns
FROM MarketingCampaigns;

2.DATA QUALITY CHECKS 

--Check for duplicate customers 
SELECT 
	CustomerID, 
	COUNT(*) NumberOfCustomers 
FROM Customers 
GROUP BY CustomerID 
HAVING COUNT(*) > 1; 

--Check for SignupDates greater than today 
SELECT 
	SignupDate 
FROM Customers 
WHERE SignupDate > GETDATE(); 

--Check for duplicate subscriptions  
SELECT 
	SubscriptionID, 
	COUNT(*) NumberOfSubscriptions 
FROM Subscriptions 
GROUP BY SubscriptionID 
HAVING COUNT(*) > 1; 

--Check for duplicate payments 
SELECT 
	PaymentID, 
	COUNT(*) NumberOfPayments 
FROM Payments 
GROUP BY PaymentID 
HAVING COUNT(*) > 1; 

--Check for discount rates less than 0 
SELECT 
	DiscountRate 
FROM Payments 
WHERE DiscountRate < 0 OR DiscountRate > 100; 

--Check for gross amounts less than 0 
SELECT 
	GrossAmount 
FROM Payments 
WHERE GrossAmount < 0; 

--Check for net amounts less than 0 
SELECT 
	NetAmount 
FROM Payments 
WHERE NetAmount < 0; 

--Check for Monthly prices that are less than 0 
SELECT 
	MonthlyPrice 
FROM Subscriptions 
WHERE MonthlyPrice < 0; 

--Check for Payment dates that occur before the StartDate  
SELECT 
	P.PaymentDate, 
	S.StartDate 
FROM Payments p 
JOIN Subscriptions s 
	ON p.subscriptionid = s.subscriptionid 
WHERE P.PaymentDate < S.StartDate; 

--Check for duplicate product usage  
SELECT 
	UsageID, 
	COUNT(*) NumberOfUsages 
FROM ProductUsage 
GROUP BY UsageID 
HAVING COUNT(*) > 1; 

--Check for sessions less than 0 
SELECT 
	Sessions 
FROM ProductUsage 
WHERE Sessions < 0; 

--Check for minutes used that are less than 0 
SELECT 
	MinutesUsed 
FROM ProductUsage 
WHERE MinutesUsed < 0; 

--Check for duplicate support tickets  
SELECT 
	TicketID, 
	COUNT(*) NumberOfiTckets 
FROM SupportTickets 
GROUP BY TicketID 
HAVING COUNT(*) > 1; 

--Check for ResolvedDates that occurred before the CreatedDates 
SELECT 
	CreatedDate, 
	ResolvedDate 
FROM SupportTickets 
WHERE ResolvedDate < CreatedDate ; 

--Check for satisfaction scores less than 0 and greater than 5 
SELECT 
	SatisfactionScore 
FROM SupportTickets 
WHERE SatisfactionScore < 0 OR SatisfactionScore > 5; 

--Check for duplicate marketing campaigns  
SELECT 
	CampaignID, 
	COUNT(*) NumberOfCampaigns 
FROM MarketingCampaigns 
GROUP BY CampaignID 
HAVING COUNT(*) > 1; 

--Check for customers acquired values less than 0 
SELECT 
	CustomersAcquired 
FROM MarketingCampaigns 
WHERE CustomersAcquired < 0;


3.CUSTOMER ACQUISITION
--How has the number of customers changed overtime from January 2023 to August 2026
SELECT
	YEAR(SignupDate) Year,
	DATENAME(MONTH,SignupDate) MonthName,
	COUNT(*) NumberOfCustomers
FROM Customers
GROUP BY
	YEAR(SignupDate),
	DATENAME(MONTH,SignupDate),
	MONTH(SignupDate)
ORDER BY Year, MONTH(SignupDate);

--Which industries make up the customer base
SELECT 
	Industry,
	COUNT(*) NumberOfCustomers
FROM Customers
GROUP BY Industry
ORDER BY NumberOfCustomers DESC;

--Which acquisition channels are responsible for acquiring the most customers
SELECT
	AcquisitionChannel,
	COUNT(*) NumberOfCustomers
FROM Customers
GROUP BY AcquisitionChannel
ORDER BY NumberOfCustomers DESC;

4.SUBSCRIPTION PERFORMANCE

--Which plans have the most subscribers
SELECT 
	Plan,
	COUNT(*) NumberOfSubscribers
FROM Subscriptions
GROUP BY Plan
ORDER BY NumberOfSubscribers DESC;

--How many active subscriptions are there
SELECT
	COUNT(*) NumberOfActiveSubscribers
FROM Subscriptions
WHERE Status = 'Active';

--Which industries have the highest cancellation rates
WITH IndustryStatus AS
(
SELECT
	C.Industry,
	COUNT(*) AS TotalSubscriptions,
	SUM(CASE WHEN S.Status = 'Cancelled' THEN 1 ELSE 0 END) AS CancelledSubscriptions
FROM Customers C
JOIN Subscriptions S
	ON C.CustomerID = S.CustomerID
GROUP BY C.Industry
)
SELECT
    Industry,
    TotalSubscriptions,
    CancelledSubscriptions,
    CancelledSubscriptions * 1.0 / TotalSubscriptions * 100 AS CancellationRate
FROM IndustryStatus
ORDER BY CancellationRate DESC;

--How many subscriptions started each month, and what is their current status
SELECT
	YEAR(StartDate) Year,
	DATENAME(MONTH, StartDate) MonthName,
	SUM(CASE WHEN Status = 'Active' THEN 1 ELSE 0 END) AS ActiveSubscriptions,
	SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS CancelledSubscriptions
FROM Subscriptions
GROUP BY 
	YEAR(StartDate),
	DATENAME(MONTH, StartDate),
	MONTH(StartDate)
ORDER BY Year, MONTH(StartDate);

--What percentage of subscriptions have been cancelled
WITH Cancelled AS 
(
SELECT
	SUM(CASE WHEN Status = 'Cancelled' THEN 1	ELSE 0 END) CancelledSubscriptions,
	COUNT(*) NumberOfSubscriptions
FROM Subscriptions
)
SELECT
	CancelledSubscriptions * 1.0 / NumberOfSubscriptions * 100 PercentageOfCancelledSubscriptions
FROM Cancelled;

5.REVENUE AND PAYMENTS

--What is the total gross value and net payment value
SELECT 
	SUM(GrossAmount) GrossPaymentRevenue,
	SUM(NetAmount) NetPaymentRevenue
FROM Payments;

--Which subsription plans generate the most subscription revenue
SELECT
	S.Plan,
	SUM(P.GrossAmount) GrossRevenue
FROM Subscriptions s
JOIN Payments p
	ON s.subscriptionid = p.subscriptionid
GROUP BY S.Plan
ORDER BY GrossRevenue DESC;

--Rank the industries that generate the highest net payment revenue
WITH IndustryPerformance AS
( 
SELECT
	C.Industry,
	SUM(P.NetAmount) NetPaymentRevenue
FROM Customers c
JOIN Payments p
	ON c.customerid = p.customerid
GROUP BY C.Industry
)
SELECT
	Industry,
	NetRevenue,
	RANK () OVER (
		ORDER BY NetPaymentRevenue DESC
	) AS RevenueRank
FROM IndustryPerformance;

--What percentage of payment value is associated with failed and refunded payments
WITH LostRevenue AS
(
SELECT
	SUM(NetAmount) NetRevenue,
	SUM(CASE WHEN PaymentStatus = 'Failed' THEN NetAmount END) FailedPayments,
	SUM(CASE WHEN PaymentStatus = 'Refunded' THEN NetAmount END) RefundedPayments
FROM Payments
)
SELECT
	FailedPayments * 1.0 / NetRevenue * 100 FailedPayment,
	RefundedPayments * 1.0 / NetRevenue * 100 RefundedPayment
FROM LostRevenue;

--Which plans have the highest payment failue rates
WITH LeakagePayments AS
(
SELECT
	S.Plan,
	COUNT(*) NumberOfPlans,
	SUM(CASE WHEN P.PaymentStatus = 'Failed' THEN 1 ELSE 0 END) FailedPayments
FROM Subscriptions s
JOIN Payments p
ON s.subscriptionid = p.subscriptionid
GROUP BY S.Plan
)
SELECT
	Plan,
	FailedPayments * 1.0 / NumberOfPlans * 100 FailureRate
FROM LeakagePayments;

--How does annual net revenue compare with the previous quarter
WITH SubscriptionPerformance AS
(
SELECT
	YEAR(PaymentDate) Year,
	DATEPART(QUARTER, PaymentDate) Quarter,
	SUM(NetAmount) NetPaymentRevenue
FROM Payments
GROUP BY 
YEAR(PaymentDate),
DATEPART(QUARTER, PaymentDate)
),
PreviousPerformance AS
(
SELECT
	Year,
	Quarter,
	NetPaymentRevenue,
	LAG(NetPaymentRevenue) OVER (
		PARTITION BY Year
		ORDER BY Quarter
	) AS PreviousQuarterlyRevenue
FROM SubscriptionPerformance
)
SELECT
	Year,
	Quarter,
	NetPaymentRevenue,
	PreviousQuarterlyRevenue,
	(NetPaymentRevenue - PreviousQuarterlyRevenue) * 1.0 / PreviousQuarterlyRevenue * 100 DifferenceRate
FROM PreviousPerformance;

6.PRODUCT USAGE

--Which product features are most frequently used by customers in different industries
SELECT
	C.Industry,
	PU.PrimaryFeature,
	COUNT(DISTINCT c.CustomerID) DistinctCustomers
FROM Customers c
JOIN ProductUsage pu
	ON c.customerid = pu.customerid
GROUP BY c.Industry, pu.PrimaryFeature
ORDER BY DistinctCustomers DESC;

--Which subscription plans have the highest average sessions and minutes used
SELECT
    S.Plan,
    AVG(PU.Sessions) AS AverageSessions,
    AVG(PU.MinutesUsed) AS AverageMinutesUsed
FROM Subscriptions S
JOIN ProductUsage PU
    ON S.CustomerID = PU.CustomerID
GROUP BY S.Plan
ORDER BY AverageSessions DESC;

7.CUSTOMER SUPPORT

--Which issue types generate the most tickets
SELECT 
	IssueType,
	COUNT(*) NumberOfSupportTickets
FROM SupportTickets
GROUP BY IssueType
ORDER BY NumberOfSupportTickets DESC;

--Which priority levels have an average resolution time higher than the overall average 
SELECT 
	Priority,
	AVG(DATEDIFF(DAY, CreatedDate, ResolvedDate)) AverageResolutionDays
FROM SupportTickets 
WHERE ResolvedDate IS NOT NULL
GROUP BY Priority
HAVING AVG(DATEDIFF(DAY, CreatedDate, ResolvedDate)) > 
(
	SELECT 
	AVG(DATEDIFF(DAY, CreatedDate, ResolvedDate)) 
	FROM SupportTickets 
	WHERE ResolvedDate IS NOT NULL
);
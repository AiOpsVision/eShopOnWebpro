-- Create databases
CREATE DATABASE [eShopOnWeb.CatalogDb];
GO
CREATE DATABASE [eShopOnWeb.Identity];
GO

-- Create login
CREATE LOGIN ahmed WITH PASSWORD='{{ sql_user_password }}';
GO

-- Create user in CatalogDb and give db_owner
USE [eShopOnWeb.CatalogDb];
GO
CREATE USER ahmed FOR LOGIN ahmed;
ALTER ROLE db_owner ADD MEMBER ahmed;
GO

-- Create user in Identity and give db_owner
USE [eShopOnWeb.Identity];
GO
CREATE USER ahmed FOR LOGIN ahmed;
ALTER ROLE db_owner ADD MEMBER ahmed;
GO

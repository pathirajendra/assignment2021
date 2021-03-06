USE [master]
GO
/****** Object:  Database [university]    Script Date: 10/5/2021 12:42:34 AM ******/
CREATE DATABASE [university]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'university', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\university.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'university_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\university_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [university] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [university].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [university] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [university] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [university] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [university] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [university] SET ARITHABORT OFF 
GO
ALTER DATABASE [university] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [university] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [university] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [university] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [university] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [university] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [university] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [university] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [university] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [university] SET  DISABLE_BROKER 
GO
ALTER DATABASE [university] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [university] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [university] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [university] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [university] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [university] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [university] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [university] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [university] SET  MULTI_USER 
GO
ALTER DATABASE [university] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [university] SET DB_CHAINING OFF 
GO
ALTER DATABASE [university] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [university] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [university] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [university] SET QUERY_STORE = OFF
GO
USE [university]
GO
/****** Object:  UserDefinedFunction [dbo].[BreakStringIntoRows]    Script Date: 10/5/2021 12:42:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[BreakStringIntoRows] (@CommadelimitedString   varchar(1000))
RETURNS   @Result TABLE (Column1 varchar(50))
AS
BEGIN
        DECLARE @IntLocation INT
        WHILE (CHARINDEX(',',    @CommadelimitedString, 0) > 0)
        BEGIN
              SET @IntLocation =   CHARINDEX(',',    @CommadelimitedString, 0)      
              INSERT INTO   @Result (Column1)
              --LTRIM and RTRIM to ensure blank spaces are   removed
              SELECT RTRIM(LTRIM(SUBSTRING(@CommadelimitedString,   0, @IntLocation)))   
              SET @CommadelimitedString = STUFF(@CommadelimitedString,   1, @IntLocation,   '') 
        END
        INSERT INTO   @Result (Column1)
        SELECT RTRIM(LTRIM(@CommadelimitedString))--LTRIM and RTRIM to ensure blank spaces are removed
        RETURN 
END

GO
/****** Object:  UserDefinedFunction [dbo].[f_split]    Script Date: 10/5/2021 12:42:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[f_split]
(
@param nvarchar(max), 
@delimiter char(1)
)
returns @t table (val nvarchar(max), seq int)
as
begin
set @param += @delimiter

;with a as
(
select cast(1 as bigint) f, charindex(@delimiter, @param) t, 1 seq
union all
select t + 1, charindex(@delimiter, @param, t + 1), seq + 1
from a
where charindex(@delimiter, @param, t + 1) > 0
)
insert @t
select substring(@param, f, t - f), seq from a
option (maxrecursion 0)
return
end
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 10/5/2021 12:42:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[university_Id] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[Teacher_name] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Universities]    Script Date: 10/5/2021 12:42:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Universities](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [text] NULL,
	[country] [varchar](50) NOT NULL,
	[minimum_gpa] [decimal](18, 2) NOT NULL,
	[minimum_gre_scroe] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (1, 1, N'Computer Science', N'Robert')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (2, 2, N'Computer Science', N'Michael')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (3, 3, N'Computer Science', N'William')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (4, 1, N'Data Science', N'Joseph')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (5, 2, N'Data Science', N'James')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (6, 3, N'Data Science', N'Matthew')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (7, 1, N'Chemical Engineering', N'Ronald')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (8, 2, N'Chemical Engineering', N'Nicholas')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (9, 3, N'Chemical Engineering', N'Stephen')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (10, 1, N'Civil Engineering', N'Justin')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (11, 2, N'Electrical Engineering', N'Brandon')
INSERT [dbo].[Courses] ([id], [university_Id], [name], [Teacher_name]) VALUES (12, 3, N'Biomedical Engineering', N'Samuel')
SET IDENTITY_INSERT [dbo].[Courses] OFF
SET IDENTITY_INSERT [dbo].[Universities] ON 

INSERT [dbo].[Universities] ([id], [name], [description], [country], [minimum_gpa], [minimum_gre_scroe]) VALUES (1, N'Stanford University', N'', N'United States', CAST(8.50 AS Decimal(18, 2)), 155)
INSERT [dbo].[Universities] ([id], [name], [description], [country], [minimum_gpa], [minimum_gre_scroe]) VALUES (2, N'Princeton University', N'', N'England', CAST(7.50 AS Decimal(18, 2)), 150)
INSERT [dbo].[Universities] ([id], [name], [description], [country], [minimum_gpa], [minimum_gre_scroe]) VALUES (3, N'University of Wisconsin Madison', N'', N'United States', CAST(7.80 AS Decimal(18, 2)), 153)
SET IDENTITY_INSERT [dbo].[Universities] OFF
/****** Object:  StoredProcedure [dbo].[getAllCourseName]    Script Date: 10/5/2021 12:42:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  procedure [dbo].[getAllCourseName]
AS
BEGIN
select name from Courses
END
GO
/****** Object:  StoredProcedure [dbo].[searchCourse]    Script Date: 10/5/2021 12:42:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[searchCourse]
(
@gpa float,
@greScore INT,
@country varchar(100),
@courseName varchar(100)
)

AS
BEGIN

IF (@courseName is null)
BEGIN
SELECT Universities.id, Universities.name as universityName, country, minimum_gpa, minimum_gre_scroe,
Courses.id as courseId, Courses.name as courseName, Courses.Teacher_name
FROM Universities 
JOIN Courses 
ON Courses.university_Id = Universities.id
WHERE minimum_gpa >= @gpa and minimum_gre_scroe >= @greScore and country like '%' + @country + '%';
select 'coures' as nullcourse
END

ELSE
BEGIN
SELECT Universities.id, Universities.name as universityName, country, minimum_gpa, minimum_gre_scroe,
Courses.id as courseId, Courses.name as courseName, Courses.Teacher_name
FROM Universities 
JOIN Courses 
ON Courses.university_Id = Universities.id
WHERE minimum_gpa >= @gpa and minimum_gre_scroe >= @greScore and country like '%' + @country + '%' 
and Courses.name in (SELECT val FROM dbo.f_split(@courseName, ','));
END

END
GO
USE [master]
GO
ALTER DATABASE [university] SET  READ_WRITE 
GO

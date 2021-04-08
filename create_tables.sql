IF OBJECT_ID('Movies', 'U') IS NOT NULL DROP TABLE Movies

CREATE TABLE Movies (
  MovieID int PRIMARY KEY IDENTITY(0,1),
  MovieTitle nvarchar(196) NOT NULL,
  ReleaseYear smallint NOT NULL,
  RunningTime time NOT NULL, 
  Genre nvarchar(40),
  CONSTRAINT MovieNameLength CHECK (LEN(MovieTitle) >= 2 AND LEN(MovieTitle) <= 196), 
  CONSTRAINT CHK_Year CHECK (ReleaseYear >= 1900 AND ReleaseYear <= (YEAR(getdate()) + 5)),
  CONSTRAINT CHCK_Name UNIQUE(MovieTitle)
);  

IF OBJECT_ID('ScreeningRooms', 'U') IS NOT NULL DROP TABLE ScreeningRooms
CREATE TABLE ScreeningRooms (
  RoomID char PRIMARY KEY,
  RowsNumber tinyint CHECK(RowsNumber > 0 and RowsNumber <= 30) NOT NULL,
  SeatsInRowNum tinyint DEFAULT 20,
);

IF OBJECT_ID('Seats', 'U') IS NOT NULL DROP TABLE Seats
CREATE TABLE Seats (
  SeatID int PRIMARY KEY IDENTITY(1,1),
  RoomID char NOT NULL FOREIGN KEY REFERENCES ScreeningRooms(RoomID),
  [Row] tinyint,
  [Column] tinyint,
);

IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers
CREATE TABLE Customers (
  CustomerID int PRIMARY KEY IDENTITY(0,1),
  FirstName nvarchar(50) NOT NULL,
  LastName nvarchar(50) NOT NULL,
  PostalCode char(6),
  Constraint CHKNamesCustomers CHECK ((FirstName NOT LIKE '%[-!#%&+,./:;<=>@`{|}~"()*\\\_\^\?\[\]\'']%' {ESCAPE '\'}) OR (LastName NOT LIKE '%[-!#%&+,./:;<=>@`{|}~"()*\\\_\^\?\[\]\'']%' {ESCAPE '\'})) 
); 

IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees
CREATE TABLE Employees (
  EmployeeID int PRIMARY KEY IDENTITY(1,1),
  FirstName nvarchar(50) NOT NULL,
  LastName nvarchar(50) NOT NULL,
  Constraint CHKNamesEmployees CHECK ((FirstName NOT LIKE '%[-!#%&+,./:;<=>@`{|}~"()*\\\_\^\?\[\]\'']%' {ESCAPE '\'}) OR (LastName NOT LIKE '%[-!#%&+,./:;<=>@`{|}~"()*\\\_\^\?\[\]\'']%' {ESCAPE '\'}))
);  

IF OBJECT_ID('TicketPrices', 'U') IS NOT NULL DROP TABLE TicketPrices
CREATE TABLE TicketPrices (
  TicketPriceID int PRIMARY KEY IDENTITY(1,1),
  TicketType nvarchar(20) NOT NULL,
  Price money NOT NULL,
  EndDate date,
  CONSTRAINT TicketTypeLength CHECK (LEN(TicketType) >= 2)
); 

IF OBJECT_ID('Screenings', 'U') IS NOT NULL DROP TABLE Screenings
CREATE TABLE Screenings (
  ScreeningID int PRIMARY KEY IDENTITY(1,1),
  MovieID int FOREIGN KEY REFERENCES Movies(MovieID),
  [Date] datetime NOT NULL,
  [RoomID] char NOT NULL FOREIGN KEY REFERENCES ScreeningRooms(RoomID),
);

IF OBJECT_ID('Reservations', 'U') IS NOT NULL DROP TABLE Reservations
CREATE TABLE Reservations (
  ReservationID int PRIMARY KEY IDENTITY(1,1),
  CustomerID int FOREIGN KEY REFERENCES Customers(CustomerID),
  EmployeeID int FOREIGN KEY REFERENCES Employees(EmployeeID),
  ScreeningID int NOT NULL FOREIGN KEY REFERENCES Screenings(ScreeningID),
  ReservationDate datetime NOT NULL,
  TicketPrice money,
  NumOfTickets int CHECK (NumOfTickets BETWEEN 0 AND 280)
);

IF OBJECT_ID('SeatStatus', 'U') IS NOT NULL DROP TABLE SeatStatus
CREATE TABLE SeatStatus (
  StatusID int PRIMARY KEY IDENTITY(1,1), 
  SeatID int NOT NULL FOREIGN KEY REFERENCES Seats(SeatID),
  ScreeningID int NOT NULL FOREIGN KEY REFERENCES Screenings(ScreeningID),
  CONSTRAINT CHCK_SeatScreening UNIQUE(SeatID, ScreeningID)
);

IF OBJECT_ID('Tickets', 'U') IS NOT NULL DROP TABLE Tickets
CREATE TABLE Tickets (
  TicketID int PRIMARY KEY IDENTITY(1,1),
  ReservationID int NOT NULL FOREIGN KEY REFERENCES Reservations(ReservationID),
  StatusID int NOT NULL FOREIGN KEY REFERENCES SeatStatus(StatusID)
);

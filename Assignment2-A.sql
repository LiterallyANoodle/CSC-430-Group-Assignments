DROP DATABASE IF EXISTS Shipyard;
CREATE DATABASE Shipyard;

# define strong entities
CREATE TABLE Ship (
	Sname varchar(255),
    Owner varchar(255),
    
    PRIMARY KEY (Sname)
);

CREATE TABLE Ship_type (
	Type varchar(255),
    Tonnage real,
    Hull varchar(255), 
    
    PRIMARY KEY (Type)
);

CREATE TABLE State_country (
	Name varchar(255),
    Continent varchar(255), 
    
    PRIMARY KEY (Name)
);

CREATE TABLE Sea_ocean_lake (
	Name varchar(255),
    
    PRIMARY KEY (Name)
);

# define weak entities
CREATE TABLE Ship_movement (
	Longitude real,
    Latitude real,
    Time_stamp datetime,
    
    PRIMARY KEY (Time_stamp)
);

CREATE TABLE Port (
	Pname varchar(225),
    
    PRIMARY KEY (Pname)
);

CREATE TABLE Port_visit (
	Start_date datetime,
    End_date datetime,
    
    PRIMARY KEY (Start_date)
);

# define relationship tables 
CREATE TABLE History (
	Time_stamp datetime NOT NULL,
    Sname varchar(255) UNIQUE,
    
    PRIMARY KEY (Time_stamp, Sname),
    FOREIGN KEY (Time_stamp) REFERENCES Ship_movement(Time_stamp),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname)
);

CREATE TABLE Ship_of_type (
	Sname varchar(255) NOT NULL,
    Type varchar(255) UNIQUE,
    
    PRIMARY KEY (Sname, Type),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname),
    FOREIGN KEY (Type) REFERENCES Ship_type(Type)
);
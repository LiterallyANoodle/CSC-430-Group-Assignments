DROP DATABASE IF EXISTS Shipyard;
CREATE DATABASE Shipyard;
USE Shipyard;

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
    Sname varchar(255),
    
    PRIMARY KEY (Time_stamp, Sname),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname)
);

CREATE TABLE Port_visit (
	Start_date datetime,
    End_date datetime,
    Sname varchar(255),
    
    PRIMARY KEY (Start_date, Sname),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname)
);

CREATE TABLE Port (
	Pname varchar(225),
    SCName varchar(255),
    SOLName varchar(255),
    
    PRIMARY KEY (Pname),
    FOREIGN KEY (SCName) REFERENCES State_country(Name),
    FOREIGN KEY (SOLName) REFERENCES Sea_ocean_lake(Name)
);

# define relationship tables 
CREATE TABLE History (
	Time_stamp datetime NOT NULL,
    Sname varchar(255),
    
    PRIMARY KEY (Time_stamp, Sname),
    FOREIGN KEY (Time_stamp) REFERENCES Ship_movement(Time_stamp),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname)
);

CREATE TABLE Ship_of_type (
	Sname varchar(255) NOT NULL,
    Type varchar(255),
    
    PRIMARY KEY (Sname, Type),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname),
    FOREIGN KEY (Type) REFERENCES Ship_type(Type)
);

CREATE TABLE Home_port (
	Sname varchar(255),
    Pname varchar(255),
    
    PRIMARY KEY (Sname, Pname),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname),
    FOREIGN KEY (Pname) REFERENCES Port(Pname)
);

CREATE TABLE Ship_at_port (
	Start_date datetime NOT NULL,
    Sname varchar(255),
    Pname varchar(255),
    
    PRIMARY KEY (Start_date, Sname, Pname),
    FOREIGN KEY (Start_date) REFERENCES Port_visit(Start_date),
    FOREIGN KEY (Sname) REFERENCES Ship(Sname),
    FOREIGN KEY (Pname) REFERENCES Port(Pname)
);

CREATE TABLE Port_in_state_country (
	Pname varchar(255) NOT NULL,
    SCName varchar(255),
    
    PRIMARY KEY (Pname, SCName),
    FOREIGN KEY (Pname) REFERENCES Port(Pname),
    FOREIGN KEY (SCName) REFERENCES State_country(Name)
);

CREATE TABLE Port_on_sea_ocean_lake (
	Pname varchar(255) NOT NULL,
    SOLName varchar(255),
    
    PRIMARY KEY (Pname, SOLName),
    FOREIGN KEY (Pname) REFERENCES Port(Pname),
    FOREIGN KEY (SOLName) REFERENCES Sea_ocean_lake(Name)
);
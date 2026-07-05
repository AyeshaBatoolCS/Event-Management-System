Create database EVENT_MANAGEMENT_SYSTEM_DATABASE;
use EVENT_MANAGEMENT_SYSTEM_DATABASE;
CREATE TABLE Organizer(
    OrganizerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(20),
    Email VARCHAR(100)
);
CREATE TABLE Venue(
    VenueID INT PRIMARY KEY,
    VenueName VARCHAR(100),
    Location VARCHAR(100),
    Capacity INT
);
CREATE TABLE Event(
    EventID INT PRIMARY KEY,
    EventName VARCHAR(100),
    EventDate DATE,
    OrganizerID INT,
    VenueID INT,
    FOREIGN KEY (OrganizerID) REFERENCES Organizer(OrganizerID),
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);
CREATE TABLE Participant(
    ParticipantID INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(20),
    Email VARCHAR(100)
);
CREATE TABLE Registration(
    RegistrationID INT PRIMARY KEY,
    EventID INT,
    ParticipantID INT,
    RegistrationDate DATE,
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID)
);
INSERT INTO Organizer
VALUES
(1,'Ali Events','03001234567','ali@events.com'),
(2,'Bright Star Org','03111222333','bright@gmail.com'),
(3,'Event Masters','03451234567','masters@events.com'),
(4,'Galaxy Planners','03551234567','galaxy@events.com'),
(5,'Future Vision Org','03661234567','future@events.com');

INSERT INTO Venue 
VALUES 
(1,'Grand Hall','Lahore',500),
(2,'City Center Hall','Karachi',300),
(3,'Expo Center','Islamabad',800),
(4,'Pearl Banquet','Multan',400),
(5,'Sunshine Arena','Faisalabad',600);

INSERT INTO Event
VALUES 
(1,'Tech Conference','2026-06-10',1,1),
(2,'Music Night','2026-06-15',2,2),
(3,'Art Exhibition','2026-07-01',3,3),
(4,'Business Summit','2026-07-10',4,4),
(5,'Food Festival','2026-07-20',5,5);

INSERT INTO Participant 
VALUES 
(1,'Ahmed','03001112222','ahmed@gmail.com'),
(2,'Sara','03221234567','sara@gmail.com'),
(3,'Ali','03331234567','ali@gmail.com'),
(4,'Fatima','03441234567','fatima@gmail.com'),
(5,'Usman','03551234567','usman@gmail.com');

INSERT INTO Registration 
VALUES 
(1,1,1,'2026-06-01'),
(2,1,2,'2026-06-02'),
(3,2,3,'2026-06-03'),
(4,4,4,'2026-07-05'),
(5,5,5,'2026-07-15');
-- All events with organizer & venue
SELECT E.EventName,E.EventDate,O.Name AS Organizer,V.VenueName FROM Event E
JOIN Organizer O ON E.OrganizerID = O.OrganizerID
JOIN Venue V ON E.VenueID = V.VenueID;
-- Participants in events
SELECT P.Name AS Participant,E.EventName,R.RegistrationDate FROM Registration R
JOIN Participant P ON R.ParticipantID = P.ParticipantID
JOIN Event E ON R.EventID = E.EventID;
-- Total participants per event
SELECT EventID,COUNT(ParticipantID) AS TotalParticipants FROM Registration GROUP BY EventID;
-- Venue usage report
SELECT V.VenueName,V.Capacity, COUNT(R.ParticipantID) AS BookedSeats
FROM Venue V
JOIN Event E ON V.VenueID = E.VenueID
JOIN Registration R ON E.EventID = R.EventID
GROUP BY V.VenueName, V.Capacity;
CREATE DATABASE bnb;
USE bnb;

CREATE  TABLE users ( 
	userid               INT  NOT NULL  AUTO_INCREMENT   PRIMARY KEY,
	name                 VARCHAR(100)  NOT NULL     ,
	email                VARCHAR(500)  NOT NULL     ,
	password             VARCHAR(500)  NOT NULL     ,
	profilepicture       VARCHAR(500)       ,
	phonenumber          VARCHAR(500)  NOT NULL     ,
	gender               CHAR  NOT NULL     ,
	nationality          VARCHAR(50)  NOT NULL     ,
	age                  INT  NOT NULL     
 );

CREATE  TABLE hosts ( 
	hostid               INT  NOT NULL AUTO_INCREMENT     ,
	aboutme              TEXT  NOT NULL     ,
	verificationstatus   INT  NOT NULL     ,
	joindate             DATETIME  NOT NULL     ,
	userid               INT  NOT NULL     ,
	CONSTRAINT `pk hosts` PRIMARY KEY ( hostid, userid )
 );

CREATE TABLE accom (
    accomid INT NOT NULL AUTO_INCREMENT ,
    hostid INT NOT NULL,
    title VARCHAR(500) NOT NULL,
    description TEXT(0) NOT NULL,
    createdate DATETIME,
    CONSTRAINT `pk accomodations` PRIMARY KEY (accomid, hostid),
    CONSTRAINT `fk accomodations hosts` FOREIGN KEY (hostid) REFERENCES hosts(hostid) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE Amenities (
    AmenityID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    AmenityName VARCHAR(100)
);

CREATE TABLE Countries (
    CountryID INT NOT NULL AUTO_INCREMENT  PRIMARY KEY,
    CountryName VARCHAR(100),
    Code CHAR(3) NOT NULL
);

CREATE  TABLE Tags ( 
	`TagID`              INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`TagName`            VARCHAR(100)  NOT NULL     
 );

CREATE  TABLE facilities ( 
	facilityid           INT  NOT NULL  AUTO_INCREMENT    PRIMARY KEY,
	facilityname         VARCHAR(100)       
 );



CREATE  TABLE locations ( 
    locationid INT NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
    locationname VARCHAR(100),
    longitude DECIMAL(8, 4) NOT NULL,
    latitude DECIMAL(8, 4) NOT NULL,
    address VARCHAR(100) NOT NULL
);

CREATE  TABLE photos ( 
	photoid              INT  NOT NULL  AUTO_INCREMENT    PRIMARY KEY,
	photolink            VARCHAR(500)       
 );

CREATE  TABLE rules ( 
	ruleid               INT  NOT NULL   AUTO_INCREMENT   PRIMARY KEY,
	ruledescription      TEXT(0)       
 );

CREATE TABLE Cities (
    CityID INT NOT NULL AUTO_INCREMENT ,
    CityName VARCHAR(100) NOT NULL,
    CountryID INT NOT NULL,
    Population INT NOT NULL,
    CONSTRAINT `pk Cities` PRIMARY KEY (CityID, CountryID),
    CONSTRAINT `fk Cities Countries` FOREIGN KEY (CountryID) REFERENCES Countries(CountryID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE HostBank ( 
	`HostBankAccountID`  INT  NOT NULL   AUTO_INCREMENT   ,
	`HostID`             INT  NOT NULL     ,
	`AccountNumber`      BIGINT  NOT NULL     ,
	`BankName`           VARCHAR(100)  NOT NULL     ,
	`AccountHolderName`  VARCHAR(100)       ,
	`RoutingNumber`      VARCHAR(500)  NOT NULL     ,
	CONSTRAINT `pk Host Bank Accounts` PRIMARY KEY ( `HostBankAccountID`, `HostID` ),
	CONSTRAINT `fk Host Bank Accounts Hosts` FOREIGN KEY ( `HostID` ) REFERENCES hosts( hostid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE Verifications ( 
	`VerificationID`     INT  NOT NULL  AUTO_INCREMENT    ,
	`VerificationStatus` BOOLEAN  NOT NULL     ,
	`HostID`             INT  NOT NULL     ,
	CONSTRAINT `pk Verifications` PRIMARY KEY ( `VerificationID`, `HostID` ),
	CONSTRAINT `fk Verifications Hosts` FOREIGN KEY ( `HostID` ) REFERENCES hosts( hostid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );



CREATE TABLE accomcity (
    accomcityid INT NOT NULL AUTO_INCREMENT ,
    accomid INT NOT NULL,
    cityid INT NOT NULL,
    CONSTRAINT `pk accomodationcity` PRIMARY KEY (accomcityid, accomid, cityid),
    CONSTRAINT `fk accomodationcity accomodations` FOREIGN KEY (accomid) REFERENCES accom(accomid) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk accomodationcity cities` FOREIGN KEY (cityid) REFERENCES Cities(CityID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE accomfacilities ( 
	accomfacilityid      INT  NOT NULL   AUTO_INCREMENT   ,
	accomid              INT  NOT NULL     ,
	facilityid           INT  NOT NULL     ,
	CONSTRAINT `pk accomodationfacilities` PRIMARY KEY ( accomfacilityid, accomid, facilityid ),
	CONSTRAINT `fk accomodationfacilities accomodations` FOREIGN KEY ( accomid ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk accomodationfacilities facilities` FOREIGN KEY ( facilityid ) REFERENCES facilities( facilityid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE accomphotos ( 
	accomphotoid         INT  NOT NULL   AUTO_INCREMENT   ,
	photoid              INT  NOT NULL     ,
	accomid              INT  NOT NULL     ,
	CONSTRAINT `pk accomphotos` PRIMARY KEY ( accomphotoid, accomid ),
	CONSTRAINT `fk accomphotos accom` FOREIGN KEY ( accomid ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk accomphotos photos` FOREIGN KEY ( photoid ) REFERENCES photos( photoid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE accomtag ( 
	accomtagid           INT  NOT NULL   AUTO_INCREMENT   ,
	accomid              INT  NOT NULL     ,
	tagid                INT  NOT NULL     ,
	CONSTRAINT `pk accomodationtag` PRIMARY KEY ( accomtagid, accomid, tagid ),
	CONSTRAINT `fk accomodationtag accomodations` FOREIGN KEY ( accomid ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk accomodationtag tags` FOREIGN KEY ( tagid ) REFERENCES `Tags`( `TagID` ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE specialoffers ( 
	offerid              INT  NOT NULL  AUTO_INCREMENT    ,
	accomid              INT  NOT NULL     ,
	offertitle           VARCHAR(500)  NOT NULL     ,
	offerdescription     VARCHAR(500)       ,
	offerdiscount        DECIMAL  NOT NULL     ,
	offerexpirationdate  DATETIME  NOT NULL     ,
	hostid               INT  NOT NULL     ,
	CONSTRAINT `pk special offers` PRIMARY KEY ( offerid, accomid, hostid ),
	CONSTRAINT `fk special offers accomodations` FOREIGN KEY ( accomid ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk special offers hosts` FOREIGN KEY ( hostid ) REFERENCES hosts( hostid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE AccomAmenity( 
	`AccomAmenityID`     INT  NOT NULL  AUTO_INCREMENT    ,
	`AccomID`            INT  NOT NULL     ,
	`AmenityID`          INT  NOT NULL     ,
	CONSTRAINT `pk AccomodationAmenity` PRIMARY KEY ( `AccomAmenityID`, `AccomID`, `AmenityID` ),
	CONSTRAINT `fk AccomodationAmenity Accomodations` FOREIGN KEY ( `AccomID` ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk AccomodationAmenity Amenities` FOREIGN KEY ( `AmenityID` ) REFERENCES Amenities( `AmenityID` ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE AccomCountry ( 
	`AccomCountryID`     INT  NOT NULL   AUTO_INCREMENT   ,
	`AccomID`            INT  NOT NULL     ,
	`CountryID`          INT  NOT NULL     ,
	CONSTRAINT `pk AccomodationCity 0` PRIMARY KEY ( `AccomCountryID`, `AccomID`, `CountryID` ),
	CONSTRAINT `fk AccomodationCountry Accomodations` FOREIGN KEY ( `AccomID` ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk AccomodationCountry Countries` FOREIGN KEY ( `CountryID` ) REFERENCES Countries( `CountryID` ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE AccomLocation ( 
	`AccomLocationID`    INT  NOT NULL  AUTO_INCREMENT    ,
	`AccomID`            INT  NOT NULL     ,
	`LocationID`         INT  NOT NULL     ,
	CONSTRAINT `pk AccomodationLocation` PRIMARY KEY ( `AccomLocationID`, `AccomID`, `LocationID` ),
	CONSTRAINT `fk AccomodationLocation Accomodations` FOREIGN KEY ( `AccomID` ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk AccomodationLocation Locations` FOREIGN KEY ( `LocationID` ) REFERENCES locations( locationid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE AccomRule ( 
	`AccomRuleID`        INT  NOT NULL  AUTO_INCREMENT    ,
	`AccomID`            INT  NOT NULL     ,
	`RuleID`             INT  NOT NULL     ,
	CONSTRAINT `pk AccomodationRule` PRIMARY KEY ( `AccomRuleID`, `AccomID`, `RuleID` ),
	CONSTRAINT `fk AccomodationRule Accomodations` FOREIGN KEY ( `AccomID` ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk AccomodationRule Rules` FOREIGN KEY ( `RuleID` ) REFERENCES rules( ruleid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE Ratings ( 
	`RatingID`           INT  NOT NULL  AUTO_INCREMENT   ,
	`AccomID`            INT  NOT NULL     ,
	`HostID`             INT  NOT NULL     ,
	`AccomRating`        DECIMAL(4,2)  NOT NULL     ,
	CONSTRAINT `pk Ratings` PRIMARY KEY ( `RatingID`, `AccomID`, `HostID` ),
	CONSTRAINT `fk Ratings Accomodations` FOREIGN KEY ( `AccomID` ) REFERENCES accom( accomid ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT `fk Ratings Hosts` FOREIGN KEY ( `HostID` ) REFERENCES hosts( hostid ) ON DELETE NO ACTION ON UPDATE NO ACTION
 );

CREATE  TABLE Bookings ( 
	`BookingID`          INT  NOT NULL   AUTO_INCREMENT   ,
	`GuestID`            INT  NOT NULL     ,
	`AccomID`            INT  NOT NULL     ,
	`inDate`             DATETIME  NOT NULL     ,
	`outDate`            DATETIME  NOT NULL     ,
	`TotalPrice`         DECIMAL  NOT NULL     ,
	`Status`             CHAR(1)  NOT NULL     ,
	CONSTRAINT `pk Bookings` PRIMARY KEY ( `BookingID`, `GuestID`, `AccomID` )
 );

CREATE  TABLE Favorites ( 
	`FavoritesID`        INT  NOT NULL  AUTO_INCREMENT    ,
	`GuestID`            INT  NOT NULL     ,
	`AccomID`            INT  NOT NULL     ,
	`DateAdded`          DATETIME  NOT NULL     ,
	CONSTRAINT `pk Favourites` PRIMARY KEY ( `FavoritesID`, `GuestID`, `AccomID` )
 );

CREATE  TABLE Languages ( 
	`LanguageID`         INT  NOT NULL  AUTO_INCREMENT    ,
	`LanguageName`       VARCHAR(100)       ,
	`UserID`             INT  NOT NULL     ,
	CONSTRAINT `pk Languages` PRIMARY KEY ( `LanguageID`, `UserID` )
 );

CREATE  TABLE Messaging ( 
	`MessageID`          INT  NOT NULL  AUTO_INCREMENT    ,
	`SenderID`           INT  NOT NULL     ,
	`ReceiverID`         INT  NOT NULL     ,
	`MessageContent`     TEXT(0)  NOT NULL     ,
	`MessageDate`        DATETIME  NOT NULL     ,
	CONSTRAINT `pk Messaging` PRIMARY KEY ( `MessageID`, `SenderID`, `ReceiverID` )
 );

CREATE  TABLE Payments ( 
	`PayID`              INT  NOT NULL  AUTO_INCREMENT    ,
	`BookingID`          INT  NOT NULL     ,
	`Amount`             DECIMAL       ,
	`PayDate`            DATETIME  NOT NULL     ,
	`PayMethod`          VARCHAR(50)       ,
	`PayStatus`          BOOLEAN       ,
	CONSTRAINT `pk Payments` PRIMARY KEY ( `PayID`, `BookingID` )
 );

CREATE  TABLE ReviewsComments ( 
	`ReviewCommentID`    INT  NOT NULL  AUTO_INCREMENT    ,
	`ReviewID`           INT  NOT NULL     ,
	`CommentText`        TEXT(0)  NOT NULL     ,
	`CommentDate`        DATETIME  NOT NULL     ,
	CONSTRAINT `pk Reviews Comments` PRIMARY KEY ( `ReviewCommentID`, `ReviewID` )
 );

CREATE  TABLE SocialMedia ( 
	`SocialMediaID`      INT  NOT NULL   AUTO_INCREMENT   ,
	`UserID`             INT  NOT NULL     ,
	`SocialMediaType`    VARCHAR(500)       ,
	`ProfileLink`        VARCHAR(500)       ,
	CONSTRAINT `pk Social Media` PRIMARY KEY ( `SocialMediaID`, `UserID` )
 );

CREATE  TABLE UserRatings ( 
	`UserRatingID`       INT  NOT NULL  AUTO_INCREMENT    ,
	`RatedUserID`        INT  NOT NULL     ,
	`RatingType`         VARCHAR(5)  NOT NULL     ,
	`RatingValue`        DECIMAL(3,1)  NOT NULL     ,
	`RatingUserID`       INT  NOT NULL     ,
	CONSTRAINT `pk User Ratings` PRIMARY KEY ( `UserRatingID`, `RatingUserID` )
 );

CREATE  TABLE bookingextensions ( 
	extensionid          INT  NOT NULL  AUTO_INCREMENT    ,
	bookingid            INT  NOT NULL     ,
	newoutdate           DATETIME  NOT NULL     ,
	extensiondate        DATETIME  NOT NULL     ,
	CONSTRAINT `pk booking extensions` PRIMARY KEY ( extensionid, bookingid )
 );

CREATE  TABLE cancellations ( 
	cancellationid       INT  NOT NULL  AUTO_INCREMENT    ,
	bookingid            INT  NOT NULL     ,
	cancellationdate     DATETIME  NOT NULL     ,
	cancellationreason   VARCHAR(500)  NOT NULL     ,
	CONSTRAINT `pk cancellations` PRIMARY KEY ( cancellationid, bookingid )
 );

CREATE  TABLE commisions ( 
	commisionid          INT  NOT NULL  AUTO_INCREMENT    ,
	bookingid            INT  NOT NULL     ,
	guestcommision       DECIMAL  NOT NULL     ,
	hostcommision        DECIMAL  NOT NULL     ,
	totalcommision       DECIMAL  NOT NULL     ,
	CONSTRAINT `pk commisions` PRIMARY KEY ( commisionid, bookingid )
 );

CREATE  TABLE guests ( 
	guestid              INT  NOT NULL  AUTO_INCREMENT    ,
	userid               INT  NOT NULL     ,
	joindate             DATETIME  NOT NULL     ,
	CONSTRAINT `pk guests` PRIMARY KEY ( guestid, userid )
 );

CREATE  TABLE notifications ( 
	notificationid       INT  NOT NULL   AUTO_INCREMENT   ,
	userid               INT  NOT NULL     ,
	notificationmessage  TEXT(0)  NOT NULL     ,
	notificationdate     DATETIME  NOT NULL     ,
	CONSTRAINT `pk notifications` PRIMARY KEY ( notificationid, userid )
 );

CREATE TABLE reviews (
    reviewid INT NOT NULL AUTO_INCREMENT,
    guestid INT NOT NULL,
    accomid INT NOT NULL,
    rating DECIMAL(3, 1) NOT NULL, 
    reviewdate DATETIME NOT NULL,
    CONSTRAINT `pk reviews` PRIMARY KEY (reviewid, guestid, accomid)
);

CREATE  TABLE useraccomodation ( 
	useraccmodationid    INT  NOT NULL  AUTO_INCREMENT   ,
	userid               INT  NOT NULL     ,
	accomid              INT  NOT NULL     ,
	CONSTRAINT `pk useraccomodation` PRIMARY KEY ( useraccmodationid, accomid )
 );




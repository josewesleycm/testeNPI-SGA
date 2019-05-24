CREATE TABLE bomba(
   Id int IDENTITY(1,1) NOT NULL,
   Id_tanque int NULL,
   PRIMARY KEY (Id)
   FOREIGN KEY (Id_tanque) references tanque(Id)
)

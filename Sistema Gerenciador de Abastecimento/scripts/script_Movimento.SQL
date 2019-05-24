CREATE TABLE movimento(
  Id int IDENTITY NOT NULL,
  Id_tanque int NULL,
  Id_bomba int NULL,
  dat_movim datetime null,
  valor decimal(18,5) default 0.00000 null,
  valor_incid decimal(18,5) default 0.00000 null,
  qtd decimal(18,5) default 0.00000 null,
  PRIMARY KEY (Id),
  FOREIGN KEY (Id_tanque) references tanque(Id),
  FOREIGN KEY (Id_bomba) references bomba(Id)
)




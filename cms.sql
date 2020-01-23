create database CMS;
use CMS;


-- TABLE CUSTOMER

CREATE TABLE CUSTOMER(
CUS_ID INTEGER(30) PRIMARY KEY,
CUS_USERNAME VARCHAR(30) UNIQUE NOT NULL,
CUS_PASSWORD VARCHAR(30) NOT NULL,
CUS_WALLET FLOAT NOT NULL,
CUS_NAME VARCHAR(30) NOT NULL
);



-- VENDOR TABLE

CREATE TABLE VENDOR(
VDR_ID INTEGER(30) PRIMARY KEY,
VDR_NAME VARCHAR(30) NOT NULL,
VDR_USERNAME VARCHAR(30) UNIQUE,
VDR_PASSWORD VARCHAR(30) NOT NULL,
VDR_ADDRESS VARCHAR(60) 
);



-- TABLE MENU
CREATE TABLE  MENU(
MEN_ID INTEGER(30) PRIMARY KEY,
MEN_NAME VARCHAR(30) NOT NULL,
MEN_PRICE FLOAT NOT NULL,
MEN_SPL VARCHAR(60) NOT NULL,
MEN_VDR_ID INTEGER(30),
FOREIGN KEY(MEN_VDR_ID) REFERENCES VENDOR(VDR_ID)
);



-- TABLE ORDER

CREATE TABLE ORDERS(
ORD_ID INTEGER(30) PRIMARY KEY AUTO_INCREMENT,
ORD_CUS_ID INTEGER(30), 
FOREIGN KEY(ORD_CUS_ID)REFERENCES CUSTOMER(CUS_ID),
ORD_MEN_ID INTEGER(30),  
FOREIGN KEY (ORD_MEN_ID)REFERENCES MENU(MEN_ID),
ORD_QTY INTEGER(30) NOT NULL,
ORD_TOTCOST FLOAT NOT NULL,
ORD_STATUS ENUM('ACCEPTED','REJECTED','ORDERED'),
ORD_DATE DATE,
ORD_COMMENT VARCHAR(60)   
);

DESC MENU;
DESC ORDERS;
DESC CUSTOMER;
DESC VENDOR;

INSERT INTO CUSTOMER
VALUES(1,'RAM123','hexaware@1','10000','Ram'),
(2,'SAM123','hexaware@2','12000','Sam'),
(3,'SHYAM123','hexaware@3','20000','Shyam'),
(4,'PAM123','hexaware@4','10003','Pam'),
(5,'RAMYA123','hexaware@5','13300','Ramya');

INSERT INTO VENDOR
VALUES(500,'HEXACAFE','CAFE123','CAFE@123','SECOND FLOOR'),
(501,'HEXADINE','DINE123','DINE@123','FIRST FLOOR'),
(502,'HEXARAUNT','RAUNT123','RAUNT@123','THIRD FLOOR'),
(503,'HEXALOUNGE','LOUNGE123','LOUNGE@123','GROUND FLOOR'),
(504,'HEXAPUB','PUB123','PUB@123','EB3');

INSERT INTO MENU
VALUES(1000,'GOBI','60','STARTER',500),
(1001,'PAVBHAJI','40','CHAT',501),
(1002,'PANIPOORI','20','CHAT',504),
(1003,'NOODLES','50','STARTER',503),
(1004,'CHICKEN-BIRYANI','160','MAIN-DISH',500),
(1005,'TANDOORI','160','STARTER',501),
(1006,'THALI','120','MAIN_DISH',502),
(1007,'SAMOSA','10','CHAT',501),
(1008,'MILKSHAKE','30','DESSERT',503),
(1009,'KESARI','25','DESSERT',502);


INSERT INTO ORDERS (ORD_CUS_ID,ORD_MEN_ID,ORD_QTY,ORD_TOTCOST,ORD_STATUS,ORD_DATE,ORD_COMMENT)
VALUES(2,1003,'2','100','ACCEPTED','2019-08-18',''),
(5,1004,1,'160','ORDERED','2019-08-12',''),
(4,1001,3,'180','ACCEPTED','2019-08-11',''),
(3,1005,2,'320','REJECTED','2019-08-09','TIME OVER'),
(1,1007,5,'50','ACCEPTED','2019-08-24','');

use cms;
SELECT * FROM CUSTOMER;
desc customer;
alter table customer
modify column cus_id int(30);
SELECT * FROM VENDOR;
SELECT * FROM MENU;
SELECT * FROM ORDERS;
desc orders;
alter table orders
modify column ord_m int(30);

select * from orders
where day(ord_date) = 24 ;

select count(o.ord_id),m.men_vdr_id from orders o
join menu m on o.ord_men_id=m.men_id
where count(o.ord_id) = (select m.men_vdr_id from menu m where max(count(o.ord_id)))
group by m.men_vdr_id;


select o.ord_id,v.vdr_name, c.cus_name, m.men_name from vendor v, customer c, menu m,orders o
where  c.cus_id = o.ord_cus_id and
  o.ord_men_id = m.men_id and
  v.vdr_id = m.men_vdr_id
  group by o.ord_id; 
  
select v.vdr_name, m.men_name,men_id,men_price
from vendor v, menu m
where v.vdr_id = m.men_vdr_id
order by v.vdr_name;

select * from menu where men_price > 
(select men_price from menu where men_name='gobi');

SELECT sysdate();
desc menu;
insert into Orders(ORD_CUS_ID,ORD_MEN_ID,ORD_QTY,ORD_TOTCOST,ORD_STATUS,ORD_DATE) 
Values("1", "2",3, 1000, 'ACCEPTED',sysdate());

alter table Menu
add constraint mnvdr
foreign key men_vdr_id
references vendors(vdr_id);

drop table Orders;
DROP TABLE MENU;
DROP TABLE VENDOR;
DROP TABLE CUSTOMER;
drop table menu;
select * from menu;




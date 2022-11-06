drop table users;

create table users(
	username varchar(50) primary key,
	password varchar(50) not null
);

drop table transactions;
drop table accounts;

create table accounts(
	acc_no int not null,
	password varchar(50) not null,
	balance float,
	constraint pk_account primary key(acc_no)
);


create table transactions(
	transaction_id varchar(36) not null,
	from_acc_no int not null,
	to_acc_no int not null,
	amount float,
	time_stamp timestamp not null default CURRENT_TIMESTAMP,
	constraint fk_sender foreign key(from_acc_no) references accounts(acc_no),
	constraint fk_receiver foreign key(to_acc_no) references accounts(acc_no)
);


insert into users
values("admin", "123");

insert into users
values("user1", "pass1");

insert into users
values("user2", "pass2");

insert into users
values("user3", "pass3");

insert into accounts
values (1000, 'aaditya', 1200);

insert into accounts
values (1004, 'anmol', 9000);

update accounts set balance = 9000 where acc_no = 1004;

insert into accounts
values (1001, 'akil', 800);

insert into accounts
values (1002, 'bimal', 500);


select username from users where username = 'admin' and password = '123' 
union select password  from users as `u a`;

select table_name from information_schema.tables


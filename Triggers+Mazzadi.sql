use freres;

CREATE TABLE if not exists New_pedidos_clientes(
id_pedido int not null auto_increment primary key,
id_cliente int not null,
id_articulo int not null,
id_sucursal int not null,
cantidad int not null);

#TRIGGER 1, ESTE TRIGGER HARA UNA COPIA POR CADA PEDIDO QUE SE CREA EN LA TABLA PEDIDOS.


create trigger ins_aft_pedidos_clientes_new_pedidos_clientes
after insert on pedidos_clientes
for each row
insert into New_pedidos_clientes
values (new.id_pedido,new.id_cliente, new.id_articulo,new.id_sucursal,new.cantidad);

insert into pedidos_clientes 
values (null,3,15,1,1); 

SELECT * FROM freres.new_pedidos_clientes;



create table logs(
fecha_hora datetime,
usuario varchar(100),
bd varchar(100),
version varchar (20));


#ESTE TRIGGER FUNCIONARA PARA SABER QUE USUARIO REALIZO UNA ELIMINACIÓN EN LA TABLA PEDIDOS, A SU VEZ, TRAERA CONSIGO LA INFORMACIÓN DE CUANDO SE REALIZÓ, SOBRE QUE BASE Y QUE VERSIÓN UTILIZABA.


create trigger BEF_DEL_PEDIDOS_CLIENTES_LOGS
BEFORE DELETE ON pedidos_clientes
FOR EACH ROW
INSERT INTO logs
Values (NOW(), USER(),database(),VERSION());

SET sql_safe_updates=0;

Delete FROM pedidos_clientes WHERE ID_PEDIDO=16;

Select *from freres.logs;



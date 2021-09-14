create or replace function alquilerpelicula() returns trigger
as $alquilerpelicula$
    declare
		cantidad int;
begin
		
		select count(alquiler.IDALQUILER) into cantidad
from alquiler 
where alquiler.FECHAENTREGA is null  and alquiler.IDCLIENTE =new.IDCLIENTE;
		
        if(cantidad >= 2 ) then
            raise exception 'cliente con 2 alquileres pendientes de entrega';
        end if;
        return new;
end;
$alquilerpelicula$
language plpgsql;


create trigger alquilerpeliculaTrigger before insert
on alquiler for each row
execute procedure alquilerpelicula();
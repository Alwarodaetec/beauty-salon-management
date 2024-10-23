create database salao_de_beleza_AlwaroPedrodaSilva;
use salao_de_beleza_AlwaroPedrodaSilva;

create table especialidade_aps(
id_especialidade_aps int primary key auto_increment not null,
especialidade_aps varchar(25) not null
);

create table profissional_aps(
id_profissional_aps int primary key auto_increment not null,
profissional_aps varchar(25) not null,
id_especialidade_aps int not null,
cpf_profissional_aps varchar(11) not null,
foreign key(id_especialidade_aps) references especialidade_aps(id_especialidade_aps)
);

create table cliente_aps(
id_cliente_aps int primary key auto_increment not null,
cliente_aps varchar(25) not null,
cpf_cliente_aps varchar(11) not null
);

create table servico_aps(
id_servico_aps int primary key auto_increment not null,
id_cliente_aps int not null,
id_profissional_aps int not null,
id_especialidade_aps int not null,
data_aps date,
tipo_servico_aps varchar(100) not null,
foreign key(id_cliente_aps) references cliente_aps(id_cliente_aps),
foreign key(id_profissional_aps) references profissional_aps(id_profissional_aps),
foreign key(id_especialidade_aps) references especialidade_aps(id_especialidade_aps)
);


delimiter $$
create procedure insere_nova_especialidade_aps(e varchar(25))
begin
	insert into especialidade_aps(especialidade_aps)
    values(e);
    select*from especialidade_aps;
end$$
delimiter ;

/*inserindo as especialidades q atendem os clientes*/
call insere_nova_especialidade_aps('Manicure');
call insere_nova_especialidade_aps('Cabeleireira');


	delimiter $$
	create procedure insere_cliente_aps(cl varchar(25), cp varchar(11))
	begin
		insert into cliente_aps(cliente_aps, cpf_cliente_aps)
		values(cl, cp);
		select*from cliente_aps;

	end$$

	delimiter ;

	call insere_cliente_aps('Carolinny','22354323412');

/*quando houve um erro de digitação ao inserir a coluna a ser preenchida usei : DROP PROCEDURE insere_cliente_aps;*/

delimiter $$
create procedure insere_profissional_aps(p varchar(25), id_e int, c varchar(11))
begin
	insert into profissional_aps(profissional_aps, id_especialidade_aps, cpf_profissional_aps)
    values(p, id_e, c);
    select*from profissional_aps;
end$$

delimiter ;

/*testando inserção das profissionais de nosso estabelecimento*/
call insere_profissional_aps('Rose', 2,'29234354391');
call insere_profissional_aps('Adriana', 1, '32049554343');

Delimiter $$

create trigger tg_agendamento_de_servico_aps
before insert
on servico_aps
for each row
begin
	if dayname(New.data_aps) in ('Sunday', 'Monday') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível agendar para Domingos ou Segundas-Feira';
    END IF;
END$$

delimiter ;
    
    
delimiter $$
create procedure agendamento_de_servico_aps(id_c int, id_p int, id_e int, d date, t varchar(100))
begin
	insert into servico_aps(id_cliente_aps, id_profissional_aps, id_especialidade_aps, data_aps, tipo_servico_aps)
    values(id_c, id_p, id_e, d, t);
    select*from servico_aps;
end $$

delimiter ;

/*testando gatilos de erros*/
call agendamento_de_servico_aps(1,1,2,'2024-10-28','Progressiva');
call agendamento_de_servico_aps(1,1,2,'2024-10-27','Progressiva');

/*teste de inserção de serviço na agenda do salão*/
call agendamento_de_servico_aps(1,1,2,'2024-10-26','Progressiva');
call agendamento_de_servico_aps(1,2,1,'2024-10-29','Unhas Postiças');
/*para consultar que especialidade cada profissional exerce*/
select especialidade_aps.especialidade_aps, profissional_aps.profissional_aps from especialidade_aps
natural join profissional_aps;

SELECT
	especialidade_aps.especialidade_aps, profissional_aps.profissional_aps, cliente_aps.cliente_aps
FROM
	servico_aps
INNER JOIN cliente_aps ON cliente_aps.id_cliente_aps = servico_aps.id_cliente_aps
INNER JOIN profissional_aps ON profissional_aps.id_profissional_aps = servico_aps.id_profissional_aps
INNER JOIN especialidade_aps on especialidade_aps.id_especialidade_aps = servico_aps.id_especialidade_aps
where id_servico_aps=3;

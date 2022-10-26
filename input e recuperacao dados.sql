use ecommerce;
show tables;
select * from produtos;
desc estoques;
insert into clientes (Primeiro_Nome, Sobrenome, CPF, Endereço, Data_de_Nasc)
	values ('Maria', 'Silva', '00000000000', 'Rua 15 de Maio nº 1234 Bairro Corcovado - Cidade das Flores', '1975-12-02'),
			('João', 'Silva', '12345678910', 'Rua 15 de Maio nº 1234 Bairro Corcovado - Cidade das Flores', '1972-02-21'),
			('Felipe', 'Araújo', '45645645645', 'Rua Castro Alves nº 29 Bairro Lindóia - Cidade das Flores', '1989-01-05'),
            ('Ana', 'Almeida', '56756756756', 'Rua Quatro nº 49 Bairro Lindóia - Cidade das Flores', '1990-12-25'),
            ('Carolina', 'Carvalho', '27827827878', 'Rua Flores nº 51 Bairro Lírio - Justinópolis', '2000-07-28');
  
  insert into produtos (Nome, classificacao_kids, categoria, SKU, avaliação, size)
	values ('Fone', false, 'Eletrônicos', 'EE0124', 4, null),
			('Barbie E', true, 'Brinquedos', 'BK0532', 3, null),
            ('Body Car', true, 'Vestuário', 'VK0791', 5, null),
            ('Microfone', false, 'Eletrônicos', 'EE0967', 4, null),
            ('Sofá Retr', false, 'Móveis', 'MS0476', 3, '30x57x140');

insert into pedidos (idPedidoCliente, Status_Pedido, Descrição, Frete, Pagamento_Boleto)
				values (6, default, 'compra via app', null, 1),
					(7, default, 'compra via app', 50, 0),
					(8, 'Confirmado', null, null, 1),
					(9, default, 'compra via app', 150, 0);

insert into produto_por_pedido(idPedido, idProduto, Quantidade, StatusProdPedido)	
		values (5, 11, 2, null),
			(5, 12, 1, null),
            (6, 15, 1, null);
 
 insert into estoques(Local)
	values('RJ'),
		('SP'),
        ('BSB');

 insert into produtos_por_estoque(idEstoque, idProduto, Quantidade)   
	values(1, 12, 100),
        (1, 13, 50),
        (2, 14, 61),
        (3, 15, 5);
        
insert into fornecedores (Razão_Social, CNPJ, Contato)
			values('Almeida e Filhos', '12341234123412', '3199999999'),
            ('E. Silva', '12981234123412', '3199999988'),
            ('E. Valma', '12671234123412', '3199999977');
            
insert into vendedores_terceiros (Razão_Social, CNPJ, Contato)
			values('Araújo Eletrônicos', '12341234123412', '3199999999'),
            ('José Silva Ltda.', '12981238523412', '3199799988'),
            ('Cia Carvalho', '12671234124912', '3199949977');

#Quantos clientes?
select count(*) from clientes;

#Qual o status do pedido de cada cliente?
select concat(Primeiro_Nome, ' ', Sobrenome) as Cliente, CPF, Status_Pedido from clientes c, pedidos pe where c.idCliente = pe.idPedidoCliente;

#Quantos pedidos temos 'Em processamento'?
select Status_Pedido, count(*) from pedidos
	group by Status_Pedido
    having Status_Pedido = 'Em processamento';
    
#Quais são as avaliações dos produtos indicados para crianças ordenadas da melhor para a pior?  
select * from produtos where classificacao_kids = 0
	order by avaliação desc;

#Qual o estoque por produto por local?
select idProduto,Quantidade, Local from produtos_por_estoque p, estoques e where  p.idEstoque = e.idEstoque;

#Quais são os produtos e respectivas quantidades que tem estoque abaixo de 10 unidades?
select p.idProduto, ps.Nome, Quantidade, Local from produtos_por_estoque p, estoques e, produtos ps where  p.idEstoque = e.idEstoque and p.idProduto = ps.idProduto and Quantidade < 10;

#Lista de clientes ativos e inativos (com pedido ou não)
select * from clientes left outer join pedidos on idCliente = idPedidoCliente;

# Quais clientes (id por CPF) que fizeram pedidos e qual o frete desses pedidos?
select CPF, count(*) as 'Nº de Pedidos', Frete from clientes 
	join pedidos on idCliente = idPedidoCliente
    group by CPF;

# Quais clientes (id por CPF) que fizeram pedidos usando o frete promocional de outubro22 (20% de desconto sobre o valor normal de frete)?
select idPedido, Frete * 0.8 as 'Frete Promocional Out22'from pedidos  where Frete > 0;


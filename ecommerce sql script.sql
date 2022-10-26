-- Criação do banco de dados para o cenário de E-commerce
show databases;

use ecommerce;


-- Criação das tabelas
create table clientes(
idCliente int auto_increment primary key,
Primeiro_Nome varchar(10),
Sobrenome varchar(20),
CPF char(11) not null,
Endereço varchar(60),
Data_de_Nasc date,
constraint cpf_cliente_unico unique (cpf)
);

create table produtos(
idProduto int auto_increment primary key,
Nome varchar(10) not null,
classificacao_kids bool,
categoria enum('Eletrônicos','Vestuário', 'Brinquedos', 'Alimentos','Móveis') not null,
SKU char(10) not null,
avaliação float default 0,
size varchar(10),
constraint sku_unico unique (SKU)
);

create table pagamentos(
idCliente int,
idPagamento int,
Tipo_Pagamento enum('Boleto', 'Cartão', 'Dois Cartões'),
Limite_Valor float,
primary key(idCliente, idPagamento)
);

create table pedidos(
idPedido int auto_increment primary key,
idPedidoCliente int,
Status_Pedido enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
Descrição varchar(255),
Frete float default 10,
Pagamento_Boleto bool default false,
constraint fk_pedido_cliente foreign key (idPedidoCliente) references clientes(idCliente)
);

create table estoques(
idEstoque int auto_increment primary key,
Local varchar(60)
);

create table fornecedores(
idFornecedor int auto_increment primary key,
Razão_Social varchar(50) not null,
CNPJ char(14) not null,
Contato char(11) not null,
constraint fornecedor_unico unique (CNPJ)
);

create table vendedores_terceiros(
idVendedor int auto_increment primary key,
Razão_Social varchar(50) not null,
CNPJ char(14) not null,
Contato char(11) not null,
constraint vendedor_unico unique (CNPJ)
);

create table produto_por_vendedor(
idVendedor int,
idProduto int,
Quantidade int default 1,
primary key(idVendedor,idProduto),
constraint fk_prod_vend_vendedor foreign key (idVendedor) references vendedores_terceiros(idVendedor),
constraint fk_prod_vend_produto foreign key (idProduto) references produtos(idProduto)
);

create table produto_por_pedido(
idPedido int,
idProduto int,
Quantidade int default 1,
StatusProdPedido enum('Disponível', 'Sem estoque') default 'Disponível', 
primary key(idPedido,idProduto),
constraint fk_prod_ped_pedido foreign key (idPedido) references pedidos(idPedido),
constraint fk_prod_ped_produto foreign key (idProduto) references produtos(idProduto)
);

create table produtos_por_estoque(
idEstoque int,
idProduto int,
Quantidade int default 0,
primary key(idEstoque,idProduto),
constraint fk_prod_est_estoque foreign key (idEstoque) references estoques(idEstoque),
constraint fk_prod_est_produto foreign key (idProduto) references produtos(idProduto)
);

create table produto_por_fornecedor(
idFornecedor int,
idProduto int,
Quantidade int not null,
primary key(idFornecedor,idProduto),
constraint fk_prod_forn_fornecedor foreign key (idFornecedor) references fornecedores(idFornecedor),
constraint fk_prod_forn_produto foreign key (idProduto) references produtos(idProduto)
);

show tables;
use ecommerce;
alter table clientes auto_increment=1;
alter table produtos auto_increment=1;
alter table pedidos auto_increment=1;
alter table estoques auto_increment=1;
alter table fornecedores auto_increment=1;
alter table vendedores auto_increment=1;

insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into produto (nome, preco, data_criacao, descricao) values ('PS3', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');

insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");

insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, date_sub(sysdate(), interval 5 day), 8597.98, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 2, 3799.99, 2);

insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);

insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');

insert into nota_fiscal ( pedido_id, xml, data_emissao ) values ( 2, '<xml />', sysdate() );

insert into categoria (nome) values ("Eletrônicos");
insert into categoria (nome) values ("Eletrodomésticos");
insert into categoria (nome) values ("Livros");
insert into categoria (nome) values ("Esportes");
insert into categoria (nome) values ("Futebol");
insert into categoria (nome) values ("Natação");
insert into categoria (nome) values ("Notebooks");
insert into categoria (nome) values ("Smartphones");

insert into produto_categoria (produto_id, categoria_id) values (1,1), (2,1);
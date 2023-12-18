SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

insert into produto (nome, ativo, preco, data_criacao, descricao) values ('Kindle', 'SIM', 500.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome,  ativo, preco, data_criacao, descricao) values ('PS5', 'SIM', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into produto (nome,  ativo, preco, data_criacao, descricao) values ('PS3', 'SIM', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into produto (id,  ativo, nome, preco, data_criacao, descricao) values (4, 'SIM', 'Câmera GoPro Hero 7', 1400.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor.');
insert into produto (id,  ativo, nome, preco, data_criacao, descricao) values (5, 'NAO', 'Câmera Canon 80D', 3700.0, sysdate(), 'O melhor ajuste de foco.');

insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");

insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, date_sub(sysdate(), interval 5 day), 3798.00, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 4, 1400.0, 2);

insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);

insert into pedido (id, cliente_id, data_criacao, total, status) values (3, 1, date_sub(sysdate(), interval 4 day), 3500.0, 'PAGO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (3, 5, 3500, 1);

insert into pedido (id, cliente_id, data_criacao, total, status) values (4, 2, date_sub(sysdate(), interval 2 day), 499.0, 'PAGO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (4, 1, 499, 1);

insert into pedido (id, cliente_id, data_criacao, total, status) values (5, 2, date_sub(sysdate(), interval 2 day), 500, 'PAGO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (5, 1, 500, 1);

insert into pedido (id, cliente_id, data_criacao, total, status) values (6, 2, date_sub(sysdate(), interval 2 day), 500, 'PAGO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (5, 1, 500, 1);

insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into pagamento( pedido_id, status, tipo_pagamento, data_vencimento, codigo_barras) values (3, 'RECEBIDO', 'boleto', sysdate(), "12345");

insert into nota_fiscal ( pedido_id, xml, data_emissao ) values ( 2, '<xml />', sysdate() );

insert into categoria (nome) values ("Eletrônicos");
insert into categoria (nome) values ("Eletrodomésticos");
insert into categoria (nome) values ("Livros");
insert into categoria (nome) values ("Esportes");
insert into categoria (nome) values ("Futebol");
insert into categoria (nome) values ("Natação");
insert into categoria (nome) values ("Notebooks");
insert into categoria (nome) values ("Smartphones");
insert into categoria (nome) values ('Câmeras');

insert into produto_categoria (produto_id, categoria_id) values (1,1), (2,1);
insert into produto_categoria (produto_id, categoria_id) values (4, 9);
insert into produto_categoria (produto_id, categoria_id) values (5, 9);

insert into produto_loja (id, nome, preco, data_criacao, descricao) values (101, 'Kindle', 799.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto_loja (id, nome, preco, data_criacao, descricao) values (103, 'Câmera GoPro Hero 7', 1500.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor.');
insert into produto_loja (id, nome, preco, data_criacao, descricao) values (104, 'Câmera Canon 80D', 3500.0, sysdate(), 'O melhor ajuste de foco.');
insert into produto_loja (id, nome, preco, data_criacao, descricao) values (105, 'Microfone de Lapela', 50.0, sysdate(), 'Produto massa');

insert into ecm_produto (prd_id, prd_nome, prd_preco, prd_data_criacao, prd_descricao) values (201, 'Kindle', 799.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into ecm_produto (prd_id, prd_nome, prd_preco, prd_data_criacao, prd_descricao) values (203, 'Câmera GoPro Hero 7', 1500.0, date_sub(sysdate(), interval 1 day), 'Desempenho 2x melhor.');
insert into ecm_produto (prd_id, prd_nome, prd_preco, prd_data_criacao, prd_descricao) values (204, 'Câmera Canon 80D', 3500.0, sysdate(), 'O melhor ajuste de foco.');
insert into ecm_produto (prd_id, prd_nome, prd_preco, prd_data_criacao, prd_descricao) values (205, 'Microfone de Lapela', 50.0, sysdate(), 'Produto massa');

insert into erp_produto (id, nome, preco, descricao) values (301, 'Kindle', 799.0, 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into erp_produto (id, nome, preco, descricao) values (303, 'Câmera GoPro Hero 7', 1500.0, 'Desempenho 2x melhor.');
insert into erp_produto (id, nome, preco, descricao) values (304, 'Câmera Canon 80D', 3500.0, 'O melhor ajuste de foco.');
insert into erp_produto (id, nome, preco, descricao) values (305, 'Microfone de Lapela', 50.0, 'Produto massa');

insert into ecm_categoria (cat_id, cat_nome) values (201, 'Eletrodomésticos');
insert into ecm_categoria (cat_id, cat_nome) values (202, 'Livros');
insert into ecm_categoria (cat_id, cat_nome) values (203, 'Esportes');
insert into ecm_categoria (cat_id, cat_nome) values (204, 'Futebol');
insert into ecm_categoria (cat_id, cat_nome) values (205, 'Natação');
insert into ecm_categoria (cat_id, cat_nome) values (206, 'Notebooks');
insert into ecm_categoria (cat_id, cat_nome) values (207, 'Smartphones');
insert into ecm_categoria (cat_id, cat_nome) values (208, 'Câmeras');

drop function if exists acima_media_faturamento;
create function acima_media_faturamento(valor double) returns boolean reads sql data return valor > (select avg(total) from pedido);
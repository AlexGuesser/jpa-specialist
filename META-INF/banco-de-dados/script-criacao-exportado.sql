
    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

    create table categoria (
        categoria_pai_id integer,
        id integer not null auto_increment,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente (
        id integer not null auto_increment,
        cpf varchar(14) not null,
        nome varchar(100) not null,
        primary key (id)
    ) engine=InnoDB;

    create table cliente_contato (
        cliente_id integer not null,
        descricao varchar(255),
        tipo varchar(255) not null,
        primary key (cliente_id, tipo)
    ) engine=InnoDB;

    create table cliente_detalhe (
        cliente_id integer not null,
        data_nascimento date,
        sexo_cliente enum ('FEMININO','MASCULINO') not null,
        primary key (cliente_id)
    ) engine=InnoDB;

    create table estoque (
        id integer not null auto_increment,
        produto_id integer not null,
        quantidade integer,
        primary key (id)
    ) engine=InnoDB;

    create table item_pedido (
        pedido_id integer not null,
        preco_produto decimal(38,2) not null,
        produto_id integer not null,
        quantidade integer not null,
        primary key (pedido_id, produto_id)
    ) engine=InnoDB;

    create table nota_fiscal (
        pedido_id integer not null,
        data_emissao datetime(6) not null,
        xml blob not null,
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pagamento (
        pedido_id integer not null,
        status enum ('CANCELADO','PROCESSANDO','RECEBIDO') not null,
        tipo_pagamento varchar(31) not null,
        numero_cartao varchar(50),
        codigo_barras varchar(100),
        primary key (pedido_id)
    ) engine=InnoDB;

    create table pedido (
        cliente_id integer not null,
        estado varchar(2),
        id integer not null auto_increment,
        total decimal(38,2) not null,
        data_conclussao datetime(6),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        cep varchar(9),
        numero varchar(10),
        status enum ('AGUARDANDO','CANCELADO','PAGO','RECEBIDO') not null,
        bairro varchar(50),
        cidade varchar(50),
        complemento varchar(50),
        logradouro varchar(100),
        primary key (id)
    ) engine=InnoDB;

    create table produto (
        id integer not null auto_increment,
        preco decimal(10,2),
        data_criacao datetime(6) not null,
        data_ultima_atualizacao datetime(6),
        nome varchar(100) not null,
        descricao text,
        foto tinyblob,
        primary key (id)
    ) engine=InnoDB;

    create table produto_atributo (
        produto_id integer not null,
        nome varchar(100) not null,
        valor varchar(255)
    ) engine=InnoDB;

    create table produto_categoria (
        categoria_id integer not null,
        produto_id integer not null
    ) engine=InnoDB;

    create table produto_tag (
        produto_id integer not null,
        tag varchar(50) not null
    ) engine=InnoDB;

    alter table categoria 
       add constraint unq_nome unique (nome);

    create index idx_nome 
       on cliente (nome);

    alter table cliente 
       add constraint unq_cpf unique (cpf);

    alter table estoque 
       add constraint UK_g72w2sa50w9a647f0eyhogus5 unique (produto_id);

    create index idx_nome 
       on produto (nome);

    alter table produto 
       add constraint unq_nome unique (nome);

    alter table categoria 
       add constraint fk_categoria_categoria 
       foreign key (categoria_pai_id) 
       references categoria (id);

    alter table cliente_contato 
       add constraint fk_cliente_contato_contato 
       foreign key (cliente_id) 
       references cliente (id);

    alter table cliente_detalhe 
       add constraint fk_cliente_detalhe_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table estoque 
       add constraint fk_estoque_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table item_pedido 
       add constraint fk_item_pedido_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table item_pedido 
       add constraint fk_item_pedido_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table nota_fiscal 
       add constraint fk_nota_fiscal_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pagamento 
       add constraint fk_pagamento_pedido 
       foreign key (pedido_id) 
       references pedido (id);

    alter table pedido 
       add constraint fk_pedido_cliente 
       foreign key (cliente_id) 
       references cliente (id);

    alter table produto_atributo 
       add constraint fk_produto_atributo_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_categoria 
       foreign key (categoria_id) 
       references categoria (id);

    alter table produto_categoria 
       add constraint fk_produto_categoria_produto 
       foreign key (produto_id) 
       references produto (id);

    alter table produto_tag 
       add constraint fk_produto_tag_produto 
       foreign key (produto_id) 
       references produto (id);
insert into produto (nome, preco, data_criacao, descricao) values ('Kindle', 499.0, date_sub(sysdate(), interval 1 day), 'Conheça o novo Kindle, agora com iluminação embutida ajustável, que permite que você leia em ambientes abertos ou fechados, a qualquer hora do dia.');
insert into produto (nome, preco, data_criacao, descricao) values ('PS5', 3799.99, date_sub(sysdate(), interval 1 day), 'O melhor console!');
insert into cliente(id, nome, cpf) values (1, "Alex Guesser", "123456456"), (2, "Nicolle Raitz Wilvert", "12421234123");
insert into cliente_detalhe(cliente_id, sexo_cliente) values (1, "MASCULINO"), (2, "FEMININO");
insert into pedido (id, cliente_id, data_criacao, total, status) values (1, 1, sysdate(), 998.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (1, 1, 499.0, 2);
insert into pedido (id, cliente_id, data_criacao, total, status) values (2, 1, sysdate(), 449.0, 'AGUARDANDO');
insert into item_pedido (pedido_id, produto_id, preco_produto, quantidade) values (2, 1, 499.0, 1);
insert into pagamento( pedido_id, status, numero_cartao, tipo_pagamento) values (2, 'PROCESSANDO', '123', 'cartao');
insert into categoria (id, nome) values (1, "Eletrônicos");

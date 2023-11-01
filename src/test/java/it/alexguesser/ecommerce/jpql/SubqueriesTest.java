package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.ItemPedido;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class SubqueriesTest extends BaseTest {

    @Test
    public void pesquisarSubqueries() {
        // Bons clientes, V1
        String jpql = """
                select c from Cliente c
                join c.pedidos p
                where (
                    select sum (p.total) from Pedido p
                    where p.cliente = c
                ) > 100
                """;
        // Bons clientes, V2
//        String jpql = """
//                select c from Cliente c
//                join c.pedidos p
//                where (
//                    select sum (p.total) from c.pedidos p
//                ) > 100
//                """;
        // Todos os pedidos acima da média de vendas
//        String jpql = """
//                select p from Pedido p
//                where p.total > (
//                    select avg(total) from Pedido
//                )
//                """;
        // O produto ou os produtos mais caros da base
//        String jpql = """
//                select p from Produto p
//                where p.preco = (
//                    select max(preco) from Produto
//                    )
//                """;

        TypedQuery<Cliente> typedQuery = entityManager.createQuery(jpql, Cliente.class);

        List<Cliente> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void pesquisarComIn() {
        String jpql = """
                select p from Pedido p
                where p.id in (
                    select p2.id from Pedido p2
                    join p2.itemPedidos i2
                    join i2.produto prod2
                    where prod2.preco > 100
                )
                """;

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(obj -> System.out.println("ID: " + obj.getId()));
    }

    @Test
    public void pesquisarComExist() {
        // DE FORMA SIMILAR AO EXISTS, PORÉM COM A LÓGICA OPOSTA, EXISTE O NOT EXISTS
        String jpql = """
                select p from Produto p
                where exists
                (
                    select 1 from ItemPedido i2
                    join i2.produto p2
                    where p2 = p
                )
                """;

        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);
        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(obj -> System.out.println("ID: " + obj.getId()));
    }

    // EXERCÍCIO 1
    // TODOS OS PEDIDOS COM PRODUTO DE ID ESPECIFICADO
    @Test
    public void exercicioIn() {
        String jpql = """
                select p from Pedido p
                where id in
                (
                    select p2.id from Pedido p2
                    join p2.itemPedidos i2
                    join i2.produto prod2
                    where prod2.id = :prodId
                )
                """;
        Integer id = 1;

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        typedQuery.setParameter("prodId", id);
        List<Pedido> pedidos = typedQuery.getResultList();

        pedidos.forEach(System.out::println);
    }

    // EXERCÍCIO 2
    // TODOS OS CLIENTES QUE FIZERAM DOIS OU MAIS PEDIDOS
    @Test
    public void clientesComDoisOuMaisPedidos() {
        String jpql = """
                    select c2 from Cliente c2
                    join c2.pedidos p2
                    group by c2
                    having count(c2) >= 2
                """;

        TypedQuery<Cliente> typedQuery = entityManager.createQuery(jpql, Cliente.class);
        List<Cliente> clientes = typedQuery.getResultList();

        assertFalse(clientes.isEmpty());
        clientes.forEach(System.out::println);
    }

    // EXERCÍCIO 2
    // TODOS OS CLIENTES QUE FIZERAM DOIS OU MAIS PEDIDOS
    @Test
    public void perquisarComSubqueryExercicio() {
        String jpql = "select c from Cliente c where " +
                " (select count(cliente) from Pedido where cliente = c) >= 2";

        TypedQuery<Cliente> typedQuery = entityManager.createQuery(jpql, Cliente.class);

        List<Cliente> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());

        lista.forEach(obj -> System.out.println("ID: " + obj.getId()));
    }

    // EXERCÍCIO 3
    // TODOS OS PRODUTOS QUE NÃO FORAM VENDIDOS APÓS AUMENTO DE PREÇOL
    @Test
    public void exercicio3() {
        String jpql = """
                select p from Produto p
                where exists
                (   select ip.produto from ItemPedido ip
                    where ip.precoProduto < p.preco and ip.produto = p
                )
                """;

        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);

        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());

        lista.forEach(System.out::println);
    }

    @Test
    public void pesquisarComAll() {
        // DETALHE IMPORTANTE SOBRE O ALL, SE A TABELA NA SUBQUERIE FOR VAZIA, O RESULTADO É TRUE!

        String todosItemPedidos = """
                select ip from ItemPedido ip
                """;
        TypedQuery<ItemPedido> query = entityManager.createQuery(todosItemPedidos, ItemPedido.class);
        List<ItemPedido> itemPedidos = query.getResultList();
        itemPedidos.forEach(System.out::println);

        // TODOS OS PRODUTOS QUE SEMPRE FORAM VENDIDOS PELO PREÇO ATUAL
        String jpql = """
                select p from Produto p
                where
                p.preco = ALL
                (
                    select precoProduto from ItemPedido where  produto = p
                )
                """;

        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);

        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());

        lista.forEach(System.out::println);
    }

    @Test
    public void pesquisarComAny() {

        // ANY == SOME (OS DOIS COMANDOS FAZEM A MESMA COISA)

        // TODOS OS PRODUTOS QUE JÁ FORAM VENDIDOS, PELO MENOS UMA VEZ, POR UM PREÇO DIFERENTE DO PREÇO ATUAL
        String jpql = """
                select p from Produto p
                where p.preco = ANY
                (
                    select precoProduto from ItemPedido where  produto = p
                )
                """;

        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);

        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());

        lista.forEach(System.out::println);
    }

    @Test
    public void desafioAll() {
        // TODOS OS PRODUTOS QUE SEMPRE FORAM VENDIDOS PELO MESMO PREÇO
        String jpql = """
                select p from Produto p
                join p.itemPedidos ip
                group by p
                having max(ip.precoProduto) = min(ip.precoProduto)
                """;

        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);

        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());

        lista.forEach(System.out::println);
    }

}

package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Cliente;
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

    // EXERCÍCIO
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

}

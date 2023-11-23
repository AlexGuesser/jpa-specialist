package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.EntityManagerTest;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class GroupByTest extends EntityManagerTest {

    @Test
    public void agruparResultado() {


        // Quantidade de produtos por categoria
        //        String jpql = """
        //                select c.nome, count(p.id) from Categoria c
        //                join c.produtos p
        //                group by c.id
        //                """;
        //Total de vendas por mês
        //        String jpql = """
        //                select concat(year(p.dataCriacao), '/', month(p.dataCriacao)), sum(p.total)
        //                from Pedido p
        //                group by year(p.dataCriacao), month(p.dataCriacao)
        //                """;

        //Total de vendas por categoria
        //        String jpql = """
        //                select c.nome, sum(ip.precoProduto)
        //                from ItemPedido ip join ip.produto prod
        //                join prod.categorias c
        //                group by c.id
        //                """;

        // Total de vendas por cliente
        //        String jpql = """
        //                select c.nome, sum(p.total) from Pedido p join p.cliente c
        //                group by c.id
        //                """;
        // Total de vendas por dia e por categoria
        String jpql = """
                select date(p.dataCriacao), c.nome, sum(p.total)
                from Categoria c
                join c.produtos prod
                join prod.itemPedidos ip
                join ip.pedido p
                group by date(p.dataCriacao), c.id
                order by p.dataCriacao ASC
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + ", " + arr[1] + ", " + arr[2]));
    }

    @Test
    public void agruparEFiltrarResultado() {


        // Total de vendas por mês do ano corrente
        String jpql = """
                select concat(year(p.dataCriacao), '/', month(p.dataCriacao)), sum(p.total)
                from Pedido p
                where year(p.dataCriacao) = year(current_date)
                group by year(p.dataCriacao), month(p.dataCriacao)
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + ", " + arr[1]));
    }

    @Test
    public void testandoHaving() {
        String jpql = """
                select cat.nome, sum(ip.precoProduto)
                from ItemPedido ip
                join ip.produto pro
                join pro.categorias cat
                group by cat.id
                having sum(ip.precoProduto) >= 2000
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + ", " + arr[1]));
    }

}

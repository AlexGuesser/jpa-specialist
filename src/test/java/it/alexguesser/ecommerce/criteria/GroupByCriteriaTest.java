package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.*;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.*;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class GroupByCriteriaTest extends EntityManagerTest {

    @Test
    public void agruparResultadoComFuncoes() {
        //         Total de vendas por mês.
        //        String jpql = "select concat(year(p.dataCriacao), '/', function('monthname', p.dataCriacao)), sum(p.total) " +
        //                " from Pedido p " +
        //                " group by year(p.dataCriacao), month(p.dataCriacao) ";

        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> criteriaQuery = criteriaBuilder.createQuery(Object[].class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        Expression<Integer> anoCriacaoPedido = criteriaBuilder
                .function("year", Integer.class, root.get(Pedido_.dataCriacao));
        Expression<Integer> mesCriacaoPedido = criteriaBuilder
                .function("month", Integer.class, root.get(Pedido_.dataCriacao));
        Expression<String> nomeMesCriacaoPedido = criteriaBuilder
                .function("monthname", String.class, root.get(Pedido_.dataCriacao));

        Expression<String> anoMesConcat = criteriaBuilder.concat(
                criteriaBuilder.concat(
                        anoCriacaoPedido.as(String.class),
                        "/"),
                nomeMesCriacaoPedido
        );

        criteriaQuery.multiselect(
                anoMesConcat,
                criteriaBuilder.sum(root.get(Pedido_.total))
        );

        criteriaQuery.groupBy(anoCriacaoPedido, mesCriacaoPedido);

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Object[]> lista = typedQuery.getResultList();

        lista.forEach(arr -> System.out.println("Ano/Mês: " + arr[0] + ", Sum: " + arr[1]));
    }

    @Test
    public void agruparResultado1() {
        // TOTAL DE VENDAS POR CATEGORIA
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> criteriaQuery = criteriaBuilder.createQuery(Object[].class);
        Root<ItemPedido> root = criteriaQuery.from(ItemPedido.class);
        Join<ItemPedido, Produto> joinProduto = root.join(ItemPedido_.PRODUTO);
        Join<Produto, Categoria> joinCategoria = joinProduto.join(Produto_.CATEGORIAS);

        criteriaQuery.multiselect(
                joinCategoria.get(Categoria_.NOME),
                criteriaBuilder.sum(
                        criteriaBuilder.prod(root.get(ItemPedido_.quantidade), root.get(ItemPedido_.precoProduto))
                )
        );
        criteriaQuery.groupBy(joinCategoria.get(Categoria_.ID));

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(
                c -> System.out.println("Categoria: " + c[0] + " , Valor total vendido: " + c[1])
        );

    }

    @Test
    public void agruparResultado2() {
        // QUANTIDADE DE PRODUTOS POR CATEGORIA
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> criteriaQuery = criteriaBuilder.createQuery(Object[].class);
        Root<Categoria> root = criteriaQuery.from(Categoria.class);
        Join<Categoria, Produto> joinProduto = root.join(Categoria_.PRODUTOS);

        criteriaQuery.multiselect(
                root.get(Categoria_.NOME),
                criteriaBuilder.count(joinProduto.get(Produto_.ID))
        );
        criteriaQuery.groupBy(root.get(Categoria_.ID));

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(
                c -> System.out.println("Categoria: " + c[0] + " , quantidade de produtos: " + c[1])

        );
    }

    @Test
    public void agruparResultado3() {
        // TOTAL DE VENDAS POR CLIENTE
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> criteriaQuery = criteriaBuilder.createQuery(Object[].class);
        Root<Cliente> root = criteriaQuery.from(Cliente.class);
        Join<Cliente, Pedido> joinPedido = root.join(Cliente_.PEDIDOS);

        criteriaQuery.multiselect(
                root.get(Cliente_.NOME),
                criteriaBuilder.sum(joinPedido.get(Pedido_.TOTAL))
        );
        criteriaQuery.groupBy(root.get(Cliente_.ID));

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(
                c -> System.out.println("Cliente: " + c[0] + " , valor total de compras: " + c[1])

        );
    }

    @Test
    public void groupByComHaving() {
        // Total de vendas dentre as categorias que mais vendem." having sum(ip.precoProduto) > 100 ";
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> criteriaQuery = criteriaBuilder.createQuery(Object[].class);
        Root<ItemPedido> root = criteriaQuery.from(ItemPedido.class);
        Join<ItemPedido, Produto> joinProduto = root.join(ItemPedido_.produto);
        Join<Produto, Categoria> joinProdutoCategoria = joinProduto.join(Produto_.categorias);
        Expression<? extends Number> valorTotalProduto = criteriaBuilder.prod(
                root.get(ItemPedido_.quantidade),
                root.get(ItemPedido_.precoProduto));

        criteriaQuery.multiselect(
                joinProdutoCategoria.get(Categoria_.nome),
                criteriaBuilder.sum(valorTotalProduto),
                criteriaBuilder.avg(valorTotalProduto)
        );

        criteriaQuery.groupBy(joinProdutoCategoria.get(Categoria_.id));

        criteriaQuery.having(
                criteriaBuilder.greaterThan(
                        criteriaBuilder.avg(valorTotalProduto).as(BigDecimal.class),
                        new BigDecimal(700)));

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Object[]> lista = typedQuery.getResultList();

        lista.forEach(arr -> System.out.println(
                "Nome categoria: " + arr[0]
                        + ", SUM: " + arr[1]
                        + ", AVG: " + arr[2]));
    }


}

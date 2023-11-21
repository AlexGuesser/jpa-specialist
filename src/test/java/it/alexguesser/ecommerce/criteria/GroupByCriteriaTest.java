package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.*;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Root;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class GroupByCriteriaTest extends BaseTest {

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


}

package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.*;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.*;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class JoinCriteriaTest extends BaseTest {

    @Test
    public void fazerJoin() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pagamento> criteriaQuery = criteriaBuilder.createQuery(Pagamento.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        Join<Pedido, Pagamento> joinPagamento = root.join("pagamento");
        // É POSSÍVEL FAZER MULTIPLOS JOINS USANDO INCLUSIVE OUTROS JOINS
        //Join<Pedido, ItemPedido> joinItens = root.join("itemPedidos");
        //Join<Pedido, Produto> joinProduto = joinItens.join("produto");

        // PROJETANDO APENAS PAGAMENTO USANDO O JOIN
        criteriaQuery.select(joinPagamento);
        // FILTRANDO USANDO O JOIN
        criteriaQuery.where(criteriaBuilder.equal(joinPagamento.get("status"), StatusPagamento.PROCESSANDO));


        TypedQuery<Pagamento> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pagamento> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void fazerJoinComOn() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pagamento> criteriaQuery = criteriaBuilder.createQuery(Pagamento.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);
        Join<Pedido, Pagamento> joinPagamento = root.join("pagamento");
        joinPagamento.on(criteriaBuilder.equal(joinPagamento.get("status"), StatusPagamento.PROCESSANDO));

        criteriaQuery.select(joinPagamento);

        TypedQuery<Pagamento> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pagamento> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void fazendoLeftJoin() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pagamento> criteriaQuery = criteriaBuilder.createQuery(Pagamento.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);
        // ROOT(PEDIDO) É A TABELA AO LADO ESQUERDO AQUI
        Join<Pedido, Pagamento> joinPagamento = root.join("pagamento", JoinType.LEFT);

        criteriaQuery.select(joinPagamento);

        TypedQuery<Pagamento> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pagamento> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void usarJoinFetch() {
        // JOIN FETCH É USADO PARA TRAZER MAIS DADOS EM UM QUERY SÓ
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);
        // COMO ESSE fetch TODAS AS INFORMAÇÕES DE ITEM PEDIDOS VEM EM UMA SÓ QUERY
        root.fetch("itemPedidos"); // JOIN TYPE PADRÃO É INNER
        root.fetch("notaFiscal", JoinType.LEFT);
        // FETCH TAMBÉM PODE SER USADO COMO JOIN SENDO POSSÍVEL SELECIONAR O ATRIBUTO NO SELECT
        //Join<Pedido, Cliente> joinFetch = (Join<Pedido, Cliente>) root.<Pedido, Cliente>fetch("cliente");

        criteriaQuery
                .select(root)
                .where(criteriaBuilder.equal(root.get("id"), 1));

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        Pedido pedido = typedQuery.getSingleResult();
        assertNotNull(pedido);
        assertFalse(pedido.getItemPedidos().isEmpty());
    }

    @Test
    public void buscarPedidosComProdutoEspecifico() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> pedidoRoot = criteriaQuery.from(Pedido.class);
        Join<Pedido, ItemPedido> joinFetchItemPedido =
                (Join<Pedido, ItemPedido>) pedidoRoot.<Pedido, ItemPedido>fetch(Pedido_.ITEM_PEDIDOS);
        Integer produtoId = 1;

        criteriaQuery.where(
                criteriaBuilder.equal(joinFetchItemPedido.get(ItemPedido_.PRODUTO).get(Produto_.ID), produtoId)
        );

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

}

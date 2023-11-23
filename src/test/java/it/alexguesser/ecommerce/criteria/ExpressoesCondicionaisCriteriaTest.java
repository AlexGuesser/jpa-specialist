package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.*;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class ExpressoesCondicionaisCriteriaTest extends EntityManagerTest {

    @Test
    public void usarExpressaoIn() {
        List<Integer> ids = Arrays.asList(1, 2, 3);
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        criteriaQuery.where(
                root.get(Pedido_.id).in(ids));

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarExpressaoIn2() {
        Cliente cliente1 = entityManager.find(Cliente.class, 1);
        Cliente cliente2 = new Cliente();
        cliente2.setId(2);
        List<Cliente> clientes = Arrays.asList(cliente1, cliente2);
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        criteriaQuery.where(
                root.get(Pedido_.cliente).in(clientes));

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarExpressaoCase() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> criteriaQuery = criteriaBuilder.createQuery(Object[].class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        criteriaQuery.multiselect(
                root.get(Pedido_.id),
                criteriaBuilder.selectCase(root.get(Pedido_.status))
                        .when(StatusPedido.PAGO, "Foi pago.")
                        .when(StatusPedido.AGUARDANDO, "Está aguardando.")
                        .otherwise(root.get(Pedido_.status)).as(String.class),
                criteriaBuilder.selectCase(root.get(Pedido_.pagamento).type().as(String.class))
                        .when("boleto", "Foi pago com boleto.")
                        .when("cartao", "Foi pago com cartão")
                        .otherwise("Não identificado")
//                criteriaBuilder.selectCase(root.get(Pedido_.pagamento).type())
//                        .when(PagamentoBoleto.class, "Foi pago com boleto.")
//                        .when(PagamentoCartao.class, "Foi pago com cartão")
//                        .otherwise("Não identificado")
        );

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(criteriaQuery);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());

        lista.forEach(arr -> System.out.println(arr[0] + ", " + arr[1] + ", " + arr[2]));
    }

    @Test
    public void usarExpressaoCondicionalLike() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Cliente> criteriaQuery = criteriaBuilder.createQuery(Cliente.class);
        Root<Cliente> root = criteriaQuery.from(Cliente.class);

        criteriaQuery.where(
                criteriaBuilder.like(root.get(Cliente_.NOME), "A%")
        );

        TypedQuery<Cliente> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Cliente> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarIsNull() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Produto> criteriaQuery = criteriaBuilder.createQuery(Produto.class);
        Root<Produto> root = criteriaQuery.from(Produto.class);

        criteriaQuery.where(criteriaBuilder.isNull(root.get(Produto_.FOTO)));
        //criteriaQuery.where(criteriaBuilder.isNotNull(root.get(Produto_.FOTO)));
        //criteriaQuery.where(root.get(Produto_.FOTO).isNull());

        TypedQuery<Produto> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarIsEmpty() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Produto> criteriaQuery = criteriaBuilder.createQuery(Produto.class);
        Root<Produto> root = criteriaQuery.from(Produto.class);

        criteriaQuery.where(criteriaBuilder.isEmpty(root.get(Produto_.CATEGORIAS)));
        //criteriaQuery.where(criteriaBuilder.isNotEmpty(root.get(Produto_.CATEGORIAS)));

        TypedQuery<Produto> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarMaiorEMenor() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Produto> criteriaQuery = criteriaBuilder.createQuery(Produto.class);
        Root<Produto> root = criteriaQuery.from(Produto.class);

        criteriaQuery.where(
                criteriaBuilder.greaterThan(root.get(Produto_.PRECO), new BigDecimal("799.00")),
                criteriaBuilder.lessThan(root.get(Produto_.PRECO), new BigDecimal("1500.00")));
        //criteriaQuery.where(criteriaBuilder.greaterThanOrEqualTo(root.get(Produto_.PRECO), new BigDecimal("799.00")));

        TypedQuery<Produto> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarMaiorEMenorComDatas() {
        // DESAFIO: TRAZER TODOS OS PEDIDOS DOS ÚLTIMOS 3 DIAS
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        criteriaQuery.where(
                criteriaBuilder.greaterThanOrEqualTo(
                        root.get(Pedido_.DATA_CRIACAO),
                        LocalDateTime.now().minusDays(3).truncatedTo(ChronoUnit.DAYS)));

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarBetween() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        criteriaQuery.where(
                criteriaBuilder.between(
                        root.get(Pedido_.TOTAL),
                        new BigDecimal("500"),
                        new BigDecimal("3500.0")));

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void usarExpressaoDiferente() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        criteriaQuery.where(
                criteriaBuilder.notEqual(root.get(Pedido_.TOTAL), new BigDecimal("500")));


        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

}

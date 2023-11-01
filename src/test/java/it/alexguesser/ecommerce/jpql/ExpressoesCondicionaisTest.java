package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class ExpressoesCondicionaisTest extends BaseTest {

    @Test
    public void usarExpressaoCondicionalLike() {
        String jpql = "select c from Cliente c where c.nome like concat(:nome, '%')";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("nome", "Alex");

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarIsNull() {
        String jpql = "select p from Produto p where p.foto is null";
        //String jpql = "select p from Produto p where p.foto is not null";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarIsEmpty() {
        String jpql = "select p from Produto p where p.categorias is empty";
        //String jpql = "select p from Produto p where p.categorias is not empty";

        // SQL GERADO:
        /*
        select
            p1_0.id,
            p1_0.data_criacao,
            p1_0.data_ultima_atualizacao,
            p1_0.descricao,
            p1_0.foto,
            p1_0.nome,
            p1_0.preco
        from
            produto p1_0
        where
            not exists(select
                            1
                       from
                            produto_categoria c1_0
                       where
                            p1_0.id=c1_0.produto_id)
         */

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarMaiorMenor() {
        String jpql = "select p from Produto p where p.preco > :preco";
        //String jpql = "select p from Produto p where p.preco >= :preco";
        //String jpql = "select p from Produto p where p.preco < :preco";
        //String jpql = "select p from Produto p where p.preco <= :preco";
        //String jpql = "select p from Produto p where p.preco >= :precoInicial and p.preco <= :precoFinal";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("preco", new BigDecimal("499"));

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }


    @Test
    public void pegarPedidosDosDoisUltimosDias() {
        String jpql = "select p from Pedido p where p.dataCriacao >= :data";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        LocalDateTime localDateTime = LocalDateTime.now().minusDays(2).truncatedTo(ChronoUnit.DAYS);
        typedQuery.setParameter(
                "data",
                localDateTime);
        List<Pedido> pedidos = typedQuery.getResultList();
    }

    @Test
    public void usarBetween() {
        String jpql = "select p from Produto p where p.preco between :precoInicial and :precoFinal";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("precoInicial", new BigDecimal("499"));
        typedQuery.setParameter("precoFinal", new BigDecimal("1400"));

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarBetweenComDatas() {
        String jpql = "select p from Pedido p where p.dataCriacao between :dataInicial and :dataFinal";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        typedQuery.setParameter("dataInicial", LocalDateTime.now().minusDays(3));
        typedQuery.setParameter("dataFinal", LocalDateTime.now());

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usarExpressaoDiferente() {
        String jpql = "select p from Produto p where p.id <> 1";

        TypedQuery<Produto> typedQuery = entityManager.createQuery(jpql, Produto.class);

        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }


    @Test
    public void usarExpressaoCase() {
        String jpql = """
                select p.id,
                case p.status
                    when 'PAGO' then 'Está pago'
                    when 'CANCELADO' then 'Foi cancelado!'
                    else 'Está aguardando'
                end,
                case type(p.pagamento)
                    when PagamentoBoleto then 'Pago com boleto'
                    when PagamentoCartao then 'Pago com cartão'
                    else 'Não foi pago ainda'
                end
                from Pedido p
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + ", " + arr[1] + ", " + arr[2]));
    }

    @Test
    public void usarExpressaoIn() {
        List<Integer> listaIds = Arrays.asList(1, 3, 4);
        String jpql = "select p from Pedido p where p.id in (:listaIds)";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        typedQuery.setParameter("listaIds", listaIds);

        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

}

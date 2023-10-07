package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Pedido;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class JoinTest extends BaseTest {

    @Test
    public void innerJoin() {
        // PODEMOS TAMBÉM COLOCAR O `ON` DENTRO DO JPQL E COLOCAR FILTROS MAIS ESPECIFÍCOS LÁ
        // PARA OS FILTROS PADRÕES POR ID NÃO É NECESSÁRIO, É FEITO DE FORMA AUTOMÁTICA
        String jpql = """
                select p, pag from Pedido p
                inner join p.pagamento pag
                where pag.status = 'PROCESSANDO'
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void leftJoin() {
        String jpql = """
                select p, pag from Pedido p
                left join p.pagamento pag
                on (pag.status = 'PROCESSANDO')
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);

        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void usandoJoinFetch() {
        // JOIN FETCH AQUI FAZ COM EM UMA ÚNICA CHAMADA AO BANCO A GENTE TAMBÉM BUSQUE OS DADOS DE item_pedido
        // PODER SER USADO TAMBÉM COM LEFT JOIN
        // ESSE JOIN FETCH AJUDA A RESOLVER O PROBLEMA DE N+1!
        String jpql = """
                select p from Pedido p
                join fetch p.itemPedidos where p.id = 1
                """;

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        List<Pedido> pedidos = typedQuery.getResultList();
        assertFalse(pedidos.isEmpty());
    }

}

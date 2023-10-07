package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.NotaFiscal;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.StatusPagamento;
import jakarta.persistence.TemporalType;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class PassandoParametrosTest extends BaseTest {

    @Test
    public void passarParametro() {
//        String jpql = """
//                select p from Pedido p join p.pagamento pag
//                where p.id = ?1 and pag.status = ?2
//                """;

        String jpql = """
                select p from Pedido p join p.pagamento pag
                where p.id = :pedidoId and pag.status = :pagamentoStatus
                """;

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
//        typedQuery.setParameter(1, 2);
//        typedQuery.setParameter(2, StatusPagamento.PROCESSANDO);
        typedQuery.setParameter("pedidoId", 2);
        typedQuery.setParameter("pagamentoStatus", StatusPagamento.PROCESSANDO);
        List<Pedido> lista = typedQuery.getResultList();
        assertEquals(1, lista.size());
    }

    @Test
    public void passarParametroDate() {
        String jpql = """
                select nf from NotaFiscal nf
                where nf.dataEmissao <= ?1
                """;

        TypedQuery<NotaFiscal> typedQuery = entityManager.createQuery(jpql, NotaFiscal.class);
        typedQuery.setParameter(1, new Date(), TemporalType.TIMESTAMP);
        List<NotaFiscal> lista = typedQuery.getResultList();
        assertEquals(1, lista.size());
    }

}

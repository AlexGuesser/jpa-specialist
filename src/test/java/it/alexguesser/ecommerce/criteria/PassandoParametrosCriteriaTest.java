package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.NotaFiscal;
import it.alexguesser.ecommerce.model.Pedido;
import jakarta.persistence.TemporalType;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.ParameterExpression;
import jakarta.persistence.criteria.Root;
import org.junit.jupiter.api.Test;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

public class PassandoParametrosCriteriaTest extends EntityManagerTest {

    @Test
    public void passarParametro() {
        /*
        ESSE FORMA DE PASSAR PARÂMETROS NÃO É MUITO USADA
        A FORMA NORMAL E MAIS NATURAL DE PASSAR PARÂMETROS JÁ EVITA SQL INJECTION
         */
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        ParameterExpression<Integer> parameterExpressionId = criteriaBuilder.parameter(Integer.class);
        //ParameterExpression<Integer> parameterExpressionId = criteriaBuilder.parameter(Integer.class, "id";
        criteriaQuery
                .select(root)
                .where(criteriaBuilder.equal(root.get("id"), parameterExpressionId));

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        typedQuery.setParameter(parameterExpressionId, 1);
        //typedQuery.setParameter("id", 1);
        Pedido pedido = typedQuery.getSingleResult();
        assertNotNull(pedido);
    }

    @Test
    public void passarParametroDate() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<NotaFiscal> criteriaQuery = criteriaBuilder.createQuery(NotaFiscal.class);
        Root<NotaFiscal> root = criteriaQuery.from(NotaFiscal.class);

        ParameterExpression<Date> parameterExpression = criteriaBuilder.parameter(
                Date.class,
                "dataInicial");
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DATE, -30);
        Date dataInicial = c.getTime();
        criteriaQuery
                .where(criteriaBuilder.greaterThan(root.get("dataEmissao"), parameterExpression));

        TypedQuery<NotaFiscal> typedQuery = entityManager.createQuery(criteriaQuery);
        typedQuery.setParameter(parameterExpression, dataInicial, TemporalType.TIMESTAMP);
        List<NotaFiscal> lista = typedQuery.getResultList();
        assertNotNull(lista);
    }

}

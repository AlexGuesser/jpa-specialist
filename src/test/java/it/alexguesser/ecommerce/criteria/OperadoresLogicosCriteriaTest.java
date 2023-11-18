package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.Pedido_;
import it.alexguesser.ecommerce.model.StatusPedido;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class OperadoresLogicosCriteriaTest extends BaseTest {

    @Test
    public void usarOperadores() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);


        criteriaQuery.where(
                criteriaBuilder.greaterThan(root.get(Pedido_.TOTAL), new BigDecimal("499")),
                // PARA USAR O OPERADOR `AND` BASTA COLOCAR MAIS PARÂMETROS DENTRO DO WHERE
                criteriaBuilder.equal(root.get(Pedido_.STATUS), StatusPedido.PAGO));


        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

}

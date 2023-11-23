package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Pedido;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class OperadoresLogicosTest extends EntityManagerTest {


    @Test
    public void usarOperadores() {
//        String jpql = """
//                select p from Pedido p
//                where p.total > 500 and p.status = "AGUARDANDO" and p.cliente.id = 1
//                """;
        String jpql = """
                select p from Pedido p
                where (p.status = "AGUARDANDO" or p.status = "PAGO") and p.total > 500
                """;

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);

        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

}

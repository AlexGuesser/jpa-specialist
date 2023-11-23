package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Pedido;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class PathExpressionTest extends EntityManagerTest {

    @Test
    public void usarPathExpressions() {
        String jpql = "select p from Pedido p where p.cliente.nome = 'ALEX GUESSER'";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

    @Test
    public void buscarPedidoPorProduto() {
        // JOIN AQUI É NECESSÁRIO, NÃO DÁ PARA USAR PATH EXPRESSION COM COLEÇÕES
        String jpql = "select p from Pedido p join p.itemPedidos i where i.produto.id = 1";

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        List<Pedido> pedidos = typedQuery.getResultList();
        assertFalse(pedidos.isEmpty());
        assertEquals(1, pedidos.get(0).getItemPedidos().get(0).getProduto().getId());
    }

}

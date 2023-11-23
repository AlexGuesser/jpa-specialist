package it.alexguesser.ecommerce.conhecendooentitymanager;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.StatusPedido;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertNotNull;

public class CallbacksTest extends EntityManagerTest {

    @Test
    public void acionarCallbacks() {
        Cliente cliente = entityManager.find(Cliente.class, 1);

        Pedido pedido = new Pedido();
        pedido.setCliente(cliente);
        pedido.setStatus(StatusPedido.AGUARDANDO);

        entityManager.getTransaction().begin();
        entityManager.persist(pedido);
        entityManager.flush();
        pedido.setStatus(StatusPedido.RECEBIDO);
        entityManager.getTransaction().commit();

        entityManager.clear();
        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
        assertNotNull(pedidoVerificacao.getDataCriacao());
        assertNotNull(pedidoVerificacao.getDataUltimaAtualizacao());
    }

}

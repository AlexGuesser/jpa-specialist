package it.alexguesser.ecommerce.conhecendooentitymanager;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.StatusPedido;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class GerenciamentoTransacaoTest extends EntityManagerTest {

    @Test
    public void abrirFecharCancelarTransacao() {
        Assertions.assertThrows(
                RuntimeException.class,
                () -> {
                    try {
                        entityManager.getTransaction().begin();
                        metodoDeNegocio();
                        entityManager.getTransaction().commit();
                    } catch (Exception e) {
                        entityManager.getTransaction().rollback();
                        throw e;
                    }
                });
    }

    private void metodoDeNegocio() {
        Pedido pedido = entityManager.find(Pedido.class, 1);
        pedido.setStatus(StatusPedido.RECEBIDO);
        if (pedido.getPagamento() == null) {
            throw new RuntimeException("Pedido ainda não foi pago!");
        }
    }

}

package it.alexguesser.ecommerce.conhecendooentitymanager;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.StatusPedido;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class FlushTest extends BaseTest {

    @Test
    public void chamarFlush() {
        assertThrows(
                RuntimeException.class,
                () -> {
                    try {
                        entityManager.getTransaction().begin();
                        Pedido pedido = entityManager.find(Pedido.class, 1);
                        pedido.setStatus(StatusPedido.RECEBIDO);

                        // FLUSH FORÇA OS UPDATES DA MEMÓRIA PRO BANCO
                        //entityManager.flush();

                        Pedido pedidoDaMemoria = entityManager.find(Pedido.class, pedido.getId());
                        // JPQL NÃO USA O CACHE DE PRIMEIRO NÍVEL E FORÇAR UM FLUSH DE FORMA IMPLICÍTA!!!
                        Pedido pedidoDoBanco = entityManager
                                .createQuery("select p from pedido p where p.id = 1", Pedido.class)
                                .getSingleResult();
                        assertEquals(pedido.getStatus(), pedidoDaMemoria.getStatus());
                        assertEquals(pedido.getStatus(), pedidoDoBanco.getStatus());
                        if (pedido.getPagamento() == null) {
                            throw new RuntimeException("Pedido ainda não foi pago!");
                        }
                        entityManager.getTransaction().commit();
                    } catch (Exception e) {
                        entityManager.getTransaction().rollback();
                        throw e;
                    }
                });

    }
}

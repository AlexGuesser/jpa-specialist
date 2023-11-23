package it.alexguesser.ecommerce.mapeamentobasico;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.EnderecoEntregaPedido;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.StatusPedido;

public class MapeamentoObjetoEmbutidoTest extends EntityManagerTest {

    @Test
    public void analisarMapeamentoObjetoEmbutido() {
        EnderecoEntregaPedido enderecoEntregaPedido = new EnderecoEntregaPedido();
        enderecoEntregaPedido.setCep("88180-000");
        Cliente cliente = entityManager.find(Cliente.class, 1);

        Pedido pedido = new Pedido();
        pedido.setDataCriacao(LocalDateTime.now());
        pedido.setStatus(StatusPedido.AGUARDANDO);
        pedido.setTotal(new BigDecimal("1000"));
        pedido.setEnderecoEntrega(enderecoEntregaPedido);
        pedido.setCliente(cliente);

        entityManager.getTransaction().begin();
        entityManager.persist(pedido);
        entityManager.getTransaction().commit();
        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
        assertNotNull(pedidoVerificacao);
    }

}

package it.alexguesser.ecommerce.mapeamentoavancado;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.*;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class HerancaTest extends EntityManagerTest {

    @Test
    public void salvarCliente() {
        Cliente cliente = new Cliente();
        cliente.setNome("Nicolle");
        cliente.setSexoCliente(SexoCliente.FEMININO);
        cliente.setCpf("9616415414");

        entityManager.getTransaction().begin();
        entityManager.persist(cliente);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Cliente clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());
        assertNotNull(clienteVerificacao.getId());
    }

    @Test
    public void buscarPagamentos() {
        List<Pagamento> pagamentos =
                entityManager
                        .createQuery("select p from Pagamento p")
                        .getResultList();
        assertFalse(pagamentos.isEmpty());
    }

    @Test
    public void incluirPagamentoPedido() {
        Pedido pedido = entityManager.find(Pedido.class, 1);

        PagamentoCartao pagamentoCartao = new PagamentoCartao();
        pagamentoCartao.setPedido(pedido);
        pagamentoCartao.setStatus(StatusPagamento.PROCESSANDO);
        pagamentoCartao.setNumeroCartao("123");

        entityManager.getTransaction().begin();
        entityManager.persist(pagamentoCartao);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
        assertNotNull(pedidoVerificacao.getPagamento());
    }

}

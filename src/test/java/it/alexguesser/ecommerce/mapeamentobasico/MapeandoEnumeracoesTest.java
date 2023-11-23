package it.alexguesser.ecommerce.mapeamentobasico;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.SexoCliente;

public class MapeandoEnumeracoesTest extends EntityManagerTest {

    @Test
    public void testarEnum() {
        Cliente cliente = new Cliente();
        cliente.setNome("José Mineiro");
        cliente.setSexoCliente(SexoCliente.MASCULINO);
        cliente.setCpf("6554154121");

        entityManager.getTransaction().begin();
        entityManager.persist(cliente);
        entityManager.getTransaction().commit();
        entityManager.clear();
        Cliente clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());
        assertNotNull(clienteVerificacao);
    }

}

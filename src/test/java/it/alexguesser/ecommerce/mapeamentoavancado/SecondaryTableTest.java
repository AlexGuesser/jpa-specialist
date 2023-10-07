package it.alexguesser.ecommerce.mapeamentoavancado;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.SexoCliente;
import org.junit.jupiter.api.Test;

import java.time.LocalDate;

import static org.junit.jupiter.api.Assertions.assertNotNull;

public class SecondaryTableTest extends BaseTest {

    @Test
    public void salvarCliente() {
        Cliente cliente = new Cliente();
        cliente.setNome("José Mário");
        cliente.setSexoCliente(SexoCliente.MASCULINO);
        cliente.setDataNascimento(LocalDate.of(1960, 9, 2));
        cliente.setCpf("68451846158");

        entityManager.getTransaction().begin();
        entityManager.persist(cliente);
        entityManager.getTransaction().commit();
        entityManager.clear();

        Cliente clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());
        assertNotNull(clienteVerificacao.getSexoCliente());
        assertNotNull(clienteVerificacao.getDataNascimento());
    }

}

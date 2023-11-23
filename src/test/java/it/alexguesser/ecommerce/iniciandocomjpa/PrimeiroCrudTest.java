package it.alexguesser.ecommerce.iniciandocomjpa;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.SexoCliente;
import org.junit.jupiter.api.MethodOrderer;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class PrimeiroCrudTest extends EntityManagerTest {

    @Test
    public void inserirCliente() {
        Cliente erica = new Cliente("Érica Luzia Pauli Guesser", SexoCliente.FEMININO, "123454534");

        entityManager.persist(erica);
        entityManager.getTransaction().begin();
        entityManager.getTransaction().commit();

        entityManager.clear();
        Cliente clienteVerificacao = entityManager.find(Cliente.class, erica.getId());
        assertNotNull(clienteVerificacao);
        assertEquals(erica.getNome(), clienteVerificacao.getNome());
    }

    @Test
    public void pegarClientePorId() {
        Cliente rony = new Cliente("Rony Ramos", SexoCliente.MASCULINO, "12393984573984");
        entityManager.getTransaction().begin();
        entityManager.persist(rony);
        entityManager.getTransaction().commit();

        Cliente clienteVerificacao = entityManager.find(Cliente.class, rony.getId());

        assertNotNull(clienteVerificacao);
        assertEquals(rony.getNome(), clienteVerificacao.getNome());
    }

    @Test
    public void atualizarCliente() {
        Cliente alex = entityManager.find(Cliente.class, 1);
        alex.setNome(alex.getNome().toUpperCase());
        entityManager.getTransaction().begin();
        entityManager.getTransaction().commit();
        entityManager.clear();

        Cliente clienteVerificacao = entityManager.find(Cliente.class, 1);
        assertNotNull(clienteVerificacao);
        assertEquals(alex.getNome(), clienteVerificacao.getNome());
    }

    @Test
    public void deletarCliente() {
        Cliente erica = entityManager.find(Cliente.class, 3);
        entityManager.getTransaction().begin();
        entityManager.remove(erica);
        entityManager.getTransaction().commit();

        Cliente clienteVerificacao = entityManager.find(Cliente.class, 3);
        assertNull(clienteVerificacao);
    }


}

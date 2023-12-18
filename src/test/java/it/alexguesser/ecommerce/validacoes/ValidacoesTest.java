package it.alexguesser.ecommerce.validacoes;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Cliente;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertThrows;

public class ValidacoesTest extends EntityManagerTest {

    @Test
    public void validarCliente() {
        entityManager.getTransaction().begin();

        Cliente cliente = new Cliente();
        assertThrows(
                jakarta.validation.ConstraintViolationException.class,
                () -> entityManager.merge(cliente));


        entityManager.getTransaction().commit();
    }

}

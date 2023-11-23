package it.alexguesser.ecommerce.mapeamentoavancado;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Cliente;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class PropriedadesTransientesTest extends EntityManagerTest {

    @Test
    public void validarPrimeiroNome() {
        Cliente cliente = entityManager.find(Cliente.class, 1);
        assertEquals("Alex", cliente.getPrimeiroNome());
    }


}

package it.alexguesser.ecommerce.mapeamentobasico;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Categoria;

public class EstrategiaChavePrimariaTest extends BaseTest {

    @Test
    public void testarEstrategiaChave() {

        Categoria categoria = new Categoria();
        categoria.setNome("Eletrônicos 2");

        entityManager.getTransaction().begin();
        entityManager.persist(categoria);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Categoria categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());
        assertNotNull(categoriaVerificacao);
    }

}

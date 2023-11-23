package it.alexguesser.ecommerce.relacionamentos;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Categoria;

public class AutoRelacionamentoTest extends EntityManagerTest {

    @Test
    public void verificarRelacionamento() {
        Categoria categoriaPai = new Categoria();
        categoriaPai.setNome("Eletrônicos 2");

        Categoria categoriaFilha = new Categoria();
        categoriaFilha.setNome("Celulares");
        categoriaFilha.setCategoriaPai(categoriaPai);

        entityManager.getTransaction().begin();
        entityManager.persist(categoriaPai);
        entityManager.persist(categoriaFilha);
        entityManager.getTransaction().commit();
        entityManager.clear();

        Categoria categoriaVerificacao = entityManager.find(Categoria.class, categoriaFilha.getId());
        assertNotNull(categoriaVerificacao.getCategoriaPai());
    }

}

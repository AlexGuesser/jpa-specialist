package it.alexguesser.ecommerce.conhecendooentitymanager;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Produto;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

public class ContextoDePersistenciaTest extends BaseTest {

    @Test
    public void usarContextoPersistencia() {
        // AO USAR O FIND O OBJETO VAI DIRETO PARA O CONTEXTO DE PERSISTÊNCIA
        Produto produto = entityManager.find(Produto.class, 1);
        produto.setPreco(new BigDecimal("100.00")); //DIRTY CHECKING

        Produto produto2 = new Produto();
        produto2.setNome("Caneca");
        produto2.setDescricao("A melhor caneca");
        // AO USAR O PERSIST/MERGE ADICIONAMOS O OBJETO AO CONTEXTO DE PERSISTÊNCIA
        entityManager.persist(produto2);
        //produto2 = entityManager.merge(produto2);

        entityManager.getTransaction().begin();
        entityManager.getTransaction().commit();
    }

}

package it.alexguesser.ecommerce.iniciandocomjpa;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Produto;

public class ConsultandoRegistrosTest extends BaseTest {

    @Test
    public void buscarPorId() {
        Produto produto = entityManager.find(Produto.class, 1);
        // ESSE MÉTODO AQUI É LAZY, SÓ CARREGA AS PROPRIEDADES QUANDO REALMENTE PRECISA
        Produto produto2 = entityManager.getReference(Produto.class, 1);

        assertNotNull(produto);
        assertEquals("Kindle", produto.getNome());
    }

    @Test
    public void atualizarAReferencia() {
        Produto produto = entityManager.find(Produto.class, 1);
        produto.setNome("PS5");
        // O MÉTODO REFRESH ATUALIZA O OBJETO COM AS INFORMAÇÕES DO BANCO DE DADOS!
        entityManager.refresh(produto);

        assertEquals("Kindle", produto.getNome());
    }


}

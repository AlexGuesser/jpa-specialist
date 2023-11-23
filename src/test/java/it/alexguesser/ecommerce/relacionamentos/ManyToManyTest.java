package it.alexguesser.ecommerce.relacionamentos;

import static org.junit.jupiter.api.Assertions.assertFalse;

import java.util.List;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Categoria;
import it.alexguesser.ecommerce.model.Produto;

public class ManyToManyTest extends EntityManagerTest {

    @Test
    public void verificarRelacionamento() {
        Produto produto = entityManager.find(Produto.class, 1);
        Categoria categoria = entityManager.find(Categoria.class, 1);

        entityManager.getTransaction().begin();
        //categoria.setProdutos(List.of(produto)); // ISSO AQUI NÃO É SALVO, JÁ QUE CATEGORIA NÃO É O LADO OWNER
        produto.setCategorias(List.of(categoria));
        entityManager.getTransaction().commit();
        entityManager.clear();
        Categoria categoriaVerificacao = entityManager.find(Categoria.class, categoria.getId());
        assertFalse(categoriaVerificacao.getProdutos().isEmpty());
    }

}

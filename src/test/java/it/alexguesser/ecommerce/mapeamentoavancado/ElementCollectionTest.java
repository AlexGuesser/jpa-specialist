package it.alexguesser.ecommerce.mapeamentoavancado;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Atributo;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.Produto;
import org.junit.jupiter.api.Test;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class ElementCollectionTest extends EntityManagerTest {

    @Test
    public void aplicarTags() {
        entityManager.getTransaction().begin();
        Produto produto = entityManager.find(Produto.class, 1);
        produto.setTags(List.of("ebook", "livro digital"));
        entityManager.getTransaction().commit();
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        assertFalse(produtoVerificacao.getTags().isEmpty());
    }

    @Test
    public void aplicarAtributos() {
        entityManager.getTransaction().begin();
        Produto produto = entityManager.find(Produto.class, 1);
        produto.setAtributos(List.of(
                new Atributo("tela", "320x600"),
                new Atributo("processador", "i7")));
        entityManager.getTransaction().commit();
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        assertFalse(produtoVerificacao.getTags().isEmpty());
    }

    @Test
    public void aplicarContatos() {
        entityManager.getTransaction().begin();
        Cliente cliente = entityManager.find(Cliente.class, 1);
        cliente.setContatos(Collections.singletonMap("email", "alex@email.com"));
        entityManager.getTransaction().commit();
        entityManager.clear();
        Cliente clienteVerificacao = entityManager.find(Cliente.class, cliente.getId());
        assertEquals("alex@email.com", clienteVerificacao.getContatos().get("email"));
    }

}

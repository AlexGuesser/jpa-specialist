package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Pedido;
import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class NamedQueryTest extends BaseTest {


    @Test
    public void executarConsulta() {
        TypedQuery<Produto> typedQuery = entityManager.createNamedQuery("Produto.listar", Produto.class);
        List<Produto> lista = typedQuery.getResultList();

        assertFalse(lista.isEmpty());
    }

    @Test
    public void executarConsultaAPartirDeArquivoXML() {
        TypedQuery<Pedido> typedQuery = entityManager.createNamedQuery("Pedido.listar", Pedido.class);

        List<Pedido> lista = typedQuery.getResultList();

        assertFalse(lista.isEmpty());
    }



}

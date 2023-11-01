package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Categoria;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class AbordagemHibridaTest extends BaseTest {

    @BeforeAll
    public static void configurarNamedQuery() {
        EntityManager em = entityManagerFactory.createEntityManager();
        TypedQuery<Categoria> typedQuery = em.createQuery(
                "select c from Categoria c",
                Categoria.class
        );
        entityManagerFactory.addNamedQuery("Categoria.listar", typedQuery);
    }


    @Test
    public void usarAbordagemHibrida() {
        TypedQuery<Categoria> typedQuery = entityManager.createNamedQuery("Categoria.listar", Categoria.class);

        List<Categoria> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

}

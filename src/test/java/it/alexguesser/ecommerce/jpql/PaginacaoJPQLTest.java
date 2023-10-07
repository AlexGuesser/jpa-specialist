package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Categoria;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class PaginacaoJPQLTest extends BaseTest {

    @Test
    public void paginarResultado() {
        String jpql = """
                select c from Categoria c
                order by c.nome
                """;

        TypedQuery<Categoria> typedQuery = entityManager.createQuery(jpql, Categoria.class);
        // FIRST_RESULT = MAX_RESULTS * (PAGE - 1)
        typedQuery.setFirstResult(0); // SIMILAR AO OFFSET, DEVE COMEÇAR COM 0
        typedQuery.setMaxResults(2); // SIMILAR AO LIMIT

        List<Categoria> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(c -> System.out.println(c.getId() + ", " + c.getNome()));
    }

}

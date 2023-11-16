package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Produto;
import it.alexguesser.ecommerce.model.Produto_;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class MetaModelTest extends BaseTest {

    @Test
    public void utilizarMetaModel() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Produto> criteriaQuery = criteriaBuilder.createQuery(Produto.class);
        Root<Produto> root = criteriaQuery.from(Produto.class);

        criteriaQuery
                .select(root)
                .where(
                        criteriaBuilder.or(
                                criteriaBuilder.like(root.get(Produto_.NOME), "%C%"),
                                criteriaBuilder.like(root.get(Produto_.DESCRICAO), "%C%")
                        )
                );
        TypedQuery<Produto> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Produto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
    }

}

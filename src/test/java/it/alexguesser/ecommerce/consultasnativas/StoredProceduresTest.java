package it.alexguesser.ecommerce.consultasnativas;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Cliente;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.StoredProcedureQuery;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class StoredProceduresTest extends EntityManagerTest {

    @Test
    public void chamarNamedStoreProcedure() {
        StoredProcedureQuery storedProcedureQuery =
                entityManager.createNamedStoredProcedureQuery("compraram_acima_media");

        storedProcedureQuery.setParameter("ano", 2023);

        List<Cliente> lista = (List<Cliente>) storedProcedureQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void atualizarPrecoProdutoExercicio() {
        StoredProcedureQuery storedProcedureQuery = entityManager
                .createStoredProcedureQuery("ajustar_preco_produto", BigDecimal.class);

        storedProcedureQuery.registerStoredProcedureParameter(
                "produto_id", Integer.class, ParameterMode.IN);

        storedProcedureQuery.registerStoredProcedureParameter(
                "percentual_ajuste", BigDecimal.class, ParameterMode.IN);

        storedProcedureQuery.registerStoredProcedureParameter(
                "preco_ajustado", BigDecimal.class, ParameterMode.OUT);

        storedProcedureQuery.setParameter("produto_id", 1);
        storedProcedureQuery.setParameter("percentual_ajuste", new BigDecimal("0.1"));

        BigDecimal precoAjustado = (BigDecimal) storedProcedureQuery
                .getOutputParameterValue("preco_ajustado");

        assertEquals(new BigDecimal("550.0"), precoAjustado);
    }


    @Test
    public void procedureRetornandoLista() {
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery(
                "compraram_acima_media",
                Cliente.class
        );

        storedProcedureQuery.registerStoredProcedureParameter("ano", Integer.class, ParameterMode.IN);
        storedProcedureQuery.setParameter("ano", 2023);

        List<Cliente> lista = (List<Cliente>) storedProcedureQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void usarParametrosInEOut() {
        StoredProcedureQuery storedProcedureQuery = entityManager.createStoredProcedureQuery("buscar_nome_produto");

        storedProcedureQuery.registerStoredProcedureParameter("produto_id", Integer.class, ParameterMode.IN);
        storedProcedureQuery.registerStoredProcedureParameter("produto_nome", String.class, ParameterMode.OUT);
        storedProcedureQuery.setParameter("produto_id", 1);

        String produtoNome = (String) storedProcedureQuery.getOutputParameterValue("produto_nome");
        assertNotNull(produtoNome);
    }

}

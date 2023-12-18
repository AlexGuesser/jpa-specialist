package it.alexguesser.ecommerce.detalhesimportants;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Pedido;
import jakarta.persistence.EntityGraph;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.util.List;

public class EntityGraphTest extends EntityManagerTest {

    @Test
    public void buscarAtributosEssenciaisDePedido() {
        // fetchgraph TUDO ESPECIFICADO É CARREGADO DE FORMA EAGER, O RESTO DE FORMA LAZY
        // loadgraph TUDO ESPECIFICADO É CARREGADO DE FORMA EAGER, OS OUTROS DEVE SEGUIR AS ANOTAÇÕES DA CLASSE
        EntityGraph<Pedido> entityGraph = entityManager.createEntityGraph(Pedido.class);
        entityGraph.addAttributeNodes(
                "dataCriacao", "status", "total", "notaFiscal");
        /*
        // FORMA DE UTILIZAR COM .find
        Map<String, Object> properties = new HashMap<>();
        properties.put("jakarta.persistence.fetchgraph", entityGraph);
        properties.put("jakarta.persistence.loadgraph", entityGraph);
        Pedido pedido = entityManager.find(Pedido.class, 1, properties);
        Assertions.assertNotNull(pedido);
        */

        TypedQuery<Pedido> typedQuery = entityManager
                .createQuery("select p from Pedido p", Pedido.class);
        typedQuery.setHint("jakarta.persistence.fetchgraph", entityGraph);
        List<Pedido> lista = typedQuery.getResultList();
        Assertions.assertFalse(lista.isEmpty());
    }
}

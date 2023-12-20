package it.alexguesser.ecommerce.cache;

import it.alexguesser.ecommerce.hibernate.EcmCurrentTenantIdentifierResolver;
import it.alexguesser.ecommerce.model.Pedido;
import jakarta.persistence.*;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class CacheTest {

    protected static EntityManagerFactory entityManagerFactory;

    @BeforeAll
    public static void setupBeforeClass() {
        // EcmCurrentTenantIdentifierResolver.setTenantIdentifier("algaworks_ecommerce");
        entityManagerFactory = Persistence.createEntityManagerFactory(
                "Ecommerce-PU"
        );
    }

    @AfterAll
    public static void tearDownAfterClass() {
        entityManagerFactory.close();
    }

    @Test
    public void buscarDoCache() {
        EntityManager entityManager1 = entityManagerFactory.createEntityManager();
        EntityManager entityManager2 = entityManagerFactory.createEntityManager();

        System.out.println("Buscando a partir da instância 1: ");
        entityManager1.find(Pedido.class, 1);

        System.out.println("Buscando a partir da instância 1: ");
        //AQUI NÃO É FEITO UM SEGUNDO SELECT POR CAUSA DO CACHE DE PRIMEIRO NÍVEL
        entityManager1.find(Pedido.class, 1);

        System.out.println("Buscando a partir da instância 2: ");
        // AQUI NAO É FEITO UM SQL NOVAMENTE POR CAUSA DO CACHE DE SEGUNDO NÍVEL
        entityManager2.find(Pedido.class, 1);

        entityManager1.close();
        entityManager2.close();
    }

    @Test
    public void adicionarPedidosNoCache() {
        EntityManager entityManager1 = entityManagerFactory.createEntityManager();
        EntityManager entityManager2 = entityManagerFactory.createEntityManager();

        System.out.println("Buscando a partir da instância 1: ");
        entityManager1.createQuery("""
                                select p from Pedido p
                                """
                        , Pedido.class)
                .getResultList();

        System.out.println("Buscando a partir da instância 2: ");
        entityManager2.find(Pedido.class, 1);

        entityManager1.close();
        entityManager2.close();
    }

    @Test
    public void verificarSeEstarNoCache() {
        Cache cache = entityManagerFactory.getCache();
        EcmCurrentTenantIdentifierResolver.setTenantIdentifier("algaworks_ecommerce");

        EntityManager entityManager1 = entityManagerFactory.createEntityManager();

        System.out.println("Buscando a partir da instância 1: ");
        entityManager1.createQuery("""
                                select p from Pedido p
                                """
                        , Pedido.class)
                .getResultList();

        // MÉTODO CONTAINS NÃO GERA A MESMA KEY AQUI POR CAUSA DA ESTRATÉGIA DE MULTITENANT
        // NÃO É POSSÍVEL INFORMAR O TENANTID AQUI
        assertTrue(cache.contains(Pedido.class, 1));
        assertTrue(cache.contains(Pedido.class, 2));

        entityManager1.close();
    }

    @Test
    public void removerDoCache() {
        Cache cache = entityManagerFactory.getCache();
        EntityManager entityManager1 = entityManagerFactory.createEntityManager();
        EntityManager entityManager2 = entityManagerFactory.createEntityManager();

        System.out.println("Buscando a partir da instância 1: ");
        entityManager1.createQuery("""
                                select p from Pedido p
                                """
                        , Pedido.class)
                .getResultList();

        System.out.println("Removendo pedido 1 do cache");
        // REMOVE APENAS O PEDIDO COM ID 1 DO CACHE DE SEGUNDO NÍVEL
//        cache.evict(Pedido.class, 1);
        // REMOVE TODOS OS PEDIDOS DO CACHE DE SEGUNDO NÍVEL
        cache.evict(Pedido.class);
        // REMOVE TODOS OS OBJETOS DO CACHE DE SEGUNDO NÍVEL
//        cache.evictAll();

        System.out.println("Buscando a partir da instância 2: ");
        entityManager2.find(Pedido.class, 1);
        entityManager2.find(Pedido.class, 2);

        entityManager1.close();
        entityManager2.close();
    }

    @Test
    public void analisarOpcoesDeCache() {
        Cache cache = entityManagerFactory.getCache();
        EntityManager entityManager1 = entityManagerFactory.createEntityManager();

        System.out.println("Buscando a partir da instância 1: ");
        entityManager1.createQuery("""
                                select p from Pedido p
                                """
                        , Pedido.class)
                .getResultList();

        // MÉTODO CONTAINS NÃO GERA A MESMA KEY AQUI POR CAUSA DA ESTRATÉGIA DE MULTITENANT
        // NÃO É POSSÍVEL INFORMAR O TENANTID AQUI
//        assertTrue(cache.contains(Pedido.class, 1));

        entityManager1.close();
    }

    @Test
    public void controlarCacheDinamicamente() {
        // jakarta.persistence.cache.retrieveMode CacheRetrieveMode
        // jakarta.persistence.cache.storeMode CacheStoreMode
        Cache cache = entityManagerFactory.getCache();
        EntityManager entityManager1 = entityManagerFactory.createEntityManager();
        EntityManager entityManager2 = entityManagerFactory.createEntityManager();
//        entityManager2.setProperty("jakarta.persistence.cache.storeMode", CacheStoreMode.BYPASS);

        System.out.println("Buscando todos os pedidos usando EM1.....");
        entityManager1.createQuery("""
                                select p from Pedido p
                                """
                        , Pedido.class)
                .setHint("jakarta.persistence.cache.storeMode", CacheStoreMode.BYPASS)
                .getResultList();

        System.out.println("Buscando pedido 2 com EM2.....");
        Map<String, Object> propriedades = new HashMap<>();
        propriedades.put("jakarta.persistence.cache.storeMode", CacheStoreMode.BYPASS);
        entityManager2.find(Pedido.class, 2, propriedades);

        entityManager1.close();
        entityManager2.close();
    }

    @Test
    public void ehCache() {
        Cache cache = entityManagerFactory.getCache();

        EntityManager em1 = entityManagerFactory.createEntityManager();
        log("Buscando e incluíndo no cache...");
        em1.createQuery("select p from Pedido p", Pedido.class)
                .getResultList();
        log("--------");

        esperar(1);
        // MÉTODO CONTAINS NÃO GERA A MESMA KEY AQUI POR CAUSA DA ESTRATÉGIA DE MULTITENANT
        // NÃO É POSSÍVEL INFORMAR O TENANTID AQUI
//        assertTrue(cache.contains(Pedido.class, 1));
        esperar(2);
        assertFalse(cache.contains(Pedido.class, 1));

        em1.close();
    }

    private static void esperar(int segundos) {
        try {
            Thread.sleep(segundos * 1000L);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    private static void log(Object o) {
        System.out.println("[LOG " + System.currentTimeMillis() + "] " + o);
    }

}

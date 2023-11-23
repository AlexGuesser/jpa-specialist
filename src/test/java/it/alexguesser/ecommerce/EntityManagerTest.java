package it.alexguesser.ecommerce;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;

public abstract class EntityManagerTest {

    public static final String ECOMMERCE_PU = "Ecommerce-PU";
    protected static EntityManagerFactory entityManagerFactory;

    protected EntityManager entityManager;

    @BeforeAll
    public static void beforeAll() {
        entityManagerFactory = Persistence.createEntityManagerFactory(ECOMMERCE_PU);
    }

    @AfterAll
    public static void afterAll() {
        entityManagerFactory.close();
    }

    @BeforeEach
    public void beforeEach() {
        entityManager = entityManagerFactory.createEntityManager();
    }

    @AfterEach
    public void afterEach() {
        entityManager.close();
    }

    protected void beginAndCommitTransaction() {
        entityManager.getTransaction().begin();
        entityManager.getTransaction().commit();
    }


}

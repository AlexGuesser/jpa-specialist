package it.alexguesser.ecommerce;

import it.alexguesser.ecommerce.hibernate.EcmCurrentTenantIdentifierResolver;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

public abstract class EntityManagerTest extends EntityManagerFactoryTest {

    protected EntityManager entityManager;

    @BeforeEach
    public void beforeEach() {
        entityManager = entityManagerFactory.createEntityManager();
    }

    @AfterEach
    public void afterEach() {
        entityManager.close();
    }

}

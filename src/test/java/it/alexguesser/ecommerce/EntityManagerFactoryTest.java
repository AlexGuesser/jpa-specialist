package it.alexguesser.ecommerce;

import it.alexguesser.ecommerce.hibernate.EcmCurrentTenantIdentifierResolver;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;

public class EntityManagerFactoryTest {

    private static final String ECOMMERCE_PU = "Ecommerce-PU";
    protected static EntityManagerFactory entityManagerFactory;

    @BeforeAll
    public static void beforeAll() {
        entityManagerFactory = Persistence.createEntityManagerFactory(ECOMMERCE_PU);
    }

    @AfterAll
    public static void afterAll() {
        entityManagerFactory.close();
    }


    public static void log(Object o, Object... args) {
        System.out.println(
                String.format("[LOG " + System.currentTimeMillis() + " ] " + o, args)
        );
    }

    public static void esperar(int segundos) {
        try {
            Thread.sleep(segundos * 1000L);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

}

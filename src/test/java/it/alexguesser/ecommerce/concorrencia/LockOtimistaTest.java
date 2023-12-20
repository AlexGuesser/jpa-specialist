package it.alexguesser.ecommerce.concorrencia;

import it.alexguesser.ecommerce.hibernate.EcmCurrentTenantIdentifierResolver;
import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class LockOtimistaTest {

    protected static EntityManagerFactory entityManagerFactory;


    @BeforeAll
    public static void setupBeforeAll() {
        entityManagerFactory = Persistence.createEntityManagerFactory("Ecommerce-PU");
    }

    @AfterAll
    public static void tearDownAfterAll() {
        entityManagerFactory.close();
    }

    @Test
    public void usarLockOtimista() {
        Runnable runnable1 = () -> {
            EntityManager em1 = entityManagerFactory.createEntityManager();
            em1.getTransaction().begin();

            log("Runnable 1 vai carregar o produto 1");
            Produto produto = em1.find(Produto.class, 1);

            log("Runnable 1 vai esperar 3 segundos");
            esperar(3);

            log("Runnable 1 vai alterar o produto 1");
            produto.setDescricao("Descrição detalhada.");

            log("Runnable 1 vai commitar a transação");
            em1.getTransaction().commit();
            em1.close();
        };

        Runnable runnable2 = () -> {
            EntityManager em2 = entityManagerFactory.createEntityManager();
            em2.getTransaction().begin();

            log("Runnable 2 vai carregar o produto 1");
            Produto produto = em2.find(Produto.class, 1);

            log("Runnable 2 vai esperar 1 segundo");
            esperar(1);

            log("Runnable 2 vai alterar o produto 1");
            produto.setDescricao("Descrição massa.");

            log("Runnable 2 vai commitar a transação");
            em2.getTransaction().commit();
            em2.close();
        };

        Thread thread1 = new Thread(runnable1);
        Thread thread2 = new Thread(runnable2);
        thread1.start();
        thread2.start();
        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        EcmCurrentTenantIdentifierResolver.setTenantIdentifier("algaworks_ecommerce");
        EntityManager em3 = entityManagerFactory.createEntityManager();
        Produto produto = em3.find(Produto.class, 1);
        em3.close();

        assertEquals("Descrição massa.", produto.getDescricao());

        log("Encerrando método de teste.");
    }

    private static void log(Object o, Object... args) {
        System.out.println(
                String.format("[LOG " + System.currentTimeMillis() + " ] " + o, args)
        );
    }

    private static void esperar(int segundos) {
        try {
            Thread.sleep(segundos * 1000L);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

}

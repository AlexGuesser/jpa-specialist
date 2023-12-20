package it.alexguesser.ecommerce.concorrencia;

import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.LockModeType;
import jakarta.persistence.Persistence;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertTrue;

public class LockPessimistaTest {

    protected static EntityManagerFactory entityManagerFactory;


    @BeforeAll
    public static void setupBeforeAll() {
        entityManagerFactory = Persistence.createEntityManagerFactory("Ecommerce-PU");
    }

    @AfterAll
    public static void tearDownAfterAll() {
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

    @Test
    public void usarLockPessimistaRead() {
        Runnable runnable1 = () -> {
            log("Iniciando Runnable 1.");

            String novaDescricao = "Descrição detalhada. CTM: " + System.currentTimeMillis();

            EntityManager em1 = entityManagerFactory.createEntityManager();
            em1.getTransaction().begin();

            log("Runnable 1 vai carregar o produto 1");
            Produto produto =
                    em1.find(Produto.class, 1, LockModeType.PESSIMISTIC_READ);

            log("Runnable 1 vai alterar o produto 1");
            produto.setDescricao(novaDescricao);

            log("Runnable 1 vai esperar 3 segundos");
            esperar(3);

            log("Runnable 1 vai commitar a transação");
            em1.getTransaction().commit();
            em1.close();
            log("Encerrando Runnable 1.");
        };

        Runnable runnable2 = () -> {
            log("Iniciando Runnable 2.");

            String novaDescricao = "Descrição massa. CTM: " + System.currentTimeMillis();

            EntityManager em2 = entityManagerFactory.createEntityManager();
            em2.getTransaction().begin();

            log("Runnable 2 vai carregar o produto 1");
            // QUANDO 2 THREADS ESTÃO USANDO PESSIMISTIC_READ, A QUE COMMITAR PRIMEIRO VENCE
            Produto produto =
                    em2.find(Produto.class, 1, LockModeType.PESSIMISTIC_READ);

            log("Runnable 2 vai alterar o produto 1");
            produto.setDescricao(novaDescricao);

            log("Runnable 2 vai esperar 1 segundo");
            esperar(1);

            log("Runnable 2 vai commitar a transação");
            em2.getTransaction().commit();
            em2.close();
            log("Encerrando Runnable 2.");
        };

        Thread thread1 = new Thread(runnable1);
        Thread thread2 = new Thread(runnable2);

        thread1.start();

        esperar(1);
        thread2.start();
        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        EntityManager em3 = entityManagerFactory.createEntityManager();
        Produto produto = em3.find(Produto.class, 1);
        em3.close();

        assertTrue(produto.getDescricao().startsWith("Descrição massa."));

        log("Encerrando método de teste.");
    }

    @Test
    public void usarLockPessimistaWrite() {
        Runnable runnable1 = () -> {
            log("Iniciando Runnable 1.");

            String novaDescricao = "Descrição detalhada. CTM: " + System.currentTimeMillis();

            EntityManager em1 = entityManagerFactory.createEntityManager();
            em1.getTransaction().begin();

            log("Runnable 1 vai carregar o produto 1");
            Produto produto =
                    em1.find(Produto.class, 1, LockModeType.PESSIMISTIC_WRITE);

            log("Runnable 1 vai alterar o produto 1");
            produto.setDescricao(novaDescricao);

            log("Runnable 1 vai esperar 3 segundos");
            esperar(3);

            log("Runnable 1 vai commitar a transação");
            em1.getTransaction().commit();
            em1.close();
            log("Encerrando Runnable 1.");
        };

        Runnable runnable2 = () -> {
            log("Iniciando Runnable 2.");

            String novaDescricao = "Descrição massa. CTM: " + System.currentTimeMillis();

            EntityManager em2 = entityManagerFactory.createEntityManager();
            em2.getTransaction().begin();

            log("Runnable 2 vai carregar o produto 1");
            // QUANDO 2 THREADS ESTÃO USANDO PESSIMISTIC_WRITE, A SEGUNDA THREAD ESPERAR A PRIMEIRA TERMINAR PARA CARREGAR
            // O VALOR NO FIND
            Produto produto =
                    em2.find(Produto.class, 1, LockModeType.PESSIMISTIC_WRITE);

            log("Runnable 2 vai alterar o produto 1");
            produto.setDescricao(novaDescricao);

            log("Runnable 2 vai esperar 1 segundo");
            esperar(1);

            log("Runnable 2 vai commitar a transação");
            em2.getTransaction().commit();
            em2.close();
            log("Encerrando Runnable 2.");
        };

        Thread thread1 = new Thread(runnable1);
        Thread thread2 = new Thread(runnable2);

        thread1.start();

        esperar(1);
        thread2.start();
        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        EntityManager em3 = entityManagerFactory.createEntityManager();
        Produto produto = em3.find(Produto.class, 1);
        em3.close();

        // PARA ESSE ASSERT PASSAR PRECISAMOS COMENTAR O ATRIBUTO versao E REMOVAR OPTIMISTIC LOCK


        assertTrue(produto.getDescricao().startsWith("Descrição massa."));

        log("Encerrando método de teste.");
    }

    /*
    SE UM REGISTRO JÁ ESTIVER COM LOCK PESSIMIST_READ
    UMA SEGUNDA THREAD NÃO PODE PEDIR PESSIMIST_WRRITE PARA ESSE MESMO REGISTRO
    AO TENTAR PEGAR UM LOCK PESSIMIST_WRITE UMA EXCEÇÃO SERÁ LANÇADA
     */
    @Test
    public void misturarTiposDeLock() {
        Runnable runnable1 = () -> {
            log("Iniciando Runnable 1.");

            String novaDescricao = "Descrição detalhada. CTM: " + System.currentTimeMillis();

            EntityManager em1 = entityManagerFactory.createEntityManager();
            em1.getTransaction().begin();

            log("Runnable 1 vai carregar o produto 1");
            Produto produto =
                    em1.find(Produto.class, 1, LockModeType.PESSIMISTIC_WRITE);

            log("Runnable 1 vai alterar o produto 1");
            produto.setDescricao(novaDescricao);

            log("Runnable 1 vai esperar 3 segundos");
            esperar(3);

            log("Runnable 1 vai commitar a transação");
            em1.getTransaction().commit();
            em1.close();
            log("Encerrando Runnable 1.");
        };

        Runnable runnable2 = () -> {
            log("Iniciando Runnable 2.");

            String novaDescricao = "Descrição massa. CTM: " + System.currentTimeMillis();

            EntityManager em2 = entityManagerFactory.createEntityManager();
            em2.getTransaction().begin();

            log("Runnable 2 vai carregar o produto 1");
            // ESSA SEGUNDA THREAD ESPERAR A PRIMEIRA TERMINAR PARA CARREGAR O VALOR NO FIND
            Produto produto =
                    em2.find(Produto.class, 1, LockModeType.PESSIMISTIC_READ);

            log("Runnable 2 vai alterar o produto 1");
            produto.setDescricao(novaDescricao);

            log("Runnable 2 vai esperar 1 segundo");
            esperar(1);

            log("Runnable 2 vai commitar a transação");
            em2.getTransaction().commit();
            em2.close();
            log("Encerrando Runnable 2.");
        };

        Thread thread1 = new Thread(runnable1);
        Thread thread2 = new Thread(runnable2);

        thread1.start();

        esperar(1);
        thread2.start();
        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        EntityManager em3 = entityManagerFactory.createEntityManager();
        Produto produto = em3.find(Produto.class, 1);
        em3.close();

        assertTrue(produto.getDescricao().startsWith("Descrição massa."));

        log("Encerrando método de teste.");
    }

    @Test
    public void usarLockNaTypedQuery() {
        Runnable runnable1 = () -> {
            log("Iniciando Runnable 01.");

            String novaDescricao = "Descrição detalhada. CTM: " + System.currentTimeMillis();

            EntityManager entityManager1 = entityManagerFactory.createEntityManager();
            entityManager1.getTransaction().begin();

            log("Runnable 01 vai carregar todos os produtos.");
            List<Produto> lista = entityManager1
                    .createQuery("select p from Produto p where p.id in (3,4,5)")
                    .setLockMode(LockModeType.PESSIMISTIC_READ)
                    .getResultList();

            Produto produto = lista
                    .stream()
                    .filter(p -> p.getId().equals(3))
                    .findFirst()
                    .get();

            log("Runnable 01 vai alterar o produto de ID igual a 1.");
            produto.setDescricao(novaDescricao);

            log("Runnable 01 vai esperar por 3 segundo(s).");
            esperar(3);

            log("Runnable 01 vai confirmar a transação.");
            entityManager1.getTransaction().commit();
            entityManager1.close();

            log("Encerrando Runnable 01.");
        };

        Runnable runnable2 = () -> {
            log("Iniciando Runnable 02.");

            String novaDescricao = "Descrição massa! CTM: " + System.currentTimeMillis();

            EntityManager entityManager2 = entityManagerFactory.createEntityManager();
            entityManager2.getTransaction().begin();

            log("Runnable 02 vai carregar o produto 2.");
            Produto produto = entityManager2.find(
                    Produto.class, 1, LockModeType.PESSIMISTIC_WRITE);

            log("Runnable 02 vai alterar o produto.");
            produto.setDescricao(novaDescricao);

            log("Runnable 02 vai esperar por 1 segundo(s).");
            esperar(1);

            log("Runnable 02 vai confirmar a transação.");
            entityManager2.getTransaction().commit();
            entityManager2.close();

            log("Encerrando Runnable 02.");
        };

        Thread thread1 = new Thread(runnable1);
        Thread thread2 = new Thread(runnable2);

        thread1.start();

        esperar(1);
        thread2.start();

        try {
            thread1.join();
            thread2.join();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }

        EntityManager entityManager3 = entityManagerFactory.createEntityManager();
        Produto produto = entityManager3.find(Produto.class, 1);
        entityManager3.close();

        assertTrue(produto.getDescricao().startsWith("Descrição massa!"));

        log("Encerrando método de teste.");
    }


}

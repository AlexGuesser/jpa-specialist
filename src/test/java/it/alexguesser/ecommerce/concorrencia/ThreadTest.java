package it.alexguesser.ecommerce.concorrencia;

import org.junit.jupiter.api.Test;

public class ThreadTest {

    private static void log(Object o, Object... args) {
        System.out.println(
                String.format(
                        "[LOG " + System.currentTimeMillis() + " ] " + o,
                        args
                )
        );
    }

    private static void esperar(int segundos) {
        try {
            Thread.sleep(segundos * 1000L);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    @Test
    public void entenderThreads() {
        Runnable runnable1 = () -> {
            log("Runnable 1 vai esperar 3 segundos");
            esperar(3);
            log("Runnable 1 concluído");
        };
        Runnable runnable2 = () -> {
            log("Runnable 2 vai esperar 1 segundos");
            esperar(1);
            log("Runnable 2 concluído");
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

        log("Encerrado método de teste");
    }

}

package it.alexguesser.ecommerce.listener;

import jakarta.persistence.PostLoad;

public class GenericoListener {

    @PostLoad
    public void logCarregamento(Object o) {
        System.out.println("Entidade " + o.getClass().getSimpleName() + " foi carregada");
    }

}

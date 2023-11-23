package it.alexguesser.ecommerce.conhecendooentitymanager;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Produto;
import org.junit.jupiter.api.Test;

public class CachePrimeiroNivelTest extends EntityManagerTest {

    @Test
    public void verificarCache() {
        // ISSO AQUI EXECUTA 1 SELECT NO BANCO
        Produto produto = entityManager.find(Produto.class, 1);
        System.out.println(produto);

        System.out.println("------------------");

        // UTILIZANDO CLEAR E CLOSE O CACHE É LIMPO E A CONSULTA SERIA GERADA NOVAMENTE
        // entityManager.clear();
        // entityManager.close();

        // ISSO AQUI É PEGO NA MEMÓRIA DO ENTITY MANAGER
        Produto produtoResgatado = entityManager.find(Produto.class, produto.getId());
        System.out.println(produtoResgatado);

    }

}

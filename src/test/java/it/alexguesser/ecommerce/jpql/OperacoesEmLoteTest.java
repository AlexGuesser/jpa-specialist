package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.Query;
import org.junit.jupiter.api.Test;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class OperacoesEmLoteTest extends BaseTest {

    private static final int LIMITE_INSERCOES = 4;

    @Test
    public void inserirEmLote() {
        InputStream in = OperacoesEmLoteTest.class.getClassLoader()
                .getResourceAsStream("produtos/importar.txt");
        BufferedReader reader = new BufferedReader(new InputStreamReader(in));

        entityManager.getTransaction().begin();
        int contador = 0;

        for (String linha : reader.lines().toList()) {
            if (linha.isBlank()) {
                continue;
            }

            String[] produtoColuna = linha.split(";");
            Produto produto = new Produto();
            produto.setNome(produtoColuna[0]);
            produto.setDescricao(produtoColuna[1]);
            produto.setPreco(new BigDecimal(produtoColuna[2]));
            produto.setDataCriacao(LocalDateTime.now());
            entityManager.persist(produto);

            if (++contador == LIMITE_INSERCOES) {
                entityManager.flush();
                entityManager.clear();
                contador = 0;
            }
        }
        entityManager.getTransaction().commit();
    }

    @Test
    public void atualizarLote() {
        String jpql = """
                update Produto p
                set p.preco = p.preco + 1
                """;

        Query query = entityManager.createQuery(jpql);
        entityManager.getTransaction().begin();
        query.executeUpdate(); // TEM QUE SER EXECUTADO DENTRO DE UMA TRANSACTION E A ORDEM DA TRANSACTION É IMPORTANTE
        entityManager.getTransaction().commit();
    }

    @Test
    public void removerEmLote() {
        entityManager.getTransaction().begin();

        String jpql = """
                delete from Produto p where p.id between 8 and 12
                """;
        Query query = entityManager.createQuery(jpql);
        query.executeUpdate();


        entityManager.getTransaction().commit();
    }

}

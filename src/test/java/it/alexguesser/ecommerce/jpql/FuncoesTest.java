package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;

public class FuncoesTest extends BaseTest {

    @Test
    public void aplicarFuncoesString() {
        // concat, length, locate, substring, lower, upper, trim
//        String jpql = """
//                select c.nome, concat("Categoria: ", c.nome) from Categoria c
//                """;
//        String jpql = """
//                select c.nome, length(c.nome) from Categoria c
//                """;
//        String jpql = """
//                select c.nome, locate("a", c.nome) from Categoria c
//                """;
        String jpql = """
                select c.nome, substring(c.nome, 1, 2) from Categoria c
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + " - " + arr[1]));
    }

    @Test
    public void aplicarFuncoesDatas() {
        // current_date, current_time, current_timestamp
        // TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
//        String jpql = """
//                select current_date, current_time, current_timestamp
//                from Pedido p
//                """;

        String jpql = """
                select year(p.dataCriacao), month(p.dataCriacao), day(p.dataCriacao)
                from Pedido p
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + " | " + arr[1] + " | " + arr[2]));
    }

    @Test
    public void aplicarFuncoesNumeros() {
        // abs, mod, sqrt
        String jpql = """
                select abs(-10), mod(3,2), sqrt(9) from Pedido p
                """;

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> lista = typedQuery.getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(arr -> System.out.println(arr[0] + " | " + arr[1] + " | " + arr[2]));
    }

    @Test
    public void aplicarFuncoesColecao() {
        String jpql = """
                select size(p.itemPedidos) from Pedido p
                """;

        TypedQuery<Integer> typedQuery = entityManager.createQuery(jpql, Integer.class);
        List<Integer> lista = typedQuery.getResultList();

        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void aplicarFuncaoNativa() {
        String jpql = "select function('dayname', p.dataCriacao) p from Pedido p " +
                "where function('acima_media_faturamento', p.total) = 1";

        TypedQuery<String> typedQuery = entityManager.createQuery(jpql, String.class);

        List<String> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void aplicarFuncaoAgregacao() {
        // avg, count, min, max, sum
        String jpql = """
                select avg(p.total) from Pedido p
                """;

        TypedQuery<Number> typedQuery = entityManager.createQuery(jpql, Number.class);

        List<Number> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }


}

package it.alexguesser.ecommerce.jpql;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.ProdutoDto;
import it.alexguesser.ecommerce.model.Cliente;
import it.alexguesser.ecommerce.model.Pedido;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class JPQLBasicoTest extends BaseTest {

    @Test
    public void buscarPorId() {
        // Java Persistence Query Language - JPQL
        // JPQL usa o nome da classe e dos atributos!
        // select p from Pedido p where p.id = 1
        // select p from Pedido p join p.itemPedidos i where i.precoProduto > 10
        //SQL
        // select p.* from pedido p where p.id = 1;
        TypedQuery<Pedido> typedQuery = entityManager.createQuery(
                "select p from Pedido p where p.id = 1",
                Pedido.class
        );
        Pedido pedido = typedQuery.getSingleResult(); //getSingleResult() espera 1 resultado! se não tiver vai dar exception
        assertNotNull(pedido);
    }

    @Test
    public void mostrarDiferencasQueries() {
        String jpql = "select p from Pedido p where p.id = 1";
        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);
        Pedido pedido1 = typedQuery.getSingleResult();
        assertNotNull(pedido1);
        Query query = entityManager.createQuery(jpql);
        Pedido pedido2 = (Pedido) query.getSingleResult();
        assertNotNull(pedido2);
    }

    @Test
    public void selectionarAtributoComoRetorno() {
        String jpql = "select p.nome from Produto p";

        TypedQuery<String> typedQuery = entityManager.createQuery(jpql, String.class);
        List<String> lista = typedQuery.getResultList();
        assertEquals(String.class, lista.get(0).getClass());

        String jpqlCliente = "select p.cliente from Pedido p";
        TypedQuery<Cliente> clienteTypedQuery = entityManager.createQuery(jpqlCliente, Cliente.class);
        List<Cliente> clientes = clienteTypedQuery.getResultList();
        assertEquals(Cliente.class, clientes.get(0).getClass());
    }

    @Test
    public void projetandoOResultadoDaJpql() {
        String jpql = "select id, nome from Produto";

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(jpql, Object[].class);
        List<Object[]> resultList = typedQuery.getResultList();
        assertEquals(2, resultList.get(0).length);
        resultList.forEach(arr -> System.out.println(arr[0] + ", " + arr[1]));
    }

    @Test
    public void projetandoComDto() {
        String jpql = "select new it.alexguesser.ecommerce.ProdutoDto(id, nome) from Produto";
        TypedQuery<ProdutoDto> typedQuery = entityManager.createQuery(jpql, ProdutoDto.class);
        List<ProdutoDto> list = typedQuery.getResultList();
        assertFalse(list.isEmpty());
        list.forEach(System.out::println);
    }

    @Test
    public void ordenarResultados() {
        // ASC É O PADRÃO E NÃO PRECISA SER ESPECIFICADO. DESC PRECISA SER ESPECIFICADO
        String jpql = """
                select c from Cliente c
                order by c.nome ASC
                """;

        TypedQuery<Cliente> typedQuery = entityManager.createQuery(jpql, Cliente.class);

        List<Cliente> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(c -> System.out.println(c.getId() + ", " + c.getNome()));
    }

    @Test
    public void usarDistinct() {
        String jpql = """
                select distinct p from Pedido p
                join p.itemPedidos i
                join i.produto prod
                where prod.id in (1, 2, 3, 4)
                """;

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(jpql, Pedido.class);

        List<Pedido> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        System.out.println(lista.size());
    }

}

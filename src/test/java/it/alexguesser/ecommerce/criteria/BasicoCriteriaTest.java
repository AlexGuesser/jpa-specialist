package it.alexguesser.ecommerce.criteria;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.ProdutoDto;
import it.alexguesser.ecommerce.model.*;
import jakarta.persistence.Tuple;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class BasicoCriteriaTest extends EntityManagerTest {

    @Test
    public void usarDistinct() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);
        root.join(Pedido_.itemPedidos);

        criteriaQuery.select(root);
        criteriaQuery.distinct(true);

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Pedido> lista = typedQuery.getResultList();

        lista.forEach(p -> System.out.println("ID: " + p.getId()));
    }

    @Test
    public void buscarPorId() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        // AQUI É ESPECIFICADO O RETORNO DA QUERY
        CriteriaQuery<Pedido> criteriaQuery = criteriaBuilder.createQuery(Pedido.class);
        // ISSO AQUI REPRESENTA A TABELA BÁSICA, O "FROM"
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        // criteriaQuery.select(root) ISSO AQUI É IMPLICÍTO
        criteriaQuery
                .select(root)
                .where(criteriaBuilder.equal(root.get("id"), 1));

        TypedQuery<Pedido> typedQuery = entityManager.createQuery(criteriaQuery);
        Pedido pedido = typedQuery.getSingleResult();
        assertNotNull(pedido);

        // CRITERIA É UM POUCO MAIS PERFORMÁTICA, PORÉ MAIS VERBOSA
    }

    @Test
    public void selecionarUmAtributoParaRetorno() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<String> criteriaQuery = criteriaBuilder.createQuery(String.class);
        Root<Pedido> root = criteriaQuery.from(Pedido.class);

        criteriaQuery
                .select(root.get("cliente").get("nome"))
                .where(criteriaBuilder.equal(root.get("id"), 1));

        TypedQuery<String> typedQuery = entityManager.createQuery(criteriaQuery);
        String nomeCliente = typedQuery.getSingleResult();
        assertNotNull(nomeCliente);
        assertEquals("Alex Guesser", nomeCliente);
    }

    @Test
    public void retornandoTodosOsProdutos() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Produto> criteriaQuery = criteriaBuilder.createQuery(Produto.class);
        criteriaQuery.from(Produto.class);

        TypedQuery<Produto> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Produto> produtos = typedQuery.getResultList();
        assertFalse(produtos.isEmpty());
        produtos.forEach(System.out::println);
    }

    @Test
    public void projetandoOResultado() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Object[]> criteriaQuery = criteriaBuilder.createQuery(Object[].class);
        Root<Produto> root = criteriaQuery.from(Produto.class);

        criteriaQuery.multiselect(root.get("id"), root.get("nome"));

        TypedQuery<Object[]> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Object[]> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(objects -> System.out.println(Arrays.toString(objects)));
    }

    @Test
    public void projetandoOResultadoComTuple() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Tuple> criteriaQuery = criteriaBuilder.createTupleQuery();
        Root<Produto> root = criteriaQuery.from(Produto.class);

        //criteriaQuery.multiselect(root.get("id"), root.get("nome"));
        criteriaQuery.select(criteriaBuilder.tuple(root.get("id").alias("id"), root.get("nome").alias("nome")));

        TypedQuery<Tuple> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Tuple> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(t -> System.out.println("ID:" + t.get("id") + ", Nome: " + t.get("nome")));
    }

    @Test
    public void projetandoOResultadoComDto() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<ProdutoDto> criteriaQuery = criteriaBuilder.createQuery(ProdutoDto.class);
        Root<Produto> root = criteriaQuery.from(Produto.class);

        criteriaQuery.select(criteriaBuilder.construct(ProdutoDto.class, root.get("id"), root.get("nome")));

        TypedQuery<ProdutoDto> typedQuery = entityManager.createQuery(criteriaQuery);
        List<ProdutoDto> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    @Test
    public void ordenarResultados() {
        CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
        CriteriaQuery<Cliente> criteriaQuery = criteriaBuilder.createQuery(Cliente.class);
        Root<Cliente> root = criteriaQuery.from(Cliente.class);

        //criteriaQuery.orderBy(criteriaBuilder.asc(root.get(Cliente_.NOME)));
        criteriaQuery.orderBy(criteriaBuilder.desc(root.get(Cliente_.NOME)));

        TypedQuery<Cliente> typedQuery = entityManager.createQuery(criteriaQuery);
        List<Cliente> lista = typedQuery.getResultList();
        assertFalse(lista.isEmpty());
        lista.forEach(System.out::println);
    }

    /*
    PAGINAÇÃO COM CRITERIA FUNCIONA DA MESMA FORMA QUE PAGINAÇÃO COM JPQL!!!
     */


}

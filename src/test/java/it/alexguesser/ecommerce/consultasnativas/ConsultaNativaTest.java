package it.alexguesser.ecommerce.consultasnativas;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.ProdutoDto;
import it.alexguesser.ecommerce.model.Categoria;
import it.alexguesser.ecommerce.model.ItemPedido;
import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.Query;
import org.junit.jupiter.api.Test;

import java.util.List;

public class ConsultaNativaTest extends EntityManagerTest {

    @Test
    public void usarNamedNativeQueryAPartirDeArquivoXml() {
        Query query = entityManager.createNamedQuery("ecm_categoria.listar");

        List<Categoria> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void usarNamedNativeQuery2() {
        Query query = entityManager.createNamedQuery("ecm_produto.listar");

        List<Produto> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void usarNamedNativeQuery1() {
        Query query = entityManager.createNamedQuery("produto_loja.listar");

        List<Produto> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void usarColumnResultParaRetornarDto() {
        String sql = """
                select * from ecm_produto
                """;
        Query query = entityManager.createNativeQuery(sql, "ecm_produto.ProdutoDto");

        List<ProdutoDto> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void usarSqlResultSetMappingComFieldResult() {
        String sql = """
                select * from ecm_produto
                """;
        Query query = entityManager.createNativeQuery(sql, "ecm_produto.Produto");

        List<Produto> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void usarSqlResultSetMapping2() {
        String sql = """
                select * from produto p
                join item_pedido ip
                on ip.produto_id = p.id
                """;
        Query query = entityManager.createNativeQuery(sql, "produto-item_pedido.Produto-ItemPedido");

        List<Object[]> lista = query.getResultList();
        lista.forEach(arr -> {
            Produto produto = (Produto) arr[0];
            ItemPedido itemPedido = (ItemPedido) arr[1];
            System.out.println(produto);
            System.out.println(itemPedido);
        });
    }

    @Test
    public void usarSqlResultSetMapping1() {
        String sql = """
                select * from produto
                """;
        Query query = entityManager.createNativeQuery(sql, "produto.Produto");

        List<Produto> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void executarSqlPassandoParametros() {
        String sql = """
                select * from produto
                where id = :id
                """;
        Query query = entityManager.createNativeQuery(sql, Produto.class);
        query.setParameter("id", 1);

        List<Produto> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void executarSqlRetornarEntidade() {
        String sql = """
                select * from produto
                """;
        Query query = entityManager.createNativeQuery(sql, Produto.class);

        List<Produto> lista = query.getResultList();
        lista.forEach(System.out::println);
    }

    @Test
    public void executarSql() {
        String sql = """
                select id, nome from produto
                """;
        Query query = entityManager.createNativeQuery(sql);

        List<Object[]> lista = query.getResultList();
        lista.forEach(
                arr -> System.out.println(arr[0] + ", " + arr[1])
        );
    }
}

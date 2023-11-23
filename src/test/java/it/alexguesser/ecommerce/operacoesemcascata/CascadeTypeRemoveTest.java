package it.alexguesser.ecommerce.operacoesemcascata;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.*;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class CascadeTypeRemoveTest extends EntityManagerTest {

    @Test
    public void removerItensPedidoAtravesDePedido() {
        Pedido pedido = entityManager.find(Pedido.class, 1);

        entityManager.getTransaction().begin();
        entityManager.remove(pedido);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
        assertNull(pedidoVerificacao);
        pedido.getItemPedidos().forEach(i -> {
            ItemPedido itemPedidoVerificacao = entityManager.find(ItemPedido.class, i.getId());
            assertNull(itemPedidoVerificacao);
        });
    }

    //@Test
    public void removerPedidoAtravesDeItemPedido() {
        ItemPedido itemPedido = entityManager.find(ItemPedido.class, new ItemPedidoId(1, 1));

        entityManager.getTransaction().begin();
        entityManager.remove(itemPedido); // PARA ESSE TESTE FUNCIONAR É PRECISO TER cascade = CascadeType.REMOVE EM ITEM PEDIDO
        entityManager.getTransaction().commit();

        entityManager.clear();

        ItemPedido itemPedidoVerificacao = entityManager.find(ItemPedido.class, itemPedido.getId());
        Pedido pedidoVerificacao = entityManager.find(Pedido.class, itemPedido.getPedido().getId());
        assertNull(itemPedidoVerificacao);
        assertNull(pedidoVerificacao);
    }

    @Test
    public void removerProdutoCategoriasAtravesDeProdutoMasNaoDeveRemoverCategoria() {
        Produto produto = entityManager.find(Produto.class, 1);
        assertFalse(produto.getCategorias().isEmpty());
        Categoria categoria = produto.getCategorias().get(0);

        entityManager.getTransaction().begin();
        produto.getCategorias().clear();
        entityManager.getTransaction().commit();

        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, 1);
        assertTrue(produtoVerificacao.getCategorias().isEmpty());
        assertNotNull(entityManager.find(Categoria.class, categoria.getId()));
    }

    @Test
    public void removerItensOrfaos() {
        /*
        orphanRemoval = true PODE SER USADO EM OneToOne e OneToMany
        BASICAMENTE "FAZ O MESMO" QUE O CascadeType.REMOVE, MAS PERMITE QUE A GENTE FAÇA A REMOÇÃO TAMBÉM EM UPDATES
         */
        Pedido pedido = entityManager.find(Pedido.class, 1);
        assertFalse(pedido.getItemPedidos().isEmpty());

        entityManager.getTransaction().begin();
        pedido.getItemPedidos().clear();
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
        assertTrue(pedidoVerificacao.getItemPedidos().isEmpty());
    }

}

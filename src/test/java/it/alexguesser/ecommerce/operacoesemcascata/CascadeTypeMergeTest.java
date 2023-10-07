package it.alexguesser.ecommerce.operacoesemcascata;

import it.alexguesser.ecommerce.BaseTest;
import it.alexguesser.ecommerce.model.*;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class CascadeTypeMergeTest extends BaseTest {

    @Test
    public void atualizarItemPedidoAtravesDePedido() {
        Cliente cliente = entityManager.find(Cliente.class, 1);
        Produto produto = entityManager.find(Produto.class, 1);

        Pedido pedido = new Pedido();
        pedido.setId(1);
        pedido.setCliente(cliente);
        pedido.setStatus(StatusPedido.AGUARDANDO);

        ItemPedido itemPedido = new ItemPedido();
        itemPedido.getId().setPedidoId(pedido.getId());
        //PARA QUE O MERGE AQUI FUNCIONE COMO ATUALIZAÇÃO, EU PRECISO SETAR ESSES IDS MANUAMENTE
        //DO CONTRÁRIO O MERGE TENTARIA FAZER UM INSERT
        itemPedido.getId().setProdutoId(produto.getId());
        itemPedido.setPedido(pedido);
        itemPedido.setProduto(produto);
        itemPedido.setQuantidade(3);
        itemPedido.setPrecoProduto(produto.getPreco());

        pedido.setItemPedidos(List.of(itemPedido));

        entityManager.getTransaction().begin();
        entityManager.merge(pedido);
        entityManager.getTransaction().commit();

        entityManager.clear();

        ItemPedido itemPedidoVerificacao = entityManager.find(ItemPedido.class, itemPedido.getId());
        assertNotNull(itemPedidoVerificacao);
        assertEquals(3, itemPedidoVerificacao.getQuantidade());
    }

    //@Test
    public void atualizarPedidoAtravesDeItemPedido() {
        Cliente cliente = entityManager.find(Cliente.class, 1);
        Produto produto = entityManager.find(Produto.class, 1);

        Pedido pedido = new Pedido();
        pedido.setId(1);
        pedido.setCliente(cliente);
        pedido.setStatus(StatusPedido.PAGO);

        ItemPedido itemPedido = new ItemPedido();
        itemPedido.getId().setPedidoId(pedido.getId());
        //PARA QUE O MERGE AQUI FUNCIONE COMO ATUALIZAÇÃO, EU PRECISO SETAR ESSES IDS MANUAMENTE
        //DO CONTRÁRIO O MERGE TENTARIA FAZER UM INSERT
        itemPedido.getId().setProdutoId(produto.getId());
        itemPedido.setPedido(pedido); //NECESSÁRIO: cascade = CascadeType.MERGE PARA FUNCIONAR
        itemPedido.setProduto(produto);
        itemPedido.setQuantidade(3);
        itemPedido.setPrecoProduto(produto.getPreco());

        entityManager.getTransaction().begin();
        entityManager.merge(itemPedido);
        entityManager.getTransaction().commit();

        entityManager.clear();

        Pedido pedidoVerificacao = entityManager.find(Pedido.class, pedido.getId());
        assertNotNull(pedidoVerificacao);
        assertEquals(StatusPedido.PAGO, pedidoVerificacao.getStatus());
    }

}

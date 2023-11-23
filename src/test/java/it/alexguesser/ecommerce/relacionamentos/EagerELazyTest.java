package it.alexguesser.ecommerce.relacionamentos;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Pedido;

public class EagerELazyTest extends EntityManagerTest {

    @Test
    public void verificarCarregamento() {
        Pedido pedido = entityManager.find(Pedido.class, 1);
        pedido.getCliente(); // AQUI JÁ É CARREGADO NO FIND

        //SÓ AQUI QUE O HIBERNATE VAI CARREGAR OS ITENS PEDIDOS DO BANCO
        pedido.getItemPedidos().isEmpty();
    }

}

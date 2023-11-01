package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;


@Entity
@Table(name = "item_pedido")
@Getter
@Setter
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@AllArgsConstructor
@NoArgsConstructor
public class ItemPedido {

    @EmbeddedId
    private ItemPedidoId id = new ItemPedidoId();

    @MapsId("pedidoId")
    @ManyToOne(optional = false)
    @JoinColumn(
            name = "pedido_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_item_pedido_pedido")
    )
    private Pedido pedido;

    @MapsId("produtoId")
    @ManyToOne(optional = false)
    @JoinColumn(
            name = "produto_id",
            foreignKey = @ForeignKey(name = "fk_item_pedido_produto")
    )
    private Produto produto;

    @Column(name = "preco_produto", nullable = false)
    private BigDecimal precoProduto;

    @Column(nullable = false)
    private Integer quantidade;

}

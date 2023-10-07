package it.alexguesser.ecommerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Id;
import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class ItemPedidoId implements Serializable {

    @Column(name = "pedido_id")
    @EqualsAndHashCode.Include
    private Integer pedidoId;

    @Column(name = "produto_id")
    @EqualsAndHashCode.Include
    private Integer produtoId;

}

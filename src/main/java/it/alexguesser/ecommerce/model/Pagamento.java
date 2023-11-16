package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "pagamento")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "tipo_pagamento")
@Getter
@Setter
public abstract class Pagamento extends EntidadeBasePKInteger {

    @MapsId
    @OneToOne(optional = false)
    @JoinColumn(
            name = "pedido_id",
            updatable = false,
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_pagamento_pedido")
    )
    private Pedido pedido;

    @Column(length = 30, nullable = false)
    @Enumerated(EnumType.STRING)
    private StatusPagamento status;

}

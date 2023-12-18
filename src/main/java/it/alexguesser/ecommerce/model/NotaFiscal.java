package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;


@Entity
@Table(name = "nota_fiscal")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class NotaFiscal extends EntidadeBasePKInteger {

    @MapsId
    @OneToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(
            name = "pedido_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_nota_fiscal_pedido")
    )
    //@JoinTable(
    //        name = "pedido_nota_fiscal",
    //        joinColumns = @JoinColumn(name = "nota_fiscal_id", unique = true),
    //        inverseJoinColumns = @JoinColumn(name = "pedido_id", unique = true)
    //)
    private Pedido pedido;

    @Lob
    @Column(length = 1000, nullable = false)
    private byte[] xml;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "data_emissao", nullable = false)
    private Date dataEmissao;

}

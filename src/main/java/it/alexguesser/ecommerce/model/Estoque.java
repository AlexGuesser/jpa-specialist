package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.*;


@Entity(name = "estoque")
@Getter
@Setter
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@AllArgsConstructor
@NoArgsConstructor
public class Estoque {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Integer id;

    @OneToOne(optional = false)
    @JoinColumn(
            name = "produto_id",
            foreignKey = @ForeignKey(name = "fk_estoque_produto")
    )
    private Produto produto;

    private Integer quantidade;

}

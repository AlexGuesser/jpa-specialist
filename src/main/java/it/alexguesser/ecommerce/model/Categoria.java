package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;


@Entity
@Table(
        name = "categoria",
        uniqueConstraints = {
                @UniqueConstraint(name = "unq_nome", columnNames = {"nome"})
        }
)
@Getter
@Setter
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@AllArgsConstructor
@NoArgsConstructor
public class Categoria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Integer id;

    @Column(length = 100, nullable = false)
    private String nome;

    @ManyToOne
    @JoinColumn(
            name = "categoria_pai_id",
            foreignKey = @ForeignKey(name = "fk_categoria_categoria")
    )
    private Categoria categoriaPai;

    @OneToMany(mappedBy = "categoriaPai")
    private List<Categoria> categorias;

    @ManyToMany(mappedBy = "categorias")
    private List<Produto> produtos;

}

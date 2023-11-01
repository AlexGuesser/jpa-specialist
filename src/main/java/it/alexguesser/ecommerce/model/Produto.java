package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Length;

import java.math.BigDecimal;
import java.util.List;

@Entity
@Table(
        name = "produto",
        uniqueConstraints = {
                @UniqueConstraint(name = "unq_nome", columnNames = {"nome"})
        },
        indexes = {
                @Index(name = "idx_nome", columnList = "nome")
        }
)
@Getter
@Setter
@NamedQueries(
        @NamedQuery(name = "Produto.listar", query = "select p from Produto p")
)
public class Produto extends EntidadeComDataCriacaoEAtualizacao {

    @Column(length = 100, nullable = false) // POR PADRÃO SERIA nome varchar(255)
    private String nome;

    @Lob
    @Column(length = Length.LONG16)
    private String descricao;

    @Column(precision = 10, scale = 2) // preco decimal(10,2)
    private BigDecimal preco;

    @OneToMany(mappedBy = "produto")
    List<ItemPedido> itemPedidos;

    // EM RELAÇÕES MANY TO MANY NÃO FAZ SENTIDO TER CASCADETYPE.REMOVE!
    @ManyToMany(cascade = CascadeType.PERSIST)
    @JoinTable(
            name = "produto_categoria",
            joinColumns = @JoinColumn(
                    name = "produto_id",
                    nullable = false,
                    foreignKey = @ForeignKey(name = "fk_produto_categoria_produto")
            ),
            inverseJoinColumns = @JoinColumn(
                    name = "categoria_id",
                    nullable = false,
                    foreignKey = @ForeignKey(name = "fk_produto_categoria_categoria")
            )
    )
    private List<Categoria> categorias;

    @OneToOne(mappedBy = "produto")
    private Estoque estoque;

    @ElementCollection
    @CollectionTable(
            name = "produto_tag",
            joinColumns = @JoinColumn(
                    name = "produto_id",
                    foreignKey = @ForeignKey(name = "fk_produto_tag_produto")
            )
    )
    @Column(name = "tag", length = 50, nullable = false)
    private List<String> tags;

    @ElementCollection
    @CollectionTable(
            name = "produto_atributo",
            joinColumns = @JoinColumn(name = "produto_id", foreignKey = @ForeignKey(name = "fk_produto_atributo_produto")))
    private List<Atributo> atributos;

    @Lob
    @Column(length = 100)
    private byte[] foto;

    @Override
    protected void prePersist() {

    }

    @Override
    protected void preUpdate() {

    }

    @Override
    public String toString() {
        return "Produto{" +
                "nome='" + nome + '\'' +
                ", descricao='" + descricao + '\'' +
                ", preco=" + preco +
                '}';
    }
}

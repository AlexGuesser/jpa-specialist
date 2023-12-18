package it.alexguesser.ecommerce.model;

import it.alexguesser.ecommerce.ProdutoDto;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
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
@NamedNativeQueries({
        @NamedNativeQuery(
                name = "produto_loja.listar",
                query = "select * from produto",
                resultClass = Produto.class
        ),
        @NamedNativeQuery(
                name = "ecm_produto.listar",
                query = "select * from ecm_produto",
                resultSetMapping = "ecm_produto.Produto"
        )
}
)
@SqlResultSetMappings(
        {
                @SqlResultSetMapping(
                        name = "produto.Produto",
                        entities = {
                                @EntityResult(entityClass = Produto.class)
                        }),
                @SqlResultSetMapping(
                        name = "produto-item_pedido.Produto-ItemPedido",
                        entities = {
                                @EntityResult(entityClass = Produto.class),
                                @EntityResult(entityClass = ItemPedido.class)
                        }),
                @SqlResultSetMapping(
                        name = "ecm_produto.Produto",
                        entities = {
                                @EntityResult(
                                        entityClass = Produto.class,
                                        fields = {
                                                @FieldResult(name = "id", column = "prd_id"),
                                                @FieldResult(name = "nome", column = "prd_nome"),
                                                @FieldResult(name = "descricao", column = "prd_descricao"),
                                                @FieldResult(name = "preco", column = "prd_preco"),
                                                @FieldResult(name = "foto", column = "prd_foto"),
                                                @FieldResult(name = "dataCriacao", column = "prd_data_criacao"),
                                                @FieldResult(name = "dataUltimaAtualizacao", column = "prd_data_ultima_atualizacao"),
                                        }
                                )
                        }),
                @SqlResultSetMapping(
                        name = "ecm_produto.ProdutoDto",
                        classes = {
                                @ConstructorResult(
                                        targetClass = ProdutoDto.class,
                                        columns = {
                                                @ColumnResult(name = "prd_id", type = Integer.class),
                                                @ColumnResult(name = "prd_nome", type = String.class)
                                        }
                                )
                        }
                )
        }
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

    @Column(length = 3, nullable = false)
    @NotNull
    @Convert(converter = BooleanToSimNaoConverter.class)
    private Boolean ativo = Boolean.TRUE;

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

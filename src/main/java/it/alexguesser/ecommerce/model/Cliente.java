package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;


@Entity
@Table(
        name = "cliente",
        uniqueConstraints = {
                @UniqueConstraint(name = "unq_cpf", columnNames = {"cpf"})
        },
        indexes = {@Index(name = "idx_nome", columnList = "nome")}
)
@SecondaryTable(
        name = "cliente_detalhe",
        pkJoinColumns = @PrimaryKeyJoinColumn(name = "cliente_id"),
        foreignKey = @ForeignKey(name = "fk_cliente_detalhe_cliente")
)
@NamedStoredProcedureQuery(
        name = "compraram_acima_media",
        procedureName = "compraram_acima_media",
        resultClasses = {
                Cliente.class
        },
        parameters = {
                @StoredProcedureParameter(
                        name = "ano",
                        type = Integer.class,
                        mode = ParameterMode.IN
                )
        }
)
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Cliente extends EntidadeBasePKInteger {

    @Column(length = 100, nullable = false)
    private String nome;

    @Transient
    private String primeiroNome;

    @Column(length = 14, nullable = false)
    private String cpf;

    @Column(name = "sexo_cliente", table = "cliente_detalhe", length = 30, nullable = false)
    @Enumerated(EnumType.STRING)
    private SexoCliente sexoCliente;

    @Column(name = "data_nascimento", table = "cliente_detalhe")
    private LocalDate dataNascimento;

    @OneToMany(mappedBy = "cliente")
    private List<Pedido> pedidos;

    @ElementCollection
    @CollectionTable(
            name = "cliente_contato",
            joinColumns = @JoinColumn(name = "cliente_id", foreignKey = @ForeignKey(name = "fk_cliente_contato_contato"))
    )
    @MapKeyColumn(name = "tipo")
    @Column(name = "descricao")
    private Map<String, String> contatos;

    public Cliente(String nome, SexoCliente sexoCliente, String cpf) {
        this(null, nome, sexoCliente, cpf);
    }

    public Cliente(Integer id, String nome, SexoCliente sexoCliente, String cpf) {
        super(id);
        this.nome = nome;
        this.sexoCliente = sexoCliente;
        this.cpf = cpf;
    }

    @PostLoad
    public void configurarPrimeiroNome() {
        if (nome != null && !nome.isBlank()) {
            int espacoIndex = nome.indexOf(" ");
            if (espacoIndex > -1) {
                primeiroNome = nome.substring(0, espacoIndex);
            }
        }
    }

    @Override
    public String toString() {
        return "Cliente{" +
                "nome='" + nome + '\'' +
                ", primeiroNome='" + primeiroNome + '\'' +
                ", cpf='" + cpf + '\'' +
                ", sexoCliente=" + sexoCliente +
                ", dataNascimento=" + dataNascimento +
                '}';
    }
}

package it.alexguesser.ecommerce.model;

import it.alexguesser.ecommerce.listener.GerarNotaFiscalListener;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;


@Entity
@Table(name = "pedido")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@EntityListeners(GerarNotaFiscalListener.class)
public class Pedido extends EntidadeComDataCriacaoEAtualizacao {

    @ManyToOne(optional = false)
    @JoinColumn(
            name = "cliente_id",
            nullable = false,
            foreignKey = @ForeignKey(name = "fk_pedido_cliente")
    )
    @NotNull
    private Cliente cliente; // QUANDO A PROPRIEDADE NÃO É UMA COLEÇÃO O CARREGAMENTO É EAGER POR PADRÃO
    // MAS CLARO, PODEMOS FAZER OVERRIDE DESSE COMPORTAMENTO COM O fetch
    // SOBRE optional:
    // POR PADRÃO É TRUE E COM ISSO O HIBERNATE USA LEFT OUTER JOIN (MENOS PERFORMÁTICO)
    // USANDO optional = flase O HIBERNATE VAI USAR INNER JOIN

    @Column(name = "data_conclussao")
    @PastOrPresent
    private LocalDateTime dataConclusao;

    @OneToOne(mappedBy = "pedido")
    private NotaFiscal notaFiscal;

    @Column(length = 30, nullable = false)
    @Enumerated(EnumType.STRING)
    private StatusPedido status;

    @Column(nullable = false)
    @PositiveOrZero
    private BigDecimal total;

    @Embedded
    private EnderecoEntregaPedido enderecoEntrega;

    @OneToMany(mappedBy = "pedido", cascade = CascadeType.ALL, orphanRemoval = true)
    List<ItemPedido> itemPedidos; // QUANDO É UMA LISTA O CARREGAMENTO É LAZY POR PADRÃO
    // MAS CLARO, PODEMOS FAZER OVERRIDE DESSE COMPORTAMENTO COM O fetch

    @OneToOne(mappedBy = "pedido")
    private Pagamento pagamento;

    public boolean isPago() {
        return StatusPedido.PAGO.equals(status);
    }

    // SÓ PODE TER UMA CALLBACK DE CADA TIPO POR CLASSE
    //    @PrePersist
    //    @PreUpdate
    public void calcularTotal() {
        if (itemPedidos == null) {
            total = BigDecimal.ZERO;
            return;
        }
        total = itemPedidos.stream()
                .map(i ->
                        new BigDecimal(i.getQuantidade()).multiply(i.getPrecoProduto())
                )
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Override
    protected void prePersist() {
        calcularTotal();
    }

    @Override
    protected void preUpdate() {
        calcularTotal();
    }
}

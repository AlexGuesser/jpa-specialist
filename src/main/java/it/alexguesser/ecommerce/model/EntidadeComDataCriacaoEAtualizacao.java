package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@MappedSuperclass
public abstract class EntidadeComDataCriacaoEAtualizacao extends EntidadeBasePKInteger {

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "data_criacao", updatable = false, nullable = false)
    private LocalDateTime dataCriacao;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "data_ultima_atualizacao", insertable = false)
    private LocalDateTime dataUltimaAtualizacao;

    protected abstract void prePersist();

    protected abstract void preUpdate();

    @PrePersist
    public void aoPersistir() {
        dataCriacao = LocalDateTime.now();
        prePersist();
    }

    @PreUpdate
    public void aoAtualizar() {
        dataUltimaAtualizacao = LocalDateTime.now();
        preUpdate();
    }

    //    @PostPersist
    //    @PostUpdate
    //    @PreRemove
    //    @PostRemove
    //    @PostLoad

}

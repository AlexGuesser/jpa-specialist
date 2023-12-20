package it.alexguesser.ecommerce.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter
@Setter
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@AllArgsConstructor
@NoArgsConstructor
@MappedSuperclass
public class EntidadeBasePKInteger {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private Integer id;

    @Version
    @Column(columnDefinition = "integer not null default 0")
    private Integer versao = 0;

    @NotBlank
    @Column(columnDefinition = "varchar(100) not null default 'algaworks'", updatable = false)
    private String tenant = "algaworks";

}

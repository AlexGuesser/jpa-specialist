package it.alexguesser.ecommerce.service;

import it.alexguesser.ecommerce.model.Produto;
import it.alexguesser.ecommerce.repository.Produtos;
import jakarta.transaction.Transactional;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;
import java.util.Map;

@Service
public class ProdutoService {

    @Autowired
    private Produtos produtos;

    @Transactional
    public Produto criar(String tenant, Produto produto) {
        produto.setTenant(tenant);
        produto.setDataCriacao(LocalDateTime.now());

        return produtos.salvar(produto);
    }

    @Transactional
    public Produto atualizar(Integer id, String tenant, Map<String, Object> produto) {
        Produto produtoAtual = produtos.buscar(id, tenant);

        try {
            BeanUtils.populate(produtoAtual, produto);
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }

        produtoAtual.setDataUltimaAtualizacao(LocalDateTime.now());

        return produtos.salvar(produtoAtual);
    }
}
package it.alexguesser.ecommerce.iniciandocomjpa;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.math.BigDecimal;

import org.junit.jupiter.api.Test;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.Produto;

public class OperacoesComTransacaoTest extends EntityManagerTest {

    @Test
    public void abrirEFecharTransacao() {
        Produto produto = new Produto();

        entityManager.getTransaction().begin();

        //entityManager.persist(produto);
        //entityManager.merge(produto);
        //entityManager.remove(produto);

        entityManager.getTransaction().commit();
    }

    @Test
    public void inserirOPrimeiroObjeto() {
        Produto produto = new Produto();
        produto.setNome("Câmera Canon");
        produto.setDescricao("A melhor camera");
        produto.setPreco(new BigDecimal("5000"));

        entityManager.getTransaction().begin();
        entityManager.persist(produto); // ESSE MÉTODO NÃO PRECISA ESTAR DENTRO DOS MÉTODOS begin() e commit()
        entityManager.getTransaction().commit();

        // CLEAR LIMPA A MEMÓRIA DO ENTITY MANAGER, SEM USAR O CLEAR O FIND ABAIXO NÃO BATE NO BANCO DE DADOS
        // MAS USA O VALOR EM MEMÓRIA
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        assertNotNull(produtoVerificacao);
    }

    @Test
    public void removerObjeto() {
        Produto produto = entityManager.find(Produto.class, 3);
        entityManager.getTransaction().begin();
        entityManager.remove(produto);
        entityManager.getTransaction().commit();

        // entityManager.clear() AQUI NÃO É NECESSÁRIO PORQUE O .remove() REMOVE TAMBÉM DA MEMÓRIA DO ENTITYMANAGER

        Produto produtoVerificacao = entityManager.find(Produto.class, 3);
        assertNull(produtoVerificacao);
    }

    @Test
    public void atualizarObjeto() {
        Produto produto = new Produto();
        produto.setId(1);
        produto.setNome("Kindle Paperwhite");
        produto.setDescricao("Conheça o novo Kindle");
        produto.setPreco(new BigDecimal("755.99"));

        entityManager.getTransaction().begin();
        entityManager.merge(produto);
        entityManager.getTransaction().commit();

        // CLEAR LIMPA A MEMÓRIA DO ENTITY MANAGER, SEM USAR O CLEAR O FIND ABAIXO NÃO BATE NO BANCO DE DADOS
        // MAS USA O VALOR EM MEMÓRIA
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        assertNotNull(produtoVerificacao);
        assertEquals(produtoVerificacao.getNome(), produto.getNome());
    }

    @Test
    public void atualizarObjetoGerenciado() {
        Produto produto = entityManager.find(Produto.class, 1);
        produto.setNome("Kindle Paperwhite 2");

        entityManager.getTransaction().begin();
        // entityManager.merge(produto); AQUI NÃO É NECESSÁRIO PORQUE O ENTITY MANAGER JÁ ESTÁ GERENCIANDO O OBJETO
        entityManager.getTransaction().commit();

        // CLEAR LIMPA A MEMÓRIA DO ENTITY MANAGER, SEM USAR O CLEAR O FIND ABAIXO NÃO BATE NO BANCO DE DADOS
        // MAS USA O VALOR EM MEMÓRIA
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        assertEquals(produtoVerificacao.getNome(), produto.getNome());
    }

    @Test
    public void inserirObjetoComMerge() {
        Produto produto = new Produto();
        produto.setNome("Microfone");
        produto.setDescricao("O melhor microfone");
        produto.setPreco(new BigDecimal("1000"));

        entityManager.getTransaction().begin();
        produto = entityManager.merge(produto); // ESSE MÉTODO NÃO PRECISA ESTAR DENTRO DOS MÉTODOS begin() e commit()
        entityManager.getTransaction().commit();

        //MERGE PODE SER UTILIZADO PARA INSERT E UPDATE

        // CLEAR LIMPA A MEMÓRIA DO ENTITY MANAGER, SEM USAR O CLEAR O FIND ABAIXO NÃO BATE NO BANCO DE DADOS
        // MAS USA O VALOR EM MEMÓRIA
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        assertNotNull(produtoVerificacao);
    }

    @Test
    public void persistVersusMerge() {
        // O MÉTODO persist SÓ FAZ INSERT!
        Produto produtoPersist = new Produto();
        produtoPersist.setNome("Teclado");
        produtoPersist.setDescricao("O melhor teclado");
        produtoPersist.setPreco(new BigDecimal("1000"));

        entityManager.getTransaction().begin();
        entityManager.persist(produtoPersist); // ESSE MÉTODO NÃO PRECISA ESTAR DENTRO DOS MÉTODOS begin() e commit()
        produtoPersist.setDescricao("O melhor teclado (ATUALIZADO)");
        entityManager.getTransaction().commit();

        //MERGE PODE SER UTILIZADO PARA INSERT E UPDATE

        // CLEAR LIMPA A MEMÓRIA DO ENTITY MANAGER, SEM USAR O CLEAR O FIND ABAIXO NÃO BATE NO BANCO DE DADOS
        // MAS USA O VALOR EM MEMÓRIA
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produtoPersist.getId());
        assertNotNull(produtoVerificacao);

        //MERGE PODE SER UTILIZADO PARA INSERT E UPDATE
        Produto produtoMerge = new Produto();
        produtoMerge.setNome("Mouse");
        produtoMerge.setDescricao("O melhor mouse");
        produtoMerge.setPreco(new BigDecimal("1000"));

        entityManager.getTransaction().begin();
        //entityManager.merge(produtoMerge); // merge CRIA UMA CÓPIA DO OUTRO OBJETO, O OBJETO ORIGINAL NÃO É GERENCIADO, O SET ABAIXO NÃO TEM EFEITO
        // PARA PEGAR A CÓPIA É SO ATUALIZAR A VARIAVÉL COM O RETORNO DO MERGE
        produtoMerge = entityManager.merge(produtoMerge);
        produtoMerge.setDescricao("O melhor mouse (ATUALIZADO)");
        entityManager.getTransaction().commit();

        // CLEAR LIMPA A MEMÓRIA DO ENTITY MANAGER, SEM USAR O CLEAR O FIND ABAIXO NÃO BATE NO BANCO DE DADOS
        // MAS USA O VALOR EM MEMÓRIA
        entityManager.clear();
        Produto produtoVerificacao2 = entityManager.find(Produto.class, produtoMerge.getId());
        assertNotNull(produtoVerificacao2);
        assertEquals(produtoMerge.getDescricao(), produtoVerificacao2.getDescricao());
    }

    @Test
    public void impedirOperacaoComBancoDeDados() {
        Produto produto = entityManager.find(Produto.class, 1);
        String nomeAntigoDoProduto = produto.getNome();
        produto.setNome("Kindle Paperwhite 2");
        // O DETACH REMOVE O OBJETO DA MÉMORIA DO ENTITY MANAGER, NESTE CASO O OBJETO NÃO VAI TROCAR DE NOME!
        entityManager.detach(produto);

        entityManager.getTransaction().begin();
        // entityManager.merge(produto); AQUI NÃO É NECESSÁRIO PORQUE O ENTITY MANAGER JÁ ESTÁ GERENCIANDO O OBJETO
        entityManager.getTransaction().commit();

        // CLEAR LIMPA A MEMÓRIA DO ENTITY MANAGER, SEM USAR O CLEAR O FIND ABAIXO NÃO BATE NO BANCO DE DADOS
        // MAS USA O VALOR EM MEMÓRIA
        entityManager.clear();
        Produto produtoVerificacao = entityManager.find(Produto.class, produto.getId());
        assertEquals(produtoVerificacao.getNome(), nomeAntigoDoProduto);
    }

}

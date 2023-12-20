package it.alexguesser.ecommerce.multitenant;

import it.alexguesser.ecommerce.EntityManagerFactoryTest;
import it.alexguesser.ecommerce.hibernate.EcmCurrentTenantIdentifierResolver;
import it.alexguesser.ecommerce.model.Produto;
import jakarta.persistence.EntityManager;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class MultiTenantTest extends EntityManagerFactoryTest {

//    @Test
//    public void usarAbordagemPorSchema() {
//        EcmCurrentTenantIdentifierResolver.setTenantIdentifier("algaworks_ecommerce");
//        EntityManager em1 = entityManagerFactory.createEntityManager();
//        Produto produto1Em1 = em1.find(Produto.class, 1);
//        assertEquals("Kindle", produto1Em1.getNome());
//        em1.close();
//
//        EcmCurrentTenantIdentifierResolver.setTenantIdentifier("loja_ecommerce");
//        EntityManager em2 = entityManagerFactory.createEntityManager();
//        Produto produto1Em2 = em2.find(Produto.class, 1);
//        assertEquals("Kindle from another schema", produto1Em2.getNome());
//        em2.close();
//    }

}

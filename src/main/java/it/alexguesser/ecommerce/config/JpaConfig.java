package it.alexguesser.ecommerce.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import jakarta.persistence.EntityManagerFactory;

@EnableTransactionManagement
@Configuration
public class JpaConfig {

    @Bean
    public JpaTransactionManager jpaTransactionManager(EntityManagerFactory emf) {
        // Esse manager gerencia as transações
        return new JpaTransactionManager(emf);
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
        // AQUI É CRIADO O EntityManagerFactory
        LocalContainerEntityManagerFactoryBean bean = new LocalContainerEntityManagerFactoryBean();

        bean.setPersistenceUnitName("Ecommerce-PU");
        bean.setJpaVendorAdapter(new HibernateJpaVendorAdapter());

        return bean;
    }
}

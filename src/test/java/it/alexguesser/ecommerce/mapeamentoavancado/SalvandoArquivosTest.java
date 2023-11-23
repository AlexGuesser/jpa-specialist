package it.alexguesser.ecommerce.mapeamentoavancado;

import it.alexguesser.ecommerce.EntityManagerTest;
import it.alexguesser.ecommerce.model.NotaFiscal;
import it.alexguesser.ecommerce.model.Pedido;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class SalvandoArquivosTest extends EntityManagerTest {

    @Test
    public void salvarXmlNota() {
        Pedido pedido = entityManager.find(Pedido.class, 1);

        NotaFiscal notaFiscal = new NotaFiscal();
        notaFiscal.setPedido(pedido);
        notaFiscal.setDataEmissao(new Date());
        notaFiscal.setXml(carregarNotaFiscal());

        entityManager.getTransaction().begin();
        entityManager.persist(notaFiscal);
        entityManager.getTransaction().commit();
        entityManager.clear();

        NotaFiscal notaFiscalVerificacao = entityManager.find(NotaFiscal.class, notaFiscal.getId());
        assertNotNull(notaFiscal.getXml());
        assertTrue(notaFiscal.getXml().length > 0);

//        try {
//            OutputStream out = new FileOutputStream(
//                    Files.createFile(Paths.get(System.getProperty("user.home") + "/xml.xml")).toFile()
//            );
//            out.write(notaFiscalVerificacao.getXml());
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
    }

    private static byte[] carregarNotaFiscal() {
        try {
            return SalvandoArquivosTest.class.getResourceAsStream("/nota-fiscal.xml").readAllBytes();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}

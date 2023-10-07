package it.alexguesser.ecommerce.service;

import it.alexguesser.ecommerce.model.Pedido;

public class NotaFiscalService {

    public void gerar(Pedido pedido) {
        System.out.println("GERANDO NOTA FISCAL PARA O PEDIDO: " + pedido);
    }

}

package it.alexguesser.ecommerce.hibernate;

public class EcmCurrentTenantIdentifierResolver implements org.hibernate.context.spi.CurrentTenantIdentifierResolver {

    private static final ThreadLocal<String> tl = new ThreadLocal<>();

    public static void setTenantIdentifier(String tenantId) {
        tl.set(tenantId);
    }

    @Override
    public String resolveCurrentTenantIdentifier() {
        return tl.get() == null ? "algaworks_ecommerce" : tl.get();
    }

    @Override
    public boolean validateExistingCurrentSessions() {
        return false;
    }
}

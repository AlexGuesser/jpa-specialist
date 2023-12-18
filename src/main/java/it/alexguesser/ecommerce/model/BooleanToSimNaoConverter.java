package it.alexguesser.ecommerce.model;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter
public class BooleanToSimNaoConverter implements AttributeConverter<Boolean, String> {
    @Override
    public String convertToDatabaseColumn(Boolean trueOuFalse) {
        if (trueOuFalse) {
            return "SIM";
        }
        return "NAO";
    }

    @Override
    public Boolean convertToEntityAttribute(String simOuNao) {
        return "SIM".equals(simOuNao);
    }
}

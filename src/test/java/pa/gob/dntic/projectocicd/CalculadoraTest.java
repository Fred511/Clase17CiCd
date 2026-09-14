package pa.gob.dntic.projectocicd;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculadoraTest {
    @Test
    void suma_dos_numeros() {
        assertEquals(5,new Calculadora().sumar(2,3));
    }
}

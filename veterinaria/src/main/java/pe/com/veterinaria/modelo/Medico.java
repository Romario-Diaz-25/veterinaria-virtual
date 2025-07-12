package pe.com.veterinaria.modelo;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "medico")
@Data
public class Medico {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "dni")
    private String dni;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "especialidad")
    private String especialidad;
}

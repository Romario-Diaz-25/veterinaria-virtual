package pe.com.veterinaria.modelo;
import java.sql.Date;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "citamedica")
@Data
public class CitaMedica {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "motivo")
    private String motivo;

    @Column(name = "fecha")
    private String fecha;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idMedico")
    @JsonBackReference
    private Medico medico;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idPaciente")
    @JsonBackReference
    private Paciente paciente;
}

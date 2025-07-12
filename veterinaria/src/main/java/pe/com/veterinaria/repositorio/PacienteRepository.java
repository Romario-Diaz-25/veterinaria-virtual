package pe.com.veterinaria.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.com.veterinaria.modelo.Paciente;


@Repository
public interface PacienteRepository extends JpaRepository<Paciente, Long>  {
}

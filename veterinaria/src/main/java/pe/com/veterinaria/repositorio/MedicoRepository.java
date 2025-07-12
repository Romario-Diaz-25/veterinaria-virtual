package pe.com.veterinaria.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import pe.com.veterinaria.modelo.Medico;

@Repository
public interface MedicoRepository extends JpaRepository<Medico, Long> {
}

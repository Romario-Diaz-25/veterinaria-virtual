package pe.com.veterinaria.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pe.com.veterinaria.modelo.Tutor;

@Repository
public interface TutorRepository extends JpaRepository<Tutor, Long> {
}

package pe.com.veterinaria.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import pe.com.veterinaria.modelo.CitaMedica;
import pe.com.veterinaria.repositorio.CitaMedicaRepository;

@Service
public class CitaMedicaService {
    private final CitaMedicaRepository citaMedicaRepository;

    public CitaMedicaService(CitaMedicaRepository citaMedicaRepository) {
        this.citaMedicaRepository = citaMedicaRepository;
    }

    public List<CitaMedica> listarTodos() {
        return citaMedicaRepository.findAll();
    }

    public Optional<CitaMedica> obtenerPorId(Long id) {
        return citaMedicaRepository.findById(id);
    }

    public CitaMedica guardar(CitaMedica paciente) {
        return citaMedicaRepository.save(paciente);
    }

    public void eliminar(Long id) {
        citaMedicaRepository.deleteById(id);
    }
}

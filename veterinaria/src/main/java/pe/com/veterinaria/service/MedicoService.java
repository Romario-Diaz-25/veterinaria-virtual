package pe.com.veterinaria.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import pe.com.veterinaria.modelo.Medico;
import pe.com.veterinaria.repositorio.MedicoRepository;

@Service
public class MedicoService {
    private final MedicoRepository medicoRepository;

    public MedicoService(MedicoRepository medicoRepository) {
        this.medicoRepository = medicoRepository;
    }

    public List<Medico> listarTodos() {
        return medicoRepository.findAll();
    }

    public Optional<Medico> obtenerPorId(Long id) {
        return medicoRepository.findById(id);
    }

    public Medico guardar(Medico paciente) {
        return medicoRepository.save(paciente);
    }

    public void eliminar(Long id) {
        medicoRepository.deleteById(id);
    }
}

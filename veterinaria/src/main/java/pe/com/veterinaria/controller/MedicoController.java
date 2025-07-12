package pe.com.veterinaria.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.com.veterinaria.modelo.Medico;
import pe.com.veterinaria.service.MedicoService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/medico")

public class MedicoController {
        private final MedicoService medicoService;

    public MedicoController(MedicoService medicoService) {
        this.medicoService = medicoService;
    }

    @GetMapping
    public List<Medico> listar() {
        return medicoService.listarTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Medico> obtenerPorId(@PathVariable Long id) {
        Optional<Medico> tutor = medicoService.obtenerPorId(id);
        return tutor.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Medico> crear(@RequestBody Medico tutor) {
        Medico nuevoTutor = medicoService.guardar(tutor);
        return ResponseEntity.ok(nuevoTutor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Medico> actualizar(@PathVariable Long id, @RequestBody Medico tutorActualizado) {
        Optional<Medico> tutorExistente = medicoService.obtenerPorId(id);
        if (tutorExistente.isPresent()) {
            tutorActualizado.setId(id);
            return ResponseEntity.ok(medicoService.guardar(tutorActualizado));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        medicoService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}

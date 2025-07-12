package pe.com.veterinaria.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.com.veterinaria.modelo.Tutor;
import pe.com.veterinaria.service.TutorService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/tutor")
public class TutorController {
    private final TutorService tutorService;

    public TutorController(TutorService tutorService) {
        this.tutorService = tutorService;
    }

    @GetMapping
    public List<Tutor> listar() {
        return tutorService.listarTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Tutor> obtenerPorId(@PathVariable Long id) {
        Optional<Tutor> tutor = tutorService.obtenerPorId(id);
        return tutor.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Tutor> crear(@RequestBody Tutor tutor) {
        Tutor nuevoTutor = tutorService.guardar(tutor);
        return ResponseEntity.ok(nuevoTutor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Tutor> actualizar(@PathVariable Long id, @RequestBody Tutor tutorActualizado) {
        Optional<Tutor> tutorExistente = tutorService.obtenerPorId(id);
        if (tutorExistente.isPresent()) {
            tutorActualizado.setId(id);
            return ResponseEntity.ok(tutorService.guardar(tutorActualizado));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        tutorService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}

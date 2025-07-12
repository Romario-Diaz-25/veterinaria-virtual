package pe.com.veterinaria.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.com.veterinaria.modelo.CitaMedica;
import pe.com.veterinaria.service.CitaMedicaService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/citamedica")
public class CitaMedicaController {
    private final CitaMedicaService citaMedicaService;

    public CitaMedicaController(CitaMedicaService citaMedicaService) {
        this.citaMedicaService = citaMedicaService;
    }

    @GetMapping
    public List<CitaMedica> listar() {
        return citaMedicaService.listarTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<CitaMedica> obtenerPorId(@PathVariable Long id) {
        Optional<CitaMedica> tutor = citaMedicaService.obtenerPorId(id);
        return tutor.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<CitaMedica> crear(@RequestBody CitaMedica tutor) {
        CitaMedica nuevoTutor = citaMedicaService.guardar(tutor);
        return ResponseEntity.ok(nuevoTutor);
    }

    @PutMapping("/{id}")
    public ResponseEntity<CitaMedica> actualizar(@PathVariable Long id, @RequestBody CitaMedica tutorActualizado) {
        Optional<CitaMedica> tutorExistente = citaMedicaService.obtenerPorId(id);
        if (tutorExistente.isPresent()) {
            tutorActualizado.setId(id);
            return ResponseEntity.ok(citaMedicaService.guardar(tutorActualizado));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        citaMedicaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}

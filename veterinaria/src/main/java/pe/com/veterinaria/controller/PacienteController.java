package pe.com.veterinaria.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.com.veterinaria.modelo.Paciente;
import pe.com.veterinaria.service.PacienteService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/paciente")
public class PacienteController {
    private final PacienteService pacienteService;

    public PacienteController(PacienteService pacienteService) {
        this.pacienteService = pacienteService;
    }

    @GetMapping
    public List<Paciente> listar() {
        return pacienteService.listarTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Paciente> obtenerPorId(@PathVariable Long id) {
        Optional<Paciente> paciente = pacienteService.obtenerPorId(id);
        return paciente.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Paciente> crear(@RequestBody Paciente paciente) {
        System.out.println(paciente);
        Paciente nuevopaciente = pacienteService.guardar(paciente);
        return ResponseEntity.ok(nuevopaciente);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Paciente> actualizar(@PathVariable Long id, @RequestBody Paciente pacienteActualizado) {
        Optional<Paciente> pacienteExistente = pacienteService.obtenerPorId(id);
        if (pacienteExistente.isPresent()) {
            pacienteActualizado.setId(id);
            return ResponseEntity.ok(pacienteService.guardar(pacienteActualizado));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        pacienteService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}

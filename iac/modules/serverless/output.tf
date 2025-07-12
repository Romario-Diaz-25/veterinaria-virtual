output "crear_cita_funcion_arn" {
  description = "ARN de la función para crear citaes"
  value       = aws_lambda_function.crear_cita.arn
}
output "crear_cita_funcion_name" {
  description = "Nombre de la función Lambda para crear citaes"
  value       = aws_lambda_function.crear_cita.function_name
}
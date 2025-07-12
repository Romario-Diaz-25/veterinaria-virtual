resource "aws_cloudwatch_event_bus" "citas_bus" {
    name = "citaes-bus"
}

resource "aws_cloudwatch_event_rule" "crear_cita" {
    name           = "crear-cita"
    description    = "Regla para crear cita desde evento personalizado"
    event_bus_name = aws_cloudwatch_event_bus.citas_bus.name
    event_pattern = jsonencode({
        source       = ["pe.com.veterinariavirtual"],
        "detail-type": ["crear-cita"]
    })
}

resource "aws_cloudwatch_event_target" "target_lambda_crear_cita" {
    rule      = aws_cloudwatch_event_rule.crear_cita.name
    target_id = "crear-cita-lambda"
    arn       = var.crear_cita_funcion_arn
    event_bus_name = aws_cloudwatch_event_bus.citas_bus.name
}

resource "aws_lambda_permission" "allow_eventbridge" {
    statement_id  = "AllowExecutionFromEventBridge"
    action        = "lambda:InvokeFunction"
    function_name = var.crear_cita_funcion_name
    principal     = "events.amazonaws.com"
    source_arn    = aws_cloudwatch_event_rule.crear_cita.arn
}
resource "aws_apigatewayv2_api" "http_api" {
  name          = "veterinaria-virtual-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["*"]
  }
}

resource "aws_apigatewayv2_integration" "medico_integration_get_all" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/medico"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_integration" "medico_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/medico/{proxy}"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_integration" "tutor_integration_get_all" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/tutor"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_integration" "tutor_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/tutor/{proxy}"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_integration" "paciente_integration_get_all" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/paciente"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_integration" "paciente_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/paciente/{proxy}"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}


resource "aws_apigatewayv2_integration" "citamedica_integration_get_all" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/citamedica"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_integration" "citamedica_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "HTTP_PROXY"
  integration_uri        = "http://${var.load_balancer_url}/api/citamedica/{proxy}"
  integration_method     = "ANY"
  payload_format_version = "1.0"
}

resource "aws_apigatewayv2_integration" "eventbridge_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_subtype    = "EventBridge-PutEvents"
  credentials_arn        = var.rol_lab_arn

  request_parameters = {
    Source       = "pe.com.veterinariavirtual"
    DetailType   = "crear-cita"
    Detail       = "$request.body"
    EventBusName = var.event_bus_name
  }

  payload_format_version = "1.0"
  timeout_milliseconds   = 10000
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 500
    throttling_rate_limit  = 1000
  }

  route_settings {
    route_key     = "$default"
    logging_level = "INFO"
  }
}

#########################################
# Routes - citamedica (EventBridge for POST, PUT)
#########################################
resource "aws_apigatewayv2_route" "citamedica_post" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /citamedica"
  target    = "integrations/${aws_apigatewayv2_integration.eventbridge_integration.id}"
}

resource "aws_apigatewayv2_route" "citamedica_put" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /citamedica/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.eventbridge_integration.id}"
}

#########################################
# Routes - tutor
#########################################
resource "aws_apigatewayv2_route" "tutor_get_all" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /tutor"
  target    = "integrations/${aws_apigatewayv2_integration.tutor_integration_get_all.id}"
}

resource "aws_apigatewayv2_route" "tutor_get_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /tutor/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.tutor_integration.id}"
}

resource "aws_apigatewayv2_route" "tutor_post" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /tutor"
  target    = "integrations/${aws_apigatewayv2_integration.tutor_integration_get_all.id}"
}

resource "aws_apigatewayv2_route" "tutor_put_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /tutor/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.tutor_integration.id}"
}

resource "aws_apigatewayv2_route" "tutor_delete_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /tutor/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.tutor_integration.id}"
}

#########################################
# Routes - medico
#########################################

resource "aws_apigatewayv2_route" "producto_get_all" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /medico"
  target    = "integrations/${aws_apigatewayv2_integration.medico_integration_get_all.id}"
}

resource "aws_apigatewayv2_route" "producto_get_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /medico/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.medico_integration.id}"
}

resource "aws_apigatewayv2_route" "producto_post" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /medico"
  target    = "integrations/${aws_apigatewayv2_integration.medico_integration_get_all.id}"
}

resource "aws_apigatewayv2_route" "producto_put_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /medico/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.medico_integration.id}"
}

resource "aws_apigatewayv2_route" "producto_delete_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /medico/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.medico_integration.id}"
}

#########################################
# Routes - paciente
#########################################
resource "aws_apigatewayv2_route" "paciente_get_all" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /paciente"
  target    = "integrations/${aws_apigatewayv2_integration.paciente_integration_get_all.id}"
}

resource "aws_apigatewayv2_route" "paciente_get_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /paciente/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.paciente_integration.id}"
}

resource "aws_apigatewayv2_route" "paciente_post" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /paciente/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.paciente_integration.id}"
}

resource "aws_apigatewayv2_route" "paciente_put_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "PUT /paciente/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.paciente_integration.id}"
}

resource "aws_apigatewayv2_route" "paciente_delete_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /paciente/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.paciente_integration.id}"
}

#########################################
# Routes - citamedica
#########################################
resource "aws_apigatewayv2_route" "citamedica_get_all" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /citamedica"
  target    = "integrations/${aws_apigatewayv2_integration.citamedica_integration_get_all.id}"
}

resource "aws_apigatewayv2_route" "citamedica_get_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /citamedica/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.citamedica_integration.id}"
}

resource "aws_apigatewayv2_route" "citamedica_delete_proxy" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "DELETE /citamedica/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.citamedica_integration.id}"
}

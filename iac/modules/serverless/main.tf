data "archive_file" "archivo_crear_cita_lambda" {
  type        = "zip"
  source_dir  = "${path.root}/../serverless/tiendavirtual/packages/funciones/crear-cita/build"
  output_path = "${path.root}/data/crear_cita_lambda.zip"
}

resource "aws_lambda_function" "crear_cita" {
  function_name    = "crear-cita"
  handler          = "index.handler"
  runtime          = var.entorno_ejecucion
  role             = var.rol_lambda_arn
  filename         = data.archive_file.archivo_crear_cita_lambda.output_path
  source_code_hash = filebase64sha256(data.archive_file.archivo_crear_cita_lambda.output_path)
  timeout          = 60
  memory_size      = 512
  environment {
    variables = {
        URL_BASE_SERVICIO = var.url_base_servicio
    }
  }
}
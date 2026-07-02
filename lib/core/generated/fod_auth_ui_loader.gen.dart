// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _en = {
  "cancel": "cancel",
  "communicationProviderHelperText": "A verification code will be sent to the selected delivery method",
  "communicationProviderSelect": "select delivery method",
  "greetingTitle": "Hello!",
  "otpEnter": "Verify it's you",
  "otpInput": "Type it here to verify your identity",
  "otpSendBody": "We sent a code to",
  "pageHomeLoadFailed": "Failed to load home page",
  "passwordChangeFillFormText": "fill out the following form to change your password",
  "passwordConfirm": "confirm password",
  "passwordForgot": "forgot my password",
  "passwordNew": "new password",
  "passwordRuleLength": "6 characters",
  "passwordRuleNumber": "1 number",
  "passwordRuleSpecialChar": "1 special character",
  "passwordRuleUppercase": "1 uppercase letter",
  "search": "search",
  "send": "send",
  "signInSession": "Sign in",
  "signInText": "Sign in to your account",
  "welcomeTitle": "Welcome back!"
};
static const Map<String,dynamic> _es = {
  "cancel": "cancelar",
  "communicationCodeEnter": "Ingresa el código enviado al siguiente canal de comunicación:",
  "communicationProviderHelperText": "Se enviará un código de verificación al método de envío seleccionado",
  "communicationProviderSelect": "seleccionar método de envío",
  "communicationProviderVerification": "Verificación de {channel}",
  "customerServiceContact": "Comuníquese con el área de atención al cliente",
  "greetingTitle": "Hola!",
  "otpEnter": "Verifica que eres tú",
  "otpInput": "Escríbelo aquí para verificar tu identidad",
  "otpSendBody": "Mandamos un código a",
  "pageHomeLoadFailed": "Error al cargar la pantalla de inicio",
  "passwordChangeFillFormText": "llena el siguiente formulario para cambiar tu contraseña",
  "passwordConfirm": "confirmar contraseña",
  "passwordForgot": "olvidé mi contraseña",
  "passwordNew": "nueva contraseña",
  "passwordRuleLength": "6 caracteres",
  "passwordRuleNumber": "1 número",
  "passwordRuleSpecialChar": "1 carácter especial",
  "passwordRuleUppercase": "1 mayúscula",
  "passwordSecurityUpdate": "por motivos de seguridad es necesario que actualices tu contraseña.",
  "passwordUpdate": "actualizar contraseña",
  "passwordUse": "Usar contraseña",
  "permanently": "permanentemente",
  "returnToLogin": "volver a iniciar sesión",
  "search": "buscar",
  "send": "enviar",
  "signInSession": "Iniciar sesión",
  "signInText": "Inicia sesión en tu cuenta",
  "temporaly": "temporalmente",
  "tryAgainIn": "Vuelva a intentarlo en",
  "userLockMessage": "Estimado(@) cliente, su cuenta ha sido bloqueada {time} debido a intentos de inicios de sesión no válidos",
  "userTemporalLockWarningMessage": "Si intenta iniciar sesión con credenciales incorrectas una vez más, su cuenta se bloqueará permanentemente",
  "welcomeTitle": "Bienvenido de vuelta!"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": _en, "es": _es};
}

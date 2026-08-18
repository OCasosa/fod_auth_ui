// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class FodAuthUiLoader extends AssetLoader {
  const FodAuthUiLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> _en = {
    "activate": "activate",
    "biometricAuthActivate": "Activate biometric authentication",
    "biometricDeregisterMessage":
        "When doing so you will have to enter your password for authentication operations",
    "biometricDeregisterTitle":
        "Do you want to disable biometric authentication?",
    "biometricWarningText":
        "If you have activated biometric authentication on your device and granted access to another person, they will be able to enter the application",
    "cancel": "cancel",
    "communicationCodeEnter":
        "Enter the code sent to the following communication channel:",
    "communicationProviderHelperText":
        "A verification code will be sent to the selected delivery method",
    "communicationProviderSelect": "select delivery method",
    "communicationProviderVerification": "{channel} verification",
    "confirm": "confirm",
    "customerServiceContact": "Contact customer service",
    "email": "Email",
    "greetingTitle": "Hello!",
    "loading": "loading",
    "loginRecent": "last login",
    "logoutConfirmQuestion": "Do you want to log out?",
    "next": "next",
    "note": "Note",
    "otpEnter": "Verify it's you",
    "otpInput": "Type it here to verify your identity",
    "otpSendBody": "We sent a code to",
    "pageHomeLoadFailed": "Failed to load home page",
    "passwordChangeFillFormText":
        "fill out the following form to change your password",
    "passwordConfirm": "confirm password",
    "passwordCurrent": "current password",
    "passwordEnter": "Enter your password",
    "passwordForgot": "forgot my password",
    "passwordNew": "new password",
    "passwordRuleLength": "6 characters",
    "passwordRuleNumber": "1 number",
    "passwordRuleSpecialChar": "1 special character",
    "passwordRuleUppercase": "1 uppercase letter",
    "passwordSecurityUpdate":
        "For security reasons it is necessary that you update your password.",
    "passwordUpdate": "update password",
    "passwordUse": "Use password",
    "permanently": "permanently",
    "returnToLogin": "log back in",
    "search": "search",
    "send": "send",
    "sessionLogout": "log out",
    "signInSession": "Sign in",
    "signInText": "Sign in to your account",
    "temporaly": "temporarily",
    "tryAgainIn": "Please try again in",
    "userLockMessage":
        "Dear customer, your account has been locked {time} due to invalid login attempts",
    "userTemporalLockWarningMessage":
        "If you try to log in with incorrect credentials once again, your account will be permanently locked",
    "warning": "Warning",
    "welcomeTitle": "Welcome back!"
  };
  static const Map<String, dynamic> _es = {
    "activate": "activar",
    "biometricAuthActivate": "Activar autenticación biométrica",
    "biometricDeregisterMessage":
        "Al hacerlo tendrás que ingresar tu contraseña para operaciones de autenticación",
    "biometricDeregisterTitle":
        "¿Deseas deshabilitar la autenticación biométrica?",
    "biometricWarningText":
        "Si activaste la autenticación biométrica en tu dispositivo y otorgaste acceso a otra persona, esta podrá ingresar a la aplicación",
    "cancel": "cancelar",
    "communicationCodeEnter":
        "Ingresa el código enviado al siguiente canal de comunicación:",
    "communicationProviderHelperText":
        "Se enviará un código de verificación al método de envío seleccionado",
    "communicationProviderSelect": "seleccionar método de envío",
    "communicationProviderVerification": "Verificación de {channel}",
    "confirm": "confirmar",
    "customerServiceContact": "Comuníquese con el área de atención al cliente",
    "email": "Correo",
    "greetingTitle": "Hola!",
    "loading": "cargando",
    "loginRecent": "último inicio de sesión",
    "logoutConfirmQuestion": "¿Deseas cerrar sesión?",
    "next": "siguiente",
    "note": "Nota",
    "otpEnter": "Verifica que eres tú",
    "otpInput": "Escríbelo aquí para verificar tu identidad",
    "otpSendBody": "Mandamos un código a",
    "pageHomeLoadFailed": "Error al cargar la pantalla de inicio",
    "passwordChangeFillFormText":
        "llena el siguiente formulario para cambiar tu contraseña",
    "passwordConfirm": "confirmar contraseña",
    "passwordCurrent": "contraseña actual",
    "passwordEnter": "Ingresa tu contraseña",
    "passwordForgot": "olvidé mi contraseña",
    "passwordNew": "nueva contraseña",
    "passwordRuleLength": "6 caracteres",
    "passwordRuleNumber": "1 número",
    "passwordRuleSpecialChar": "1 carácter especial",
    "passwordRuleUppercase": "1 mayúscula",
    "passwordSecurityUpdate":
        "por motivos de seguridad es necesario que actualices tu contraseña.",
    "passwordUpdate": "actualizar contraseña",
    "passwordUse": "Usar contraseña",
    "permanently": "permanentemente",
    "returnToLogin": "volver a iniciar sesión",
    "search": "buscar",
    "send": "enviar",
    "sessionLogout": "cerrar sesión",
    "signInSession": "Iniciar sesión",
    "signInText": "Inicia sesión en tu cuenta",
    "temporaly": "temporalmente",
    "tryAgainIn": "Vuelva a intentarlo en",
    "userLockMessage":
        "Estimado(@) cliente, su cuenta ha sido bloqueada {time} debido a intentos de inicios de sesión no válidos",
    "userTemporalLockWarningMessage":
        "Si intenta iniciar sesión con credenciales incorrectas una vez más, su cuenta se bloqueará permanentemente",
    "warning": "Advertencia",
    "welcomeTitle": "Bienvenido de vuelta!"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": _en,
    "es": _es
  };
}

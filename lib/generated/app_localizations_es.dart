// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Portalixmx';

  @override
  String get visitorLogin => 'Acceso de Visitante';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get forgetPassword => 'Olvidaste tu contraseña?';

  @override
  String welcomeMessage(Object name) {
    return 'Bienvenido $name!';
  }

  @override
  String get visitors => 'Visitantes';

  @override
  String get fullName => 'Nombre Completo';

  @override
  String get emailAddress => 'Dirección de Correo';

  @override
  String get identificationTypeAndNumber => 'Tipo y Número de Identificación';

  @override
  String get vehicleInformation => 'Información del Vehículo';

  @override
  String get licensePlate => 'Placa';

  @override
  String get vehicleModel => 'Modelo del Vehículo';

  @override
  String get vehicleColor => 'Color del Vehículo';

  @override
  String get purposeOfVisit => 'Propósito de la Visita';

  @override
  String get next => 'Siguiente';

  @override
  String get createProfile => 'Crear Perfil';

  @override
  String get qrCode => 'Código QR';

  @override
  String get access => 'Acceso';

  @override
  String get profile => 'Perfil';

  @override
  String get date => 'Fecha';

  @override
  String get time => 'Hora';

  @override
  String get contact => 'Contacto';

  @override
  String get name => 'Nombre';

  @override
  String get shareKey => 'Compartir Clave';

  @override
  String get viewProfile => 'Ver Perfil';

  @override
  String get emergencyCalls => 'Llamadas de Emergencia';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get update => 'Actualizar';

  @override
  String get emergency => 'Emergencia';

  @override
  String get phone => 'Teléfono';

  @override
  String get profileInfoUpdated => 'Perfil actualizado';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String updateYour(Object userInfo) {
    return 'Actualiza tu $userInfo';
  }

  @override
  String get emergencyCommunication => 'Comunicación de Emergencia';

  @override
  String get show => 'Mostrar';

  @override
  String get hide => 'Ocultar';

  @override
  String get invalidCredentialsMessage =>
      'Credenciales de inicio de sesión de visitante no válidas';
}

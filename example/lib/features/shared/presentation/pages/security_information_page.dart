part of "../libraries/security_information_library.dart";

/// Page to display the security guideliness and information
@RoutePage()
class SecurityInformationPage extends StatelessWidget {
  /// Page to display the security guideliness and information
  const SecurityInformationPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CleanAppBar(
          title: Text(
            "securityInformation".tr().toCapitalized(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          // TODO: Translate all the texts
          padding: AppSeparators.kPagePadding,
          children: const [
            Text(
              "Al momento de contratar los productos de Cuenta Persona Física, se aceptan los siguientes riesgos y responsabilidades a los que se encuentra expuesto en las operaciones que realice a través de dichos productos, mismos que se determinará a continuación, así como los conceptos y montos de las comisiones que se le serán cobrados.",
            ),
            SizedBox(height: 20),
            Text(
              "Riesgos de Sistemas:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Mientras el cliente realiza operaciones a través de los productos de Fintech On Demand, éste será responsable de los riesgos de pérdidas financieras provocados por:",
            ),
            Text(
              "a. Accesos no autorizados, que pueden dar lugar a pérdidas directas debido al uso y manipulación de información confidencial del cliente.",
            ),
            Text(
              "b. Por la pérdida del dispositivo que pudiera dar acceso a personas no autorizadas al uso de la aplicación esta misma.",
            ),
            Text(
              "c. Por fallas en el sistema al momento de realizar la operación.",
            ),
            Text("d. Por mala conexión a Internet o fallas eléctricas."),
            Text("e. Por ciberataques en la red."),
            SizedBox(height: 20),
            Text(
              "Riesgos Operativos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("a. El uso indebido de la plataforma."),
            Text(
              "b. Que el cliente haga caso omiso de las normas aplicables que se describen en la guía del usuario de la plataforma.",
            ),
            Text("c. Realizar transferencias a un número de cuenta erróneo."),
            Text("d. Hacer transacciones a nombre de terceros."),
            Text(
              "e. Proporcionar sus claves confidenciales para el uso de la plataforma de Fintech On Demand.",
            ),
            SizedBox(height: 20),
            Text(
              "Riesgos de acceso a la información",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "a. Terceros autorizados/no autorizados tengan acceso a la plataforma del cliente desde su  computadora, y realice transacciones.",
            ),
            Text(
              "b. Terceros puedan acceder a la información del cliente desde la plataforma, incluidas direcciones electrónicas, datos personales y comunicaciones electrónicas, y datos de acceso.",
            ),
            Text(
              "Se entenderá que el cliente acepta correr con dichos riesgos desde el momento en el que realice sus operaciones a través de la plataforma de Fintech On Demand.",
            ),
            SizedBox(height: 20),
            Text(
              "Responsabilidad del cliente para minimizar los riesgos:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "a. Tener hábitos de seguridad como elegir una contraseña segura o el uso del lector de huella digital.",
            ),
            Text(
              "b. No compartir con terceros el nombre de usuario ni la contraseña.",
            ),
            Text(
              "c. Utilizar contraseñas diferentes a otras aplicaciones que utiliza.",
            ),
            Text("d. Cambiar la contraseña de manera constante."),
            Text(
              "e. Cuidar la integridad, confidencialidad, y disponibilidad de la información que acceda o maneje directamente, especialmente si dicha información es clasificada como sensible.",
            ),
            Text(
              "f. Utilizar de manera personal la información a la que tenga acceso, no podrá facilitarle más que a aquellos otros usuarios que necesiten conocerla para la misma finalidad y se abstendrá de usarla en beneficio propio o de terceros. ",
            ),
          ],
        ),
      );
}

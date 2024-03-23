class Usuario {
  // Constructor de la clase Usuario que toma propiedades obligatorias y opcionales.
  Usuario({
    required this.usuario,
    required this.email,
    required this.exito,
    required this.mensaje,
    required this.token,
    required this.tokenAcceso,
    required this.restablecer,
    this.id,
  });  // Asignación de valores predeterminados utilizando el operador ??.

  // Propiedades de la clase Usuario.
  String usuario;         // Nombre de usuario.
  String email;           // Correo electrónico.
  bool exito;             // Estado de éxito de la operación.
  String mensaje;         // Mensaje relacionado con la operación.
  String token;           // Token de autenticación.
  String tokenAcceso;     // Token de acceso.
  bool restablecer;       // Indicador de restablecimiento.
  String? id;             // Identificador del usuario (opcional).

  // Método copy() que crea una copia inmutable del objeto Usuario.
  Usuario copy() => Usuario(
        usuario: usuario,
        email: email,
        exito: exito,
        mensaje: mensaje,
        token: token,
        tokenAcceso: tokenAcceso,
        restablecer: restablecer,
      );
}

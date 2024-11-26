import 'package:common_microfrontend/common_microfrontend.dart';

class TranslationAuth extends TranslationObject {
  @override
  List<Map<String, dynamic>> get jsonData => [
        portugueseBusinessJsonData,
        englishBusinessJsonData,
        spanishBusinessJsonData
      ];

  Map<String, dynamic> portugueseBusinessJsonData = {
    "language": "pt",
    "business": "general",
    "package": "authentication",
    "translate": {
      //General
      "email": "E-mail",
      "phoneNumber": "Celular",
      "password": "Senha",
      "confirmPassword": "Confirme a senha",
      "enviar": "Enviar",
      "login": "Entrar",
      "returnToLoginPage": "Retornar para a página de login",
      "close": "Fechar",

      //AuthError
      "authErrorUnknownTitle": "Oops, aconteceu um erro!",
      "authErrorUnknownMessage":
          "Tente novamente em alguns instantes, caso o erro persista entre em contato com o suporte.",
      "authErrorInvalidEmailTitle": "Email inválido!",
      "authErrorInvalidEmailMessage":
          "Por favor, verifique se o email foi digitado corretamente.",
      "authErrorEmptyDatalTitle": "Dados em branco!",
      "authErrorEmptyDataMessage":
          "Por favor, verifique o email e a senha, preencha adequadamente e tente novamente.",
      "authErrorInvalidCredentialsTitle": "Credenciais inválidas!",
      "authErrorInvalidCredentialsMessage":
          "Por favor, verifique o número do telefone e a senha, preencha adequadamente e tente novamente.",
      "authErrorEmptyNameTitle": "Nome em Branco!",
      "authErrorEmptyNameMessage": "Preencha o campo nome.",
      "authErrorEmptyPhoneNumberTitle": "Telefone em Branco!",
      "authErrorEmptyPhoneNumberMessage": "Preencha o campo telefone.",
      "authErrorEmptyEmailTitle": "Email em Branco!",
      "authErrorEmptyEmailMessage": "Preencha o campo Email.",
      "authErrorEmptyPasswordTitle": "Senha em Branco!",
      "authErrorEmptyPasswordMessage": "Preencha o campo senha.",
      "authErrorEmptyClassTitle": "Turma em Branco!",
      "authErrorEmptyClassMessage": "Preencha o campo turma.",
      "authErrorPhoneNumberAlreadyInUseTitle":
          "Número de Telefone já Cadastrado",
      "authErrorPhoneNumberAlreadyInUseMessage":
          "Este número de telefone já está associado a uma conta. Por favor, tente fazer login ou utilize um número diferente.",
      "authErrorEmailAlreadyInUseTitle": "Email já cadastrado!",
      "authErrorEmailAlreadyInUseMessage":
          "Este email já está associado a uma conta. Por favor, tente fazer login ou utilize um email diferente.",
      "authErrorInvalidClassTitle": "Turma inválida!",
      "authErrorInvalidClassMessage":
          "Por favor, verifique a turma e tente novamente.",
      "authErrorEmptyCPFTitle": "CPF em Branco!",
      "authErrorEmptyCPFMessage": "Preencha o campo CPF.",
      "authErrorCpfAlreadyInUseFTitle": "CPF já cadastrado!",
      "authErrorCpfAlreadyInUseMessage":
          "Este CPF já está associado a uma conta. Por favor, tente fazer login ou utilize um CPF diferente.",
      "authErrorUserAlreadyExistsTitle": "Usuário já cadastrado!",
      "authErrorUserAlreadyExistsMessage":
          "Este usuário já está cadastrado. Por favor, tente fazer login ou utilize um usuário diferente.",
      "authErrorOnSaveAvatarTitle": "Erro ao salvar avatar!",
      "authErrorOnSaveAvatarMessage":
          "Houve um erro ao salvar o avatar, por favor, tente novamente.",
      "authSuccessRegisterTitle": "Cadastro realizado com sucesso!",
      "authSuccessRegisterMessage":
          "Seu cadastro foi realizado com sucesso, você será redirecionado em instantes!",

      //AuthSuccess
      "authSuccessUnknownTitle": "Sucesso!",
      "authSuccessUnknownMessage": "Operação realizada com sucesso!",
      "authSuccessRecoveryEmailSentTitle": "Email enviado com sucesso!",
      "authSuccessRecoveryEmailSentMessage":
          "As instruções para recuperação da sua senha foram enviadas para o seu email.",

      //Login
      "loginWelcome": "Seja Bem-vindo!",
      "loginWelcomeSubtitle": "Realize o login para sua conta.",
      "loginForgotPassword": "Esqueceu a senha?",
      "loginDontHaveAccount": "Não tem uma conta?",
      "loginSignup": "Cadastre-se!",
      "loginSignin": "Entrar",
      "loginSearchCountry": "Pesquise pelo nome ou DDI do país",

      //RecoverPassword
      "recoverPasswordTitle": "Recuperar Senha",
      "recoverPasswordSubtitle":
          "Insira seu email para receber o link de recuperação",

      //SendValidationSmsForm
      "sendValidationSmsFormTitle": "Valide seu número de telefone",
      "sendValidationSmsFormSubtitle":
          "Informe o seu número e enviaremos uma SMS com o código para validação",

      //sendValidationSmsError
      "sendValidationSmsEmptyPhoneNumberTitle": "Telefone vazio!",
      "sendValidationSmsEmptyPhoneNumberMessage":
          "O telefone e o DDI não podem estar vazios!",
      "sendValidationSmsSendErrorTitle": "Erro ao enviar o código",
      "sendValidationSmsSendErrorMessage":
          "Houve um erro ao enviar o código para o número informado, verifique o número e tente novamente.",
      "sendValidationSmsUserAlreadyRegisterTitle": "Telefone já cadastrado",
      "sendValidationSmsUserAlreadyRegisterMessage":
          "Este telefone já está associado a uma conta.",

      //PhoneValidationPage
      "phoneValidationPageTitle": "Valide seu número",
      "phoneValidationPageSubtitle":
          "Confirme o código enviado para o número {0} para continuar o cadastro.",
      "phoneValidationPageResendCodeExplanation": "Não recebeu o código?",
      "phoneValidationPageResendCode": "Reenviar código",
      "phoneValidationPageResendCodeTimer":
          "{0} segundos para reenviar o código",
      "phoneValidationPageChangeNumber": "Alterar número",
      //PhoneValidationError
      "phoneValidationUnknownTitle": "Oops, aconteceu um erro!",
      "phoneValidationUnknownMessage":
          "Tente novamente em alguns instantes, caso o erro persista entre em contato com o suporte.",
      "phoneValidationInvalidCodeTitle": "Código inválido!",
      "phoneValidationInvalidCodeMessage":
          "O código inserido está incorreto. Por favor, verifique e insira o código correto.",

      //Register
      "register": "Cadastrar",
      "registerTitle": "Realize seu  cadastro",
      "registerName": "Nome",
      "registerSurname": "Sobrenome",
      "registerEmail": "Email",
      "registerCpf": "CPF",
      "registerClassCode": "Código da turma",
      "registerPasswordNotMatch": "As senhas não conferem",
      "registerConfirmPassword": "Confirme a senha",
      "registerAlertDialogTitle": "O que deseja fazer?",
      "registerAlertDialogMessage":
          "Selecione uma opção para atualizar sua foto de perfil.",
      "registerTakePhoto": "Tirar foto",
      "registerChooseFromGallery": "Galeria",
      "permissionDenied": "Permissão negada",
      "givePermission": "Permitir",
      "permissionDeniedCameraMessage":
          "Para continuar, é necessário permitir o acesso à câmera nas configurações do aplicativo.",
      "permissionDeniedGalleryMessage":
          "Para continuar, é necessário permitir o acesso à galeria nas configurações do aplicativo.",
    }
  };
  Map<String, dynamic> englishBusinessJsonData = {
    "language": "en",
    "business": "general",
    "package": "authentication",
    "translate": {
      //General
      "email": "E-mail",
      "phoneNumber": "Phone Number",
      "password": "Password",
      "confirmPassword": "Confirm Password",
      "enviar": "Send",
      "login": "Login",
      "returnToLoginPage": "Return to login page",

      //AuthError
      "authErrorUnknownTitle": "Unknown error!",
      "authErrorUnknownMessage":
          "Please try again shortly. If the problem continues, contact support.",
      "authErrorInvalidEmailTitle": "Invalid email!",
      "authErrorInvalidEmailMessage":
          "Please check if the email was entered correctly",
      "authErrorEmptyDatalTitle": "Empty data!",
      "authErrorEmptyDataMessage":
          "Please check the email and password, fill in properly and try again.",
      "authErrorInvalidCredentialsTitle": "Invalid credentials!",
      "authErrorInvalidCredentialsMessage":
          "Please check the phone number and password, fill in properly and try again.",
      "authErrorEmptyNameTitle": "Empty name!",
      "authErrorEmptyNameMessage": "Fill in the name field.",
      "authErrorEmptyPhoneNumberTitle": "Empty phone!",
      "authErrorEmptyPhoneNumberMessage": "Fill in the phone field.",
      "authErrorEmptyEmailTitle": "Empty email!",
      "authErrorEmptyEmailMessage": "Fill in the Email field.",
      "authErrorEmptyPasswordTitle": "Empty password!",
      "authErrorEmptyPasswordMessage": "Fill in the password field.",
      "authErrorEmptyClassTitle": "Empty class!",
      "authErrorEmptyClassMessage": "Fill in the class field.",
      "authErrorPhoneNumberAlreadyInUseTitle":
          "Phone number already registered",
      "authErrorPhoneNumberAlreadyInUseMessage":
          "This phone number is already associated with an account. Please try to login or use a different number.",
      "authErrorEmailAlreadyInUseTitle": "Email already registered!",
      "authErrorEmailAlreadyInUseMessage":
          "This email is already associated with an account. Please try to login or use a different email.",
      "authErrorInvalidClassTitle": "Invalid class!",
      "authErrorInvalidClassMessage": "Please check the class and try again.",
      "authErrorEmptyCPFTitle": "Empty CPF!",
      "authErrorEmptyCPFMessage": "Fill in the CPF field.",
      "authErrorCpfAlreadyInUseFTitle": "CPF already registered!",
      "authErrorCpfAlreadyInUseMessage":
          "This CPF is already associated with an account. Please try to login or use a different CPF.",
      "authErrorUserAlreadyExistsTitle": "User already registered!",
      "authErrorUserAlreadyExistsMessage":
          "This user is already registered. Please try to login or use a different user.",
      "authErrorOnSaveAvatarTitle": "Error saving avatar!",
      "authErrorOnSaveAvatarMessage":
          "There was an error saving the avatar, please try again.",

      //AuthSuccess
      "authSuccessUnknownTitle": "Success!",
      "authSuccessUnknownMessage": "Operation performed successfully!",
      "authSuccessRecoveryEmailSentTitle": "Email sent successfully!",
      "authSuccessRecoveryEmailSentMessage":
          "The instructions for recovering your password have been sent to your email.",
      "authSuccessRegisterTitle": "Registration successful!",
      "authSuccessRegisterMessage":
          "Your registration was successful, you will be redirected shortly!",

      //Login
      "loginWelcome": "Welcome!",
      "loginWelcomeSubtitle": "Login to Your Account.",
      "loginForgotPassword": "Forgot password?",
      "loginDontHaveAccount": "Don't have an account?",
      "loginSignup": "Sign-up!",
      "loginSignin": "Sign-in",
      "loginSearchCountry": "Pesquise pelo nome ou DDI do país",

      //RecoverPassword
      "recoverPasswordTitle": "Recover Password",
      "recoverPasswordSubtitle":
          "Enter your email to receive the recovery link.",

      //SendValidationSmsForm
      "sendValidationSmsFormTitle": "Validate your phone number",
      "sendValidationSmsFormSubtitle":
          "Enter your number and we will send an SMS with the validation code",

      //sendValidationSmsError
      "sendValidationSmsEmptyPhoneNumberTitle": "Empty phone!",
      "sendValidationSmsEmptyPhoneNumberMessage":
          "The phone and Coutry Code cannot be empty!",
      "sendValidationSmsSendErrorTitle": "Error sending the code",
      "sendValidationSmsSendErrorMessage":
          "There was an error sending the code to the entered number, check the number and try again.",
      "sendValidationSmsUserAlreadyRegisterTitle": "Phone already registered",
      "sendValidationSmsUserAlreadyRegisterMessage":
          "This phone is already associated with an account.",

      //PhoneValidationPage
      "phoneValidationPageTitle": "Validate your number",
      "phoneValidationPageSubtitle":
          "Confirm the code sent to the number {0} to continue the registration.",
      "phoneValidationPageResendCodeExplanation": "Didn't receive the code?",
      "phoneValidationPageResendCode": "Resend code",
      "phoneValidationPageResendCodeTimer": "{0} seconds",
      "phoneValidationPageChangeNumber": "Change number",

      //PhoneValidationError
      "phoneValidationUnknownTitle": "Oops, an error occurred!",
      "phoneValidationUnknownMessage":
          "Please try again shortly. If the problem continues, contact support.",
      "phoneValidationInvalidCodeTitle": "Invalid code!",
      "phoneValidationInvalidCodeMessage":
          "The entered code is incorrect. Please check and enter the correct code.",

      //Register
      "register": "Register",
      "registerTitle": "Register your account",
      "registerName": "Name",
      "registerSurname": "Surname",
      "registerEmail": "Email",
      "registerCpf": "CPF",
      "registerClassCode": "Class code",
      "registerPasswordNotMatch": "Passwords do not match",
      "registerConfirmPassword": "Confirm Password",
      "registerAlertDialogTitle": "What do you want to do?",
      "registerAlertDialogMessage":
          "Select an option to update your profile picture.",
      "registerTakePhoto": "Take photo",
      "registerChooseFromGallery": "Gallery",
      "permissionDenied": "Permission denied",
      "givePermission": "Allow",
      "permissionDeniedCameraMessage":
          "To continue, it is necessary to allow access to the camera in the application settings.",
      "permissionDeniedGalleryMessage":
          "To continue, it is necessary to allow access to the gallery in the application settings.",
    }
  };

  Map<String, dynamic> spanishBusinessJsonData = {
    "language": "es",
    "business": "general",
    "package": "authentication",
    "translate": {
      //General
      "email": "Correo electrónico",
      "phoneNumber": "Phone Number",
      "password": "Contraseña",
      "confirmPassword": "Confirmar contraseña",
      "enviar": "Enviar",
      "login": "Iniciar sesión",
      "returnToLoginPage": "Volver a la página de inicio de sesión",

      //AuthError
      "authErrorUnknownTitle": "¡Error desconocido!",
      "authErrorUnknownMessage":
          "Inténtalo de nuevo en breve. Si el problema continúa, contacta con soporte",
      "authErrorInvalidEmailTitle": "¡Correo electrónico inválido!",
      "authErrorInvalidEmailMessage":
          "Por favor, compruebe si el correo electrónico se ha introducido correctamente.",
      "authErrorEmptyDatalTitle": "¡Datos en blanco!",
      "authErrorEmptyDataMessage":
          "Por favor, compruebe el correo electrónico y la contraseña, rellene adecuadamente e inténtelo de nuevo.",
      "authErrorInvalidCredentialsTitle": "¡Credenciales inválidas!",
      "authErrorInvalidCredentialsMessage":
          "Por favor, compruebe el número de teléfono y la contraseña, rellene adecuadamente e inténtelo de nuevo.",
      "authErrorEmptyNameTitle": "¡Nombre en blanco!",
      "authErrorEmptyNameMessage": "Rellene el campo nombre.",
      "authErrorEmptyPhoneNumberTitle": "¡Teléfono en blanco!",
      "authErrorEmptyPhoneNumberMessage": "Rellene el campo teléfono.",
      "authErrorEmptyEmailTitle": "¡Correo electrónico en blanco!",
      "authErrorEmptyEmailMessage": "Rellene el campo Email.",
      "authErrorEmptyPasswordTitle": "¡Contraseña en blanco!",
      "authErrorEmptyPasswordMessage": "Rellene el campo contraseña.",
      "authErrorEmptyClassTitle": "¡Clase en blanco!",
      "authErrorEmptyClassMessage": "Rellene el campo clase.",
      "authErrorPhoneNumberAlreadyInUseTitle":
          "Número de teléfono ya registrado",
      "authErrorPhoneNumberAlreadyInUseMessage":
          "Este número de teléfono ya está asociado a una cuenta. Por favor, intente iniciar sesión o utilice un número diferente.",
      "authErrorEmailAlreadyInUseTitle": "¡Correo electrónico ya registrado!",
      "authErrorEmailAlreadyInUseMessage":
          "Este correo electrónico ya está asociado a una cuenta. Por favor, intente iniciar sesión o utilice un correo electrónico diferente.",
      "authErrorInvalidClassTitle": "¡Clase inválida!",
      "authErrorInvalidClassMessage":
          "Por favor, compruebe la clase e inténtelo de nuevo.",
      "authErrorEmptyCPFTitle": "¡CPF en blanco!",
      "authErrorEmptyCPFMessage": "Rellene el campo CPF.",
      "authErrorCpfAlreadyInUseFTitle": "¡CPF ya registrado!",
      "authErrorCpfAlreadyInUseMessage":
          "Este CPF ya está asociado a una cuenta. Por favor, intente iniciar sesión o utilice un CPF diferente.",
      "authErrorUserAlreadyExistsTitle": "¡Usuario ya registrado!",
      "authErrorUserAlreadyExistsMessage":
          "Este usuario ya está registrado. Por favor, intente iniciar sesión o utilice un usuario diferente.",
      "authErrorOnSaveAvatarTitle": "¡Error al guardar el avatar!",
      "authErrorOnSaveAvatarMessage":
          "Hubo un error al guardar el avatar, por favor, inténtelo de nuevo.",

      //AuthSuccess
      "authSuccessUnknownTitle": "¡Éxito!",
      "authSuccessUnknownMessage": "¡Operación realizada con éxito!",
      "authSuccessRecoveryEmailSentTitle":
          "¡Correo electrónico enviado con éxito!",
      "authSuccessRecoveryEmailSentMessage":
          "Las instrucciones para recuperar su contraseña han sido enviadas a su correo electrónico.",
      "authSuccessRegisterTitle": "¡Registro exitoso!",
      "authSuccessRegisterMessage":
          "¡Su registro fue exitoso, será redirigido en breve!",

      //Login
      "loginWelcome": "¡Bienvenido!",
      "loginWelcomeSubtitle": "Inicie sesión en su cuenta.",
      "loginForgotPassword": "¿Olvidó la contraseña?",
      "loginDontHaveAccount": "¿No tienes una cuenta?",
      "loginSignup": "Regístrate!",
      "loginSignin": "Iniciar sesión",
      "loginSearchCountry": "Pesquise pelo nome ou DDI do país",

      //RecoverPassword
      "recoverPasswordTitle": "Recuperar contraseña",
      "recoverPasswordSubtitle":
          "Ingrese su correo electrónico para recibir el enlace de recuperación.",

      //SendValidationSmsForm
      "sendValidationSmsFormTitle": "Valide su número de teléfono",
      "sendValidationSmsFormSubtitle":
          "Ingrese su número y le enviaremos un SMS con el código de validación",

      //sendValidationSmsError
      "sendValidationSmsEmptyPhoneNumberTitle": "Teléfono vacío!",
      "sendValidationSmsEmptyPhoneNumberMessage":
          "¡El teléfono y el codigo de pais no pueden estar vacíos!",
      "sendValidationSmsSendErrorTitle": "Error al enviar el código",
      "sendValidationSmsSendErrorMessage":
          "Hubo un error al enviar el código al número introducido, compruebe el número e inténtelo de nuevo",
      "sendValidationSmsUserAlreadyRegisterTitle": "Teléfono ya registrado",
      "sendValidationSmsUserAlreadyRegisterMessage":
          "Este teléfono ya está asociado a una cuenta.",

      //PhoneValidationPage
      "phoneValidationPageTitle": "Valide su número",
      "phoneValidationPageSubtitle":
          "Confirme el código enviado al número {0} para continuar con el registro",
      "phoneValidationPageResendCodeExplanation": "¿No recibiste el código?",
      "phoneValidationPageResendCode": "Reenviar código",
      "phoneValidationPageResendCodeTimer": "{0} segundos",
      "phoneValidationPageChangeNumber": "Cambiar número",

      //PhoneValidationError
      "phoneValidationUnknownTitle": "¡Ups, ocurrió un error!",
      "phoneValidationUnknownMessage":
          "Inténtalo de nuevo en breve. Si el problema continúa, contacta con soporte.",
      "phoneValidationInvalidCodeTitle": "¡Código inválido!",
      "phoneValidationInvalidCodeMessage":
          "El código introducido es incorrecto. Por favor, compruebe e introduzca el código correcto.",

      //Register
      "register": "Registro",
      "registerTitle": "Registro",
      "registerName": "Nombre",
      "registerSurname": "Apellido",
      "registerEmail": "Correo electrónico",
      "registerCpf": "CPF",
      "registerClassCode": "Código de clase",
      "registerPasswordNotMatch": "Las contraseñas no coinciden",
      "registerConfirmPassword": "Confirmar contraseña",
      "registerAlertDialogTitle": "¿Qué deseas hacer?",
      "registerAlertDialogMessage":
          "Seleccione una opción para actualizar su foto de perfil.",
      "registerTakePhoto": "Tomar foto",
      "registerChooseFromGallery": "Galería",
      "givePermission": "Permitir",
      "permissionDenied": "Permiso denegado",
      "permissionDeniedCameraMessage":
          "Para continuar, es necesario permitir el acceso a la cámara en la configuración de la aplicación.",
    }
  };
}

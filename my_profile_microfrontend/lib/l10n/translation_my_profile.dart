import 'package:common_microfrontend/util/translation/domain/entity/translation_object.dart';

class TranslationMyProfile extends TranslationObject {
  @override
  List<Map<String, dynamic>> get jsonData => [
        portugueseGeneralData,
        englishGeneralData,
        spanishGeneralData,
        portugueseEducationData,
        englishEducationData,
        spanishEducationData
      ];

  Map<String, dynamic> portugueseGeneralData = {
    "language": "pt",
    "business": "general",
    "package": "my_profile",
    "translate": {
      // Tradução de erros
      "unknownErrorTitle": "Oops, aconteceu um erro!",
      "unknownErrorText":
          "Algo deu errado, por favor, tente novamente mais tarde.",
      "addFileErrorTitle": "Erro ao adicionar arquivo :(",
      "addFileErrorText":
          "Ocorreu um erro ao adicionar o seu arquivo, tente novamente!",
      "launchUrlErrorTitle": "Erro ao abrir o link",
      "launchUrlErrorText": "Não foi possível abrir o link, tente novamente!",
      "pickImagePermissionErrorTitle": "Erro ao escolher a imagem",
      "pickImageErrorText":
          "Oops! Você precisa permitir o acesso do aplicativo ao celular para escolher uma imagem, ok?",
      "cameraPermissionDeniedTitle": "Você precisa permitir o acesso à câmera",
      "cameraPermissionDeniedText":
          "Para tirar uma foto, você precisa permitir o acesso à câmera, ok?",

      // Tradução de elementos da tela
      "pageTitle": "Meu Perfil",
      "personalData": "Dados Pessoais",
      "accessData": "Dados de Acesso",
      "documents": "Documentos",
      "address": "Endereço",
      "whatToDo": "O que deseja fazer?",
      "pickAnOption": "Escolha uma opção",
      "takePicture": "Tirar foto",
      "pickFromGallery": "Escolher da galeria",
      "searchCountry": "Pesquise pelo nome ou DDI do país",
      "close": "Fechar",
      "givePermission": "Permitir Acesso",
      "successTitle": "Sucesso!",
      "updatedProfile": "O seu perfil foi atualizado com sucesso!",

      // Dados do formulário
      "nameInput": "Nome",
      "lastNameInput": "Sobrenome",
      "emailInput": "E-mail",
      "heightInput": "Altura (em m)",
      "weightInput": "Peso (em kg)",
      "healthCarePlanInput": "Plano de Saúde",
      "referenceHospitalInput": "Hospital de Referência",
      "phoneNumberInput": "Número de Telefone",
      "docNumberInput": "CPF",
      "rgInput": "RG",
      "nisInput": "NIS",
      "nifInput": "NIF",
      "birthCertificateInput": "Certidão de Nascimento",
      "birthdateInput": "Data de nascimento",
      "descriptionInput": "Apresentação",
      "newPasswordInput": "Nova Senha",
      "confirmPasswordInput": "Confirme a Senha",
      "streetTypeInput": "Tipo de Logradouro",
      "streetInput": "Logradouro",
      "numberInput": "Número",
      "complementInput": "Complemento",
      "districtInput": "Bairro",
      "postalCodeInput": "CEP",
      "cityInput": "Cidade",
      "stateInput": "Estado",
      "documentDescriptionInput": "Descrição",
      "documentObservationInput": "Observação",
      "chooseFile": "Escolher Arquivo",
      "fileModalTip": "Qual é o arquivo?",
      "submitButton": "Salvar",
      "confirmButton": "Confirmar",
      "cancelButton": "Cancelar",
      "submitButtonAction": "Salvando...",
      "addFile": "Adicionar Arquivo",
      "gender": "Gênero",
      "pickYourGender": "Selecione seu gênero",
      "maleGender": "Masculino",
      "femaleGender": "Feminino",
      "otherGender": "Outros",
      "dominantSide": "Lado Dominante",
      "rightSide": "Direito",
      "leftSide": "Esquerdo",
      "bothSides": "Ambidestro",
      "pickYourDominantSide": "Selecione seu lado dominante",

      // Validação
      'samePasswordValidation':
          'A senha de confirmação deve ser igual à nova senha',

      // Tips
      "changePasswordTip": "Se desejar trocar a senha, altere os dados abaixo:",
      "passwordSafetyTip":
          "Após a alteração de senha, será necessário fazer login novamente por segurança, ok?",
    }
  };

  Map<String, dynamic> englishGeneralData = {
    "language": "en",
    "business": "general",
    "package": "my_profile",
    "translate": {
      // Tradução de erros
      "unknownErrorTitle": "Oops, an error occurred!",
      "unknownErrorText": "Something went wrong, please try again later.",
      "addFileErrorTitle": "Error adding file :(",
      "addFileErrorText":
          "An error occurred while adding your file, try again!",
      "launchUrlErrorTitle": "Error opening the link",
      "launchUrlErrorText": "There was an error opening the link, try again!",
      "pickImagePermissionErrorTitle": "Error picking the image",
      "pickImageErrorText":
          "Oops! You need to allow the app to access the phone to pick an image, okay?",
      "cameraPermissionDeniedTitle": "You need to allow camera access",
      "cameraPermissionDeniedText":
          "To take a picture, you need to allow camera access, okay?",

      // Tradução de elementos da tela
      "pageTitle": "My Profile",
      "personalData": "Personal Data",
      "accessData": "Access Data",
      "documents": "Documents",
      "address": "Address",
      "whatToDo": "What do you want to do?",
      "pickAnOption": "Pick an option",
      "takePicture": "Take a picture",
      "pickFromGallery": "Pick from gallery",
      "searchCountry": "Search by the country's name or code",
      "close": "Close",
      "givePermission": "Allow Access",
      "successTitle": "Success!",
      "updatedProfile": "Your profile has been successfully updated!",

      // Dados do formulário
      "nameInput": "Name",
      "lastNameInput": "Last Name",
      "emailInput": "E-mail",
      "heightInput": "Height (in m)",
      "weightInput": "Weight (in kg)",
      "healthCarePlanInput": "Health Care Plan",
      "referenceHospitalInput": "Reference Hospital",
      "phoneNumberInput": "Phone Number",
      "docNumberInput": "Document Number",
      "rgInput": "RG",
      "nisInput": "NIS",
      "nifInput": "NIF",
      "birthCertificateInput": "Birth Certificate",
      "birthdateInput": "Birthdate",
      "descriptionInput": "Description",
      "newPasswordInput": "New Password",
      "confirmPasswordInput": "Confirm Password",
      "streetTypeInput": "Street Type",
      "streetInput": "Street",
      "numberInput": "Number",
      "complementInput": "Complement",
      "districtInput": "District",
      "postalCodeInput": "Postal Code",
      "cityInput": "City",
      "stateInput": "State",
      "documentDescriptionInput": "Description",
      "documentObservationInput": "Observation",
      "chooseFile": "Choose File",
      "fileModalTip": "What is the file?",
      "submitButton": "Submit",
      "confirmButton": "Confirm",
      "cancelButton": "Cancel",
      "submitButtonAction": "Submitting...",
      "addFile": "Add File",
      "gender": "Gender",
      "pickYourGender": "Select your gender",
      "maleGender": "Male",
      "femaleGender": "Female",
      "otherGender": "Other",
      "dominantSide": "Dominant Side",
      "rightSide": "Right",
      "leftSide": "Left",
      "bothSides": "Ambidextrous",
      "pickYourDominantSide": "Select your dominant side",

      // Validação
      'samePasswordValidation':
          'The confirmation password must be the same as the new password',

      // Tips
      "changePasswordTip":
          "If you want to change your password, change the following data:",
      "passwordSafetyTip":
          "After the password change, you will need to log in again for security, okay?"
    }
  };

  Map<String, dynamic> spanishGeneralData = {
    "language": "es",
    "business": "general",
    "package": "my_profile",
    "translate": {
      // Tradução de erros
      "unknownErrorTitle": "¡Ups, ocurrió un error!",
      "unknownErrorText":
          "Algo salió mal, por favor, inténtelo de nuevo más tarde.",
      "addFileErrorTitle": "Error al agregar archivo :(",
      "addFileErrorText":
          "Ocurrió un error al agregar su archivo, ¡inténtelo de nuevo!",
      "launchUrlErrorTitle": "Error al abrir el enlace",
      "launchUrlErrorText": "No se pudo abrir el enlace, ¡inténtelo de nuevo!",
      "pickImagePermissionErrorTitle": "Error al elegir la imagen",
      "pickImageErrorText":
          "¡Ups! Necesita permitir que la aplicación acceda al teléfono para elegir una imagen, ¿vale?",
      "cameraPermissionDeniedTitle": "Necesita permitir el acceso a la cámara",
      "cameraPermissionDeniedText":
          "Para tomar una foto, necesita permitir el acceso a la cámara, ¿vale?",

      // Tradução de elementos da tela
      "pageTitle": "Mi Perfil",
      "personalData": "Datos Personales",
      "accessData": "Datos de Acceso",
      "documents": "Documentos",
      "address": "Dirección",
      "whatToDo": "¿Qué deseas hacer?",
      "pickAnOption": "Elige una opción",
      "takePicture": "Tomar una foto",
      "pickFromGallery": "Elegir de la galería",
      "searchCountry": "Buscar por el nombre del país o código",
      "close": "Cerrar",
      "givePermission": "Permitir Acceso",
      "successTitle": "¡Éxito!",
      "updatedProfile": "¡Tu perfil ha sido actualizado con éxito!",

      // Dados do formulário
      "nameInput": "Nombre",
      "lastNameInput": "Apellido",
      "emailInput": "E-mail",
      "heightInput": "Altura (en m)",
      "weightInput": "Peso (en kg)",
      "healthCarePlanInput": "Plan de Salud",
      "referenceHospitalInput": "Hospital de Referencia",
      "phoneNumberInput": "Número de teléfono",
      "docNumberInput": "Número de documento",
      "rgInput": "RG",
      "nisInput": "NIS",
      "nifInput": "NIF",
      "birthCertificateInput": "Certificado de Nacimiento",
      "birthdateInput": "Fecha de nacimiento",
      "descriptionInput": "Descripción",
      "newPasswordInput": "Nueva Contraseña",
      "confirmPasswordInput": "Confirmar Contraseña",
      "streetTypeInput": "Tipo de Calle",
      "streetInput": "Calle",
      "numberInput": "Número",
      "complementInput": "Complemento",
      "districtInput": "Barrio",
      "postalCodeInput": "Código Postal",
      "cityInput": "Ciudad",
      "stateInput": "Estado",
      "documentDescriptionInput": "Descripción",
      "documentObservationInput": "Observación",
      "chooseFile": "Elegir Archivo",
      "fileModalTip": "¿Cuál es el archivo?",
      "submitButton": "Enviar",
      "confirmButton": "Confirmar",
      "cancelButton": "Cancelar",
      "submitButtonAction": "Enviando...",
      "addFile": "Agregar Archivo",
      "pickYourGender": "Elige tu género",
      "gender": "Género",
      "maleGender": "Masculino",
      "femaleGender": "Femenino",
      "otherGender": "Otros",
      "dominantSide": "Lado Dominante",
      "rightSide": "Derecho",
      "leftSide": "Izquierdo",
      "bothSides": "Ambidiestro",
      "pickYourDominantSide": "Selecciona tu lado dominante",

      // Validação
      'samePasswordValidation':
          'La contraseña de confirmación debe ser igual a la nueva contraseña',

      // Tips
      "changePasswordTip":
          "Si deseas cambiar tu contraseña, cambia los siguientes datos:",
      "passwordSafetyTip":
          "Después del cambio de contraseña, deberás iniciar sesión de nuevo por seguridad, ¿vale?"
    }
  };
}

Map<String, dynamic> portugueseEducationData = {
  "language": "pt",
  "business": "idioma",
  "package": "my_profile",
  "translate": {
    "pageTitle": "Editar Perfil",
  }
};

Map<String, dynamic> englishEducationData = {
  "language": "en",
  "business": "idioma",
  "package": "my_profile",
  "translate": {
    "pageTitle": "Edit Profile",
  }
};

Map<String, dynamic> spanishEducationData = {
  "language": "es",
  "business": "idioma",
  "package": "my_profile",
  "translate": {
    "pageTitle": "Editar Perfil",
  }
};

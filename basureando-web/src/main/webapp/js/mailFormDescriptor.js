/**
 * Excecuted when page is ready. It starts form definition and set validation
 * behavior when somebody tries to submit data
 */
$(document).ready(function () {
    var formDefinition = new FormDefiniton(init, defineValidationRules);

    formDefinition.init();
    formDefinition.defineValidationRules();

    $('#formulario').submit(function() {
        formDefinition.formValidator.behavior();
        return false;
    });

});


/**
 * Initialices validation components. Declare all form field objects defining its formats
 */
var init = function () {
    this.fields.nombre = new LiveValidation("sentFrom", { validMessage: "Correcto!", wait: 100 });
    this.fields.title = new LiveValidation("title", { validMessage: "Este si es válido", wait: 100 });

    this.formValidator = new FormValidator(document.forms.namedItem('formulario'));

    this.formValidator.addFormValidationBehavior(function() {
        alert('Correo enviado!');
    });
}


/**
 *
 */
var defineValidationRules = function() {

    this.fields.nombre.add(
        Validate.Presence,
        {
            failureMessage: 'Requerido'
        }
    );

    this.fields.nombre.add(
        Validate.Email,
        {
            failureMessage: 'Dirección inválida'
        }
    );

    this.fields.title.add(
        Validate.Length,
        {
            minimum: 5,
            maximum: 50,
            failureMessage: 'Longitud inválida'
        }
    );
}
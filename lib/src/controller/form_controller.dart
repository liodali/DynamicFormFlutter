import '../form/login_form.dart';
import '../form/payment_form.dart';
import '../simple_dynamic_form.dart';

abstract class BaseFormController {
  bool validate();

  void clearValues();
}

abstract class BaseSimpleFormController extends BaseFormController {
  List<String> getAllValues();

  void addErrorToField(String id, String error);

  Map<String, String> getAllValuesByIds();

  String getValueById(String id);

  void setFieldValueById(String id, String value);

  void clearValueById(String id);
}

class FormController extends BaseSimpleFormController {
  late SimpleDynamicFormState _formState;

  void init(SimpleDynamicFormState state) {
    this._formState = state;
  }

  @override
  bool validate() {
    _formState.clearErrors();
    return _formState.validate();
  }

  @override
  List<String> getAllValues() => _formState.recuperateAllValues();

  @override
  String getValueById(String id) => _formState.singleValueById(id);

  @override
  void clearValues() => _formState.clearValues();

  @override
  Map<String, String> getAllValuesByIds() => _formState.recuperateByIds();

  @override
  void clearValueById(String id) => _formState.clearValueById(id);

  @override
  void addErrorToField(String id, String error) => _formState.errorFieldById(id, error);

  @override
  void setFieldValueById(String id, String value) => _formState.setValueById(id,value);
}

/// LoginFormController : controller of login form
/// use it to get email/username value or password value
/// show error in email/password without validator
/// use case use can show error in username/password if auth failed
/// clear all values
class LoginFormController extends BaseFormController {
  late LoginFormState _formState;

  void init(LoginFormState state) {
    this._formState = state;
  }

  /// get current email/username value
  String get email => _formState.controller.getValueById("email");

  /// get current password value
  String get password => _formState.controller.getValueById("password");

  /// show error in email/username without validator
  void addEmailError(String error) {
    _formState.controller.addErrorToField("email", error);
  }

  /// show error in password without validator
  void addPasswordError(String error) {
    _formState.controller.addErrorToField("password", error);
  }

  /// clear value in textFields
  @override
  void clearValues() {
    _formState.controller.clearValues();
  }

  /// form validation
  @override
  bool validate() {
    return _formState.controller.validate();
  }
}

class PaymentController extends BaseFormController {
  late PaymentFormState _state;

  void init(PaymentFormState state) {
    this._state = state;
  }

  /// get current cardNumber value
  String get cardNumber => _state.controller.getValueById(PaymentFormState.idCardNumber);

  /// get current cvv value
  String get cvv => _state.controller.getValueById(PaymentFormState.idCVV);

  /// get current date expiration value
  String get dateExpiration => _state.controller.getValueById(PaymentFormState.idDateExpiration);

  /// show error in cardNumber without validator
  void addCardNumberError(String error) {
    _state.controller.addErrorToField(PaymentFormState.idCardNumber, error);
  }

  /// show error in cvv without validator
  void addCVVError(String error) {
    _state.controller.addErrorToField(PaymentFormState.idCVV, error);
  }

  /// show error in date expiration without validator
  void addDateExpirationError(String error) {
    _state.controller.addErrorToField(PaymentFormState.idDateExpiration, error);
  }

  @override
  void clearValues() {
    this._state.controller.clearValues();
  }

  @override
  bool validate() {
    return this._state.controller.validate();
  }
}

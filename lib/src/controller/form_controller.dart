import '../form/login_form.dart';
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

  void clearValueById(String id);
}

class FormController extends BaseSimpleFormController {
  SimpleDynamicFormState _formState;

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
  void addErrorToField(String id, String error) =>
      _formState.errorFieldById(id, error);
}
/// LoginFormController : controller of login form
/// use it to get email/username value or password value
/// show error in email/password without validator
/// use case use can show error in username/password if auth failed
/// clear all values
class LoginFormController extends BaseFormController {
  LoginFormState _formState;

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

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

class LoginFormController extends BaseFormController {
  LoginFormState _formState;

  void init(LoginFormState state) {
    this._formState = state;
  }

  String get email => _formState.controller.getValueById("email");

  String get password => _formState.controller.getValueById("password");

  void addEmailError(String error) {
    _formState.controller.addErrorToField("email", error);
  }

  void addPasswordError(String error) {
    _formState.controller.addErrorToField("password", error);
  }

  @override
  void clearValues() {
    _formState.controller.clearValues();
  }

  @override
  bool validate() {
    return _formState.controller.validate();
  }
}

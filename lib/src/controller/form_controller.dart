import '../simple_dynamic_form.dart';

abstract class BaseFormController {
  bool validate();

  void addErrorToField(String id, String error);

  void clearValues();

  void clearValueById(String id);
}

abstract class BaseSimpleFormController extends BaseFormController {
  List<String> getAllValues();

  Map<String, String> getAllValuesByIds();

  String getValueById(String id);
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

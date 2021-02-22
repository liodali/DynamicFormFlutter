import '../simple_dynamic_form.dart';

abstract class BaseFormController {
  bool validate();

  List<String> getAllValues();

  String getValueById(String id);

  void clearValues();
}


class FormController extends BaseFormController {
  SimpleDynamicFormState _formState;

  void init(SimpleDynamicFormState state) {
    this._formState = state;
  }

  @override
  bool validate() {
    return _formState.validate();
  }

  @override
  List<String> getAllValues() {
    return _formState.recuperateAllValues();
  }

  @override
  String getValueById(String id) {
    return _formState.singleValueById(id);
  }

  @override
  void clearValues() {
    _formState.clearValues();
  }

}
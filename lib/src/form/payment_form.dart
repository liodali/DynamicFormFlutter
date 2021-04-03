import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dynamic_form.dart';
import '../elements/element.dart';
import '../elements/group_elements.dart';
import '../simple_dynamic_form.dart';
import '../utilities/constants.dart';
import '../widgets/decoration_element.dart';

/// [PaymentForm] : Widget Form that illustrate payment form
///
/// [decorationElement] :            decoration of all input field in form
///
/// [errorMessageDateExpiration] :   messages errors to show  when Date Expiration field not validate
///
/// [errorMessageCVV]            :   messages errors to show when cvv field is invalidate
///
/// [errorMessageCardNumber]     :   messages errors to show when credit card number is invalidate
///
/// [errorIsRequiredMessage]     :   messages errors to show when at least one field not filled
///
/// [labelCardNumber]            :   text label of credit card number field
///
/// [labelDateExpiration]        :   text label of date expiration field
///
/// [labelCVV]                   :   text label of cvv field
///
///[controller]                  :  Controls the form and validate it,setError to fields,clear values.
///
///[submitButton]                 :  (Widget) submit widget that you want integrated directly in form
class PaymentForm extends StatefulWidget {
  final DecorationElement? decorationElement;
  final String? labelCardNumber;
  final String? labelDateExpiration;
  final String? labelCVV;
  final String? errorMessageDateExpiration;
  final String? errorMessageCVV;
  final String? errorMessageCardNumber;
  final String? errorIsRequiredMessage;
  final PaymentController controller;
  final Widget? submitButton;

  PaymentForm({
    this.decorationElement,
    this.errorMessageDateExpiration,
    this.labelCardNumber,
    this.labelDateExpiration,
    this.labelCVV,
    this.errorMessageCVV,
    this.errorMessageCardNumber,
    this.errorIsRequiredMessage,
    required this.controller,
    this.submitButton,
    Key? key,
  }) : super(
          key: key,
        );

  static PaymentController? of(BuildContext context, {bool nullOk = false}) {
    final PaymentForm? result =
        context.findAncestorWidgetOfExactType<PaymentForm>();
    if (nullOk || result != null) return result!.controller;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
          'PaymentForm.of() called with a context that does not contain an PaymentForm.'),
      ErrorDescription(
          'No PaymentForm ancestor could be found starting from the context that was passed to PaymentForm.of().'),
      context.describeElement('The context used was')
    ]);
  }

  @override
  PaymentFormState createState() => PaymentFormState();
}

class PaymentFormState extends State<PaymentForm> {
  final dateFormatCompare = DateFormat("MM/yyyy");
  DateTime? startedDate;

  late DateTime endDate;

  late FormController controller = FormController();

  static const String idCardNumber = "id-card-number";
  static const String idCVV = "id-cvv";
  static const String idDateExpiration = "id-date-expiration";
  late RegExp reg;

  @override
  void initState() {
    super.initState();
    widget.controller.init(this);
    startedDate = DateTime.now().parseFormat(dateFormatCompare);
    endDate =
        DateTime.now().add(Duration(days: 3650)).parseFormat(dateFormatCompare);

    reg = RegExp("^((0[1-9])|(1[0-2]))(\/)(([0-9]){4})\$");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleDynamicForm(
          controller: controller,
          groupElements: [
            GroupElement(
              directionGroup: DirectionGroup.Vertical,
              margin: const EdgeInsets.only(top: 5.0, bottom: 3.0),
              textElements: [
                CardNumberElement(
                  id: idCardNumber,
                  label: widget.labelCardNumber,
                  decorationElement: widget.decorationElement,
                ),
              ],
            ),
            GroupElement(
              directionGroup: DirectionGroup.Horizontal,
              sizeElements: [0.5,0.5],
              textElements: [
                DateInputElement(
                  id: idDateExpiration,
                  decorationElement: widget.decorationElement,
                  isRequired: true,
                  minLength: 7,
                  requiredErrorMsg: widget.errorIsRequiredMessage,
                  label: widget.labelDateExpiration,
                  hint: "mm/yyyy",
                  dateFormat: dateFormatCompare,
                  initDate: startedDate,
                  validator: (v) {
                    try {
                      if (!reg.hasMatch(v!)) {
                        return widget.errorMessageDateExpiration;
                      }
                      var d = dateFormatCompare.parse(v);
                      if (d.isBefore(startedDate!) || d.isAfter(endDate)) {
                        return widget.errorMessageDateExpiration;
                      }
                    } catch (e) {
                      return widget.errorMessageDateExpiration;
                    }
                    return null;
                  },
                ),
                CVVElement(
                  id: idCVV,
                  decorationElement: widget.decorationElement,
                  label: widget.labelCVV,
                  hint: widget.labelCVV,
                  error: widget.errorIsRequiredMessage,
                  validator: (v) {
                    if (v.isEmpty) {
                      return widget.errorIsRequiredMessage;
                    }
                    if (v.length != 3) {
                      return widget.errorMessageCVV;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ],
        ),
        if (widget.submitButton != null) ...[
          widget.submitButton!,
        ]
      ],
    );
  }
}

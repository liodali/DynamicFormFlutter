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
/// [entryModeDateExpiration]    :  (DateExpirationEntryMode)   input type of card date expiration can be dropdown or input(textField)
///
/// [decorationElement]          :   decoration of all input field in form
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
  final int? maxYearDateExpiration;
  final DateExpirationEntryMode entryModeDateExpiration;
  final DecorationElement? decorationElement;
  final String labelCardNumber;
  final String? labelDateExpiration;
  final String labelCVV;
  final String errorMessageDateExpiration;
  final String? errorMessageCVV;
  final String? errorMessageCardNumber;
  final String errorIsRequiredMessage;
  final PaymentController controller;
  final Widget? submitButton;

  PaymentForm({
    required this.controller,
    this.entryModeDateExpiration = DateExpirationEntryMode.input,
    this.decorationElement,
    this.errorMessageDateExpiration = "this field is invalid",
    this.labelCardNumber = "XXXX XXXX XXXX XXXX",
    this.labelDateExpiration,
    this.labelCVV = "cvv",
    this.errorMessageCVV,
    this.errorMessageCardNumber,
    this.maxYearDateExpiration,
    this.errorIsRequiredMessage = "this field is required",
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
  void didUpdateWidget(covariant PaymentForm oldWidget) {
    widget.controller.init(this);
    super.didUpdateWidget(oldWidget);
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
              sizeElements: [0.7, 0.3],
              textElements: [
                CardExpirationDateInputElement(
                  id: idDateExpiration,
                  isRequired: true,
                  decorationElement: widget.decorationElement,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  maxYear: widget.maxYearDateExpiration,
                  entryMode: widget.entryModeDateExpiration,
                  label: widget.labelDateExpiration,
                  requiredErrorMsg: widget.errorIsRequiredMessage,
                  invalidErrorMsg: widget.errorMessageDateExpiration,
                ),
                CVVElement(
                  id: idCVV,
                  decorationElement: widget.decorationElement,
                  label: widget.labelCVV,
                  hint: widget.labelCVV,
                  error: widget.errorIsRequiredMessage,
                  padding: EdgeInsets.only(top: 5.0),
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

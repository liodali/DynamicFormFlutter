# dynamicform
![pub](https://img.shields.io/badge/pub-v0.10.1--nullsafety.0-orange) ![GitHub](https://img.shields.io/github/license/liodali/checkbox_grouped)


create your form with easier way

## Getting Started

 * Generate custom form
 * Form Controller to manage form
 * login Form
 * payment form
 * Pre-existing elements

## Installing

Add the following to your `pubspec.yaml` file:

    dependencies:
		dynamic_form: ^0.10.0-nullsafety.1




## Simple Usage
#### Creating a basic `SimpleDynamicForm`:

```dart
        SimpleDynamicForm(
                  controller: controller,
                  groupElements: [
                          GroupElement(
                                        directionGroup: DirectionGroup.Vertical,
                                        textElements: [
                                        TextElement(
                                          id:"name",
                                          label: "name",
                                        ),
                                        TextElement(
                                            id:"password",
                                             label: "password", 
                                             typeInput: TypeInput.Password,
                                        )
                                    ],
                                )
                              ],
                          );
```



####  `Properties in SimpleDynamicForm`

 | Properties                     | Description                                                    |
 | ------------------------------ | -------------------------------------------------------------- |
 | `groupElements`                | list of element to build your form                             |
 | `padding`                      |  The amount of space by which to inset the form                |
 | `controller`                   |  The FormController to get values and validate your form       |
 | `submitButton`                 |  (Widget) custom submit Widget that you want to add to the form |


### Declare FormController to get validation,list values of forms

```dart
 FormController controller = FormController();
```
> you can access to controller from your submit button
>
```dart
 FormController controller = SimpleDynamicForm.of(context);
```
### validate forms

```dart
controller.validate();
```

### show error to forms fields  after validation
* error will be cleared automatically when form validate
```dart
 controller.addErrorToField(String idField,String errorMessage);
```


### recuperate all values in form :
```dart
 controller.getAllValues();
```

> if you are used ids in element, you can recuperate values with

```dart
 controller.getByIds();
```

> you recuperate by id

```dart
 controller.getValueById(id);
```
### clear  all inputs in form :

```dart
 controller.clearValues();
```


### LoginForm
> pre-existing login form to make easy for you to build

## Simple Usage
#### Creating a basic `LoginForm` :


```dart
  
    LoginForm(
          controller:controller
          submitLogin:RaisedButton(
           onPressed: () {
                final email = controller.email;
                final password = controller.password;
                print("$email,$password");
              },
          child: Text("Log In"),
         ),
          onlyEmail: false,
          labelLogin: "Username",
          password: "Password",
          textButton: Text("Log IN"),
          paddingFields: const EdgeInsets.all(0),
          decorationEmailElement: decoration,
          decorationPasswordElement: decoration.copy(
            radius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
          ),
        )
```

### Declare LoginFormController to get validation,Email & Password values

```dart
LoginFormController controller = LoginFormController();
```
> you can access to controller from your submit button

```dart
 LoginFormController controller = LoginForm.of(context)
```
### recuperate email/Username,password
```dart
final email = controller.email;
final password = controller.password;
```

### show field error after validation (use case when auth failed)

```dart
 controller.addEmailError("invalid Email not found");
 controller.addPasswordError("invalid Email not found");
```


####  `Properties in LoginForm`

 | Properties                     | Description                                                    |
 | ------------------------------ | -------------------------------------------------------------- |
 | `controller`                   | LoginFormController to validate login form and get data                             |
 | `decorationEmailElement`       | input decoration of email field in form                             |
 | `decorationPasswordElement`    | input decoration of password field in form                             |
 | `directionGroup`               | Direction of form (Vertical/Horizontal)                        |
 | `paddingFields`                | padding between fields                                         |
 | `onlyEmail`                    | enable only email type fieldtext                               |
 | `login`                        | label  of username/email textField                             |
 | `password`                     | label of the passwordField                                     |
 | `passwordError`                | messages errors to show  when password field not validate      |
 | `usernameEmailError`           | messages errors to show when email/username not validate       |
 | `submitLogin`                  | (Widget) Button of submit form                |


### PaymentForm
> pre-existing payment form to make easy for you to build
## Simple Usage
#### Creating a basic `PaymentForm` :


```dart
    PaymentForm(
          controller:controller,
          decorationElement: OutlineDecorationElement(),
          errorMessageCVV: "cvv is invalid",
          errorMessageDateExpiration: "date expiration is invalid",
          errorIsRequiredMessage: "This field  is required",
          labelCVV: "cvv",
          labelDateExpiration: "date expiration",
          labelCardNumber: "card number",
          submitButton: ElevatedButton(
            onPressed: () {
              controller.validate();
            },
            child: Text("pay"),
          ),
        )
```
### Declare LoginFormController to get validation,Email & Password values

```dart
PaymentController controller = PaymentController();
```
> you can access to controller from your submit button

```dart
 PaymentController controller = PaymentForm.of(context);
```
### validation payment form 
```dart
bool isValid = controller.validate();
```

### recuperate cardNumber,cvv,dateExpiration
```dart
final cardNumber = controller.cardNumber;
final cvv = controller.cvv;
final dateExpiration = controller.dateExpiration;
```

### show field error after validation (use case when card check failed)
```dart
 controller.addCardNumberError(errorMessage);
 controller.addCVVError(errorMessage);
 controller.addDateExpirationError(errorMessage);
```

####  `Properties in PaymentForm`

 | Properties                     | Description                                                    |
 | ------------------------------ | -------------------------------------------------------------- |
 | `controller`                   | (PaymentController) controller to validate form,setError fields,clear values                           |
 | `decorationElement`            | decoration of all input field in form                             |
 | `buttonDecoration`             | decoration of button that contain radius,backgroundColor,width |
 | `errorMessageDateExpiration`   | messages errors to show  when Date Expiration field not validate      |
 | `errorMessageCVV`              | messages errors to show when cvv field is invalidate            |
 | `errorMessageCardNumber`       | messages errors to show when credit card number is invalidate   |
 | `errorIsRequiredMessage`       | messages errors to show when at least one field not filled      |
 | `labelCardNumber`              | text label of credit card number field                          |
 | `labelDateExpiration`          | text label of date expiration field                             |
 | `labelCVV`                     | text label of cvv field                                         |
 | `submitButton`                 | (widget) submit button widget                                         |



### How to skectch your form ?

> ` textElement is small element in dynamicForm `
> ` GroupElement is group of TextElement`

####  `GroupElement`
| Properties          | Description                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------------- |
| `directionGroup`    | Direction of form (Vertical/Horizontal)                                                      |
| `sizeElements`      | size of each textElement  of form When direction Horizontal,sum of values should be egal a 1 |
| `textElements`      | group of textElement.                                                                        |
| `padding`           | padding of groups.                                                                           |
| `decoration`        | decoration  of container groups.                                                             |
| `backgroundColor`   | color of the container groups.                                                               |


####  `textElement`
| Properties          | Description                                    |
| ------------------- | ---------------------------------------------- |
| `typeInput`         | Enumerate to specifie type of TextField.       |
| `label`             | text label of TextField.                       |
| `DecorationElement` | input decoration of TextField.                 |
| `onTap`             | callback when you click on TextField .         |
| `hint`              | text hint of textField.                        |
| `errorMsg`          | message to show when TextField isn't validate. |
| `labelStyle`        | style of label TextField                       |
| `errorStyle`        | style of error message TextField               |
| `hintStyle`         | style of hint TextFieldcolor                   |
| `readOnly`          | enable TextField uneditable                    |
| `validator`         | callback validation of TextField               |
| `padding`           | padding of TextField                           |
| `visibility`        | enable visibility of element                   |

### `EmailElement`

> Pre-exsiting element

> check validation of email

> Pre-initialized values

> extends from TextElement


| Properties             | Description                                                         |
| ---------------------- | ------------------------------------------------------------------- |
| `DecorationElement`    | input decoration of TextField.                                      |
| `label`                | text label of TextField.                                            |
| `hint`                 | text hint of textField.                                             |
| `isRequired`           | make textField required in validation                               |
| `errorEmailIsRequired` | error message for textField when it's required                      |
| `errorEmailPattern`    | error message for textField input when it's not email in validation |
| `labelStyle`           | style of label TextField                                            |
| `errorStyle`           | style of error message TextField                                    |
| `hintStyle`            | style of hint TextFieldcolor                                        |
| `readOnly`             | enable TextField uneditable                                         |
| `padding`              | padding of TextField                                                |

### `PasswordElement`


> Pre-exsiting element

> check validation of password

> Pre-initialized values

> show/hide password

> extends from TextElement

| Properties                 | Description                                                                 |
| -------------------------- | --------------------------------------------------------------------------- |
| `DecorationElement`        | input decoration of TextField.                                              |
| `label`                    | text label of TextField.                                                    |
| `hint`                     | text hint of textField.                                                     |
| `errorMsg`                 | message to show when TextField isn't validate.                              |
| `labelStyle`               | style of label TextField                                                    |
| `errorStyle`               | style of error message TextField                                            |
| `hintStyle`                | style of hint TextFieldcolor                                                |
| `readOnly`                 | enable TextField uneditable                                                 |
| `padding`                  | padding of TextField                                                        |
| `enableShowPassword`       | enable eye icon,make password text visible                                  |
| `isRequired`               | make passwordField required                                                 |
| `minLength`                | minimun length accepted by password                                         |
| `hasUppercase`             | make password contains at least one upperCase character                     |
| `hasSpecialCharacter`      | make password contains at least one special character                       |
| `hasDigits`                | make password contains at least one digits                                  |
| `requiredErrorMsg`         | message error to show when password is required                             |
| `minLengthErrorMsg`        | message error to show when password length is less then the specified       |
| `uppercaseErrorMsg`        | message error to show when password doesn't contain any upperCase character |
| `specialCharacterErrorMsg` | message error to show when password doesn't contain any special character   |


### `NumberElement`


> Pre-exsiting element for Number input

> Pre-initialized values

> enabled digitsOnly

> extends from TextElement

| Properties          | Description                                    |
| ------------------- | ---------------------------------------------- |
| `label`             | text label of TextField.                       |
| `hint`              | text hint of textField.                        |
| `DecorationElement` | input decoration of TextField.                 |
| `errorMsg`          | message to show when TextField isn't validate. |
| `labelStyle`        | style of label TextField                       |
| `errorStyle`        | style of error message TextField               |
| `hintStyle`         | style of hint TextFieldcolor                   |
| `readOnly`          | enable TextField uneditable                    |
| `padding`           | padding of TextField                           |
| `isDigits`          | enable only digit number                       |


### `CountryElement`


> Pre-exsiting element for Country input

> Pre-initialized values

> pick country via BottomSheet

> show flag of countries


| Properties              | Description                                   |
| ----------------------- | --------------------------------------------- |
| `DecorationElement`     | input decoration of TextField.                |
| `label`                 | text label of TextField.                      |
| `initValue`             | Initiale Value to country input.              |
| `labelModalSheet`       | Title of modalSheet                           |
| `labelSearchModalSheet` | hint search textfield in BottomSheet          |
| `countryTextResult`     | enumeration get result of selection countries |
| `showFlag`              | show flag of countris in modalsheet           |
| `padding`               | padding of TextField                          |
| `readonly`              | when enable  TextField to be unmodified       |

### `PhoneNumberElement`


> Pre-exsiting element for phone number input

> Pre-initialized values


#### `To Do` in `PhoneNumberElement`

- [ ] pick calling phone via BottomSheet

- [ ] show flag of countries for each calling code

### `Properties`

| Properties          | Description                                                  |
| ------------------- | ------------------------------------------------------------ |
| `DecorationElement` | input decoration of TextField.                               |
| `label`             | text label of TextField.                                     |
| `hint`              | text placeholder for phone number input.                     |
| `initValue`         | initial Value to phone input.                             |
| `errorMsg`          | text error message                                           |
| `validator`         | callback validation of TextField                             |
| `showPrefixFlag`    | enable flag country to be visible at left  of TextField      |
| `showSuffixFlag`    | enable flag country to be visible at rigth of TextField      |
| `padding`           | padding of TextField                                         |
| `showPrefix`        | show calling phone number(get current calling phone of user) |
| `readOnly`          | bool make TextField readOnly                                 |
| `initPrefix`        | (String) initial calling code of the specific country                                |
| `labelModalSheet`   | (String) title of bottom sheet that shown list of calling code of countries                                |

###  `TextAreaElement`

> Pre-exsiting element for multiLine  input (like commentField)
> Pre-initialized values


| Properties     | Description                                                           |
| -------------- | --------------------------------------------------------------------- |
| `maxLines`     | maximum line  to span in textField.                                   |
| `showCounter`  | enable visibility of counterText.                                     |
| `maxCharacter` | The limit on the number of characters that you can type  in textField |

###  `DateElement`

> Pre-exsiting element for date field  input
> Pre-initialized values

| Properties               | Description                                                           |
| ------------------------ | --------------------------------------------------------------------- |
| `id`                     | String,should be unique,
| `initDate`               | (DateTime)  initialize the input field
| `firstDate]`             | (DateTime)  represent earliest allowable Date in date picker
| `lastDate`               | (DateTime)  represent latest allowable Date in date picker
| `format`                 | (DateFormat)  for format the date  that you pick (default :DateFormat.yMd())
| `selectableDayPredicate` | (SelectableDayPredicate)  to enable dates to be selected
| `label`                  | (String) text label of TextField
| `decorationElement`      | input decoration of TextField
| `hint`                   | (String) hint text of textField
| `isRequired`             | (bool) if true,make this field required
| `errorMsg`               | (String) show error message  when the field isn't validate
| `padding`                | (EdgeInsets) padding of textField


### `DecorationElement`

> abstract class

> Pre-exsiting inputDecoration for  TextFormField

> Pre-initialized values

> Typically one of `UnderlineDecorationElement` or `OutlineDecorationElement` or `RoundedDecorationElement` can be used.

##### `UnderlineDecorationElement`


| Properties            | Description                                                                       |
| --------------------- | --------------------------------------------------------------------------------- |
| `borderColor`         | The border Color to display when the InputDecorator does not have the focus.      |
| `errorBorderColor`    | The borwidthLineder Color to display when the InputDecorator does have the error. |
| `focusBorderColor`    | The border Color to display when the InputDecorator does  have the focus.         |
| `disabledBorderColor` | The border Color to display when the InputDecorator is disabled.                  |
| `radius`              | radius of the border.                                                             |
| `widthSide`           | The width of this line of the border                                              |
| `filledColor`         | base fill color of the decoration                                                 |
| `focusColor`          | focused fill color of the decoration                                              |


##### `OutlineDecorationElement`

| Properties            | Description                                                                       |
| --------------------- | --------------------------------------------------------------------------------- |
| `borderColor`         | The border Color to display when the InputDecorator does not have the focus.      |
| `errorBorderColor`    | The borwidthLineder Color to display when the InputDecorator does have the error. |
| `focusBorderColor`    | The border Color to display when the InputDecorator does  have the focus.         |
| `disabledBorderColor` | The border Color to display when the InputDecorator is disabled.                  |
| `radius`              | radius of the border.                                                             |
| `widthSide`           | The width of this line of the border                                              |
| `filledColor`         | base fill color of the decoration                                                 |
| `focusColor`          | focused fill color of the decoration                                              |

### `RoundedDecorationElement`

> without BorderSide

| Properties    | Description                          |
| ------------- | ------------------------------------ |
| `radius`      | radius of the border.                |
| `filledColor` | base fill color of the decoration    |
| `focusColor`  | focused fill color of the decoration |


### `ButtonLoginDecorationElement`

> decoration for button login

| Properties              | Description                          |
| ------------------------| ------------------------------------ |
| `shapeButtonLogin`      | shape of the login button.           |
| `backgroundColorButton` | ackground color of the login button  |
| `widthSubmitButton`     | width size of the login button       |
| `elevation`             | elevation of the button              |

* example 
```dart
///decoration Element 
 final decoration = OutlineDecorationElement(
                     filledColor: Colors.white,
                     radius: BorderRadius.only(
                       topLeft: Radius.circular(5.0),
                       topRight: Radius.circular(5.0),
                     ),
                     widthSide: 0.6,
                   );
```

### `PasswordControls`

> define an validation rules for password input

| Properties                 | Description                                                                 |
| ---------------------------| ----------------------------------------------------------------------------|
| `minLength`                | minimum length accepted by password                                         |
| `hasUppercase`             | make password contains at least one upperCase character                     |
| `hasSpecialCharacter`      | make password contains at least one special character                       |
| `hasDigits`                | make password contains at least one digits                                  |


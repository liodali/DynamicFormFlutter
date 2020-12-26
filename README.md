# dynamicform
![pub](https://img.shields.io/badge/pub-v0.5.0-orange) ![GitHub](https://img.shields.io/github/license/liodali/checkbox_grouped)

create your form with easier way

## Getting Started

 * generate custom form
 * login Form
 * payment form
 * Pre-existing elements

## Installing

Add the following to your `pubspec.yaml` file:

    dependencies:
		dynamic_form: ^0.5.0



## Simple Usage
#### Creating a basic `SimpleDynamicForm`:

        SimpleDynamicForm(
                  key: dynamicFormKey,
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



####  `Properties in SimpleDynamicForm`

 | Properties                     | Description                                                    |
 | ------------------------------ | -------------------------------------------------------------- |
 | `groupElements`                | list of element to build your form                             |
 | `padding`                      |  The amount of space by which to inset the form                |


### Declare GlobalKey to get validation,list values of forms

`  GlobalKey<SimpleDynamicFormState> dynamicFormKey = GlobalKey<SimpleDynamicFormState>();`

### validate forms

` dynamicFormKey.currentState.validate() `
### recuperate all values in form :
` dynamicFormKey.currentState.recuperateAllValues() `

> if you are used ids in element, you can recuperate values with

` dynamicFormKey.currentState.recuperateByIds()`

> you recuperate by id

` dynamicFormKey.currentState.singleValueById(id)`
### clear  all inputs in form :

` dynamicFormKey.currentState.clearValues()`


### LoginForm
> pre-existing login form to make easy for you to build
## Simple Usage
#### Creating a basic `LoginForm` :


```
    LoginForm(
          callback: (email, password) {
            print("$email,$password");
          },
          buttonLoginDecorationElement: ButtonLoginDecorationElement(
              backgroundColorButton: Colors.white,
              widthSubmitButton: 200,
              shapeButtonLogin: StadiumBorder().copyWith(
                side: BorderSide(
                  color: Colors.amber,
                  width: 0.6,
                ),
              ),
              elevation: 0.0),
          onlyEmail: false,
          labelLogin: "Username",
          password: "Password",
          textButton: Text("Log IN"),
          paddingFields: const EdgeInsets.all(0),
          decorationEmailElement: OutlineDecorationElement(
            filledColor: Colors.white,
            radius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            widthSide: 0.6,
          ),
          decorationPasswordElement: OutlineDecorationElement(
            filledColor: Colors.white,
            radius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
            widthSide: 0.6,
          ),
        )
```


####  `Properties in LoginForm`

 | Properties                     | Description                                                    |
 | ------------------------------ | -------------------------------------------------------------- |
 | `decorationEmailElement`       | input decoration of email field in form                             |
 | `decorationPasswordElement`    | input decoration of password field in form                             |
 | `directionGroup`               | Direction of form (Vertical/Horizontal)                        |
 | `paddingFields`                | padding between fields                                         |
 | `onlyEmail`                    | enable only email type fieldtext                               |
 | `labelLogin`                   | label  of username/email textField                             |
 | `password`                     | label of the passwordField                                     |
 | `callback`                     | callback to make your api call when you form is validate       |
 | `textButton`                   | Text widget of the submit button                               |
 | `buttonLoginDecorationElement` | decoration of button that contain radius,backgroundColor,width |
 | `passwordError`                | messages errors to show  when password field not validate      |
 | `usernameEmailError`           | messages errors to show when email/username not validate       |


### PaymentForm
> pre-existing payment form to make easy for you to build
## Simple Usage
#### Creating a basic `PaymentForm` :


```
    PaymentForm(
          decorationElement: OutlineDecorationElement(),
          actionPayment: (cardNumber, cvv, date) async {
            print("Credit Card information : $cardNumber,$cvv,$date");
          },
          errorMessageCVV: "cvv is invalid",
          errorMessageDateExpiration: "date expiration is invalid",
          errorIsRequiredMessage: "This field  is required",
          labelCVV: "cvv",
          labelDateExpiration: "date expiration",
          labelCardNumber: "card number",
          paymentText: Text("purchase"),
        )
```


####  `Properties in LoginForm`

 | Properties                     | Description                                                    |
 | ------------------------------ | -------------------------------------------------------------- |
 | `decorationElement`            | decoration of all input field in form                             |
 | `actionPayment`                | callback to make your api call when you form is validate       |
 | `paymentText`                  | Text widget of the submit button                               |
 | `buttonDecoration`             | decoration of button that contain radius,backgroundColor,width |
 | `errorMessageDateExpiration`   | messages errors to show  when Date Expiration field not validate      |
 | `errorMessageCVV`              | messages errors to show when cvv field is invalidate            |
 | `errorMessageCardNumber`       | messages errors to show when credit card number is invalidate   |
 | `errorIsRequiredMessage`       | messages errors to show when at least one field not filled      |
 | `labelCardNumber`              | text label of credit card number field                          |
 | `labelDateExpiration`          | text label of date expiration field                             |
 | `labelCVV`                     | text label of cvv field                                         |



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
| `initValue`         | Initiale Value to country input.                             |
| `errorMsg`          | text error message                                           |
| `validator`         | callback validation of TextField                             |
| `showPrefixFlag`    | enable flag country to be visible at left  of TextField      |
| `showSuffixFlag`    | enable flag country to be visible at rigth of TextField      |
| `padding`           | padding of TextField                                         |
| `showPrefix`        | show calling phone number(get current calling phone of user) |
| `readOnly`          | bool make TextField readOnly                                 |

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


### `PasswordControls`

> define an validation rules for password input

| Properties                 | Description                                                                 |
| ---------------------------| ----------------------------------------------------------------------------|
| `minLength`                | minimun length accepted by password                                         |
| `hasUppercase`             | make password contains at least one upperCase character                     |
| `hasSpecialCharacter`      | make password contains at least one special character                       |
| `hasDigits`                | make password contains at least one digits                                  |


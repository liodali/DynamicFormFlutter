# dynamicform
![pub](https://img.shields.io/badge/pub-v0.3.6-orange) ![GitHub](https://img.shields.io/github/license/liodali/checkbox_grouped)

create your form with easier way

## Getting Started

 * generate form
 * Pre-existing elements

## Installing

Add the following to your `pubspec.yaml` file:

    dependencies:
		dynamic_form: ^0.3.6



## Simple Usage
#### Creating a basic `SimpleDynamicForm`

    SimpleDynamicForm(
          key: dynamicFormKey,
          groupElements: [
                  GroupElement(
                                directionGroup: DirectionGroup.Vertical,
                                textElements: [
                                TextElement(label: "name"),
                                TextElement(
                                     label: "password", typeInput: TypeInput.Password)
                                  ],
                                 )
                      ],
                  );


### Declare GlobalKey to get validation,list values of forms

`  GlobalKey<SimpleDynamicFormState> dynamicFormKey = GlobalKey<SimpleDynamicFormState>();`

### validate forms

` dynamicFormKey.currentState.validate() `
### all values in form

` dynamicFormKey.currentState.recuperateAllValues() `

### How to skectch your form ?

> ` textElement is small element in dynamicForm `
> ` GroupElement is group of TextElement`

####  `GroupElement`
| Properties           | Description                         |
| -------------------- | ----------------------------------- |
| `directionGroup`     |  Direction of form (Vertical/Horizontal)           |
| `sizeElements`       |  size of each textElement  of form When direction Horizontal,sum of values should be egal a 1           |
| `textElements`       |  group of textElement.              |
| `padding`            |  padding of groups.                 |
| `decoration`         |  decoration  of container groups.   |
| `backgroundColor`    |  color of the container groups.     |


####  `textElement`
| Properties           | Description                         |
| -------------------- | ----------------------------------- |
| `typeInput`          |  Enumerate to specifie type of TextField.  |
| `label`              |  text label of TextField.            |
| `DecorationElement`  |  input decoration of TextField.            |
| `onTap`              |  callback when you click on TextField .  |
| `hint`               |  text hint of textField.             |
| `errorMsg`           |  message to show when TextField isn't validate. |
| `labelStyle`         |  style of label TextField            |
| `errorStyle`         |  style of error message TextField    |
| `hintStyle`          |  style of hint TextFieldcolor        |
| `readOnly`           |  enable TextField uneditable         |
| `validator`          |  callback validation of TextField    |
| `padding`            |  padding of TextField                |

### `EmailElement`

> Pre-exsiting element with check validation of email

> Pre-initialized values

> extends from TextElement

| Properties             | Description                             |
| -----------------------| ----------------------------------------|
| `label`                |  text label of TextField.               |
| `hint`                 |  text hint of textField.                |
| `isRequired`           |  make textField required in validation  |
| `errorEmailIsRequired` |  error message for textField when it's required  |
| `errorEmailPattern`    |  error message for textField input when it's not email in validation |
| `errorMsg`             |  message to show when TextField isn't validate.       |
| `labelStyle`           |  style of label TextField               |
| `errorStyle`           |  style of error message TextField       |
| `hintStyle`            |  style of hint TextFieldcolor           |
| `readOnly`             |  enable TextField uneditable            |
| `padding`              |  padding of TextField                   |

### `PasswordElement`


> Pre-exsiting element with check validation of password

> Pre-initialized values

> show/hide password

> extends from TextElement

| Properties                 | Description                         |
| ---------------------------| ----------------------------------- |
| `label`                    |  text label of TextField.                            |
| `hint`                     |  text hint of textField.                             |
| `errorMsg`                 |  message to show when TextField isn't validate.      |
| `labelStyle`               |  style of label TextField                            |
| `errorStyle`               |  style of error message TextField                    |
| `hintStyle`                |  style of hint TextFieldcolor                        |
| `readOnly`                 |  enable TextField uneditable                         |
| `padding`                  |  padding of TextField                                |
| `enableShowPassword`       |  enable eye icon,make password text visible          |
| `isRequired`               |  make passwordField required                         |
| `minLength`                |  minimun length accepted by password                 |
| `hasUppercase`             |  make password contains at least one upperCase character |
| `hasSpecialCharacter`      |  make password contains at least one special character   |
| `hasDigits`                |  make password contains at least one digits              |
| `requiredErrorMsg`         |  message error to show when password is required         |
| `minLengthErrorMsg`        |  message error to show when password length is less then the specified            |
| `uppercaseErrorMsg`        |  message error to show when password doesn't contain any upperCase character      |
| `specialCharacterErrorMsg` |  message error to show when password doesn't contain any special character        |


### `NumberElement`


> Pre-exsiting element for Number input

> Pre-initialized values

> enabled digitsOnly

> extends from TextElement

| Properties           | Description                         |
| -------------------- | ----------------------------------- |
| `label`              |  text label of TextField.            |
| `hint`               |  text hint of textField.             |
| `errorMsg`           |  message to show when TextField isn't validate.       |
| `labelStyle`         |  style of label TextField            |
| `errorStyle`         |  style of error message TextField    |
| `hintStyle`          |  style of hint TextFieldcolor        |
| `readOnly`           |  enable TextField uneditable         |
| `padding`            |  padding of TextField                |
| `isDigits`           |  enable only digit number            |


### `CountryElement`


> Pre-exsiting element for Country input

> Pre-initialized values

> pick country via BottomSheet

> show flag of countries


| Properties                | Description                         |
| --------------------------| ----------------------------------- |
| `label`                   |  text label of TextField.            |
| `initValue`               |  Initiale Value to country input.    |
| `labelModalSheet`         |  Title of modalSheet                 |
| `labelSearchModalSheet`   |  hint search textfield in BottomSheet |
| `countryTextResult`       |  enumeration get result of selection countries |
| `showFlag`                |  show flag of countris in modalsheet        |
| `padding`                 |  padding of TextField                |

### `DecorationElement`

> abstract class

> Pre-exsiting inputDecoration for  TextFormField

> Pre-initialized values

> Typically one of `UnderlineDecorationElement` or `OutlineDecorationElement` or `RoundedDecorationElement` can be used.

### `UnderlineDecorationElement` and `OutlineDecorationElement`


| Properties                | Description                         |
| --------------------------| ----------------------------------- |
| `borderColor`             |  The border Color to display when the InputDecorator does not have the focus.            |
| `errorBorderColor`        |  The borwidthLineder Color to display when the InputDecorator does have the error.    |
| `focusBorderColor`        |  The border Color to display when the InputDecorator does  have the focus.                 |
| `disabledBorderColor`     |  The border Color to display when the InputDecorator is disabled. |
| `radius`                  |  radius of the border.               |
| `widthSide`               |  The width of this line of the border|
| `filledColor`             |  base fill color of the decoration   |
| `focusColor`              |  focused fill color of the decoration|


### `RoundedDecorationElement`

| Properties                | Description                         |
| --------------------------| ----------------------------------- |
| `radius`                  |  radius of the border.               |
| `filledColor`             |  base fill color of the decoration   |
| `focusColor`              |  focused fill color of the decoration|
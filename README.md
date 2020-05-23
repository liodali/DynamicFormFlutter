# dynamicform
![pub](https://img.shields.io/badge/pub-v0.3.8-orange) ![GitHub](https://img.shields.io/github/license/liodali/checkbox_grouped)

create your form with easier way

## Getting Started

 * generate form
 * Pre-existing elements

## Installing

Add the following to your `pubspec.yaml` file:

    dependencies:
		dynamic_form: ^0.3.8



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

### LoginForm
> pre-existing login form to make easy for you to build
## Simple Usage
#### Creating a basic `LoginForm`

    LoginForm(
          callback: (email,password){
                //api call
          },
          buttonLoginDecorationElement: ButtonLoginDecorationElement(
                  backgroundColorButton: Colors.amber,
                  widthSubmitButton: 200,
                  radiusBorderButton: 10,
           ),
          onlyEmail: false,
          labelLogin: "Username",
          password: "Password",
          textButton: Text("Log IN"),
          decorationElement: RoundedDecorationElement(
            filledColor: Colors.grey[300],
          ),
        )


####  `Properties in LoginForm`

| Properties                          | Description                         |
| ------------------------------------| ----------------------------------- |
| `decorationElement`                 |  input decoration of fields of form |
| `directionGroup`                    |  Direction of form (Vertical/Horizontal)  |
| `paddingFields`                     |  padding between fields             |
| `onlyEmail`                         |  enable only email type fieldtext   |
| `labelLogin`                        |  label  of username/email textField |
| `password`                          |  label of the passwordField        |
| `callback`                          |  callback to make your api call when you form is validate |
| `textButton`                        |  Text widget of the submit button   |
| `buttonLoginDecorationElement`      |  decoration of button that contain radius,backgroundColor,width |
| `passwordError`                     |  messages errors to show  when password field not validate     |
| `usernameEmailError`                |  messages errors to show when email/username not validate    |


### How to skectch your form ?

> ` textElement is small element in dynamicForm `
> ` GroupElement is group of TextElement`

####  `GroupElement`
| Properties           | Description                         |
| -------------------- | ----------------------------------- |
| `directionGroup`     |  Direction of form (Vertical/Horizontal) |
| `DecorationElement`     |  Direction of form (Vertical/Horizontal) |
| `sizeElements`       |  size of each textElement  of form When direction Horizontal,sum of values should be egal a 1           |
| `textElements`       |  group of textElement.              |
| `padding`            |  padding of groups.                 |
| `decoration`         |  decoration  of container groups.   |
| `backgroundColor`    |  color of the container groups.     |


####  `textElement`
| Properties           | Description                                |
| -------------------- | -----------------------------------        |
| `typeInput`          |  Enumerate to specifie type of TextField.  |
| `label`              |  text label of TextField.                  |
| `DecorationElement`  |  input decoration of TextField.            |
| `onTap`              |  callback when you click on TextField .    |
| `hint`               |  text hint of textField.                   |
| `errorMsg`           |  message to show when TextField isn't validate. |
| `labelStyle`         |  style of label TextField                  |
| `errorStyle`         |  style of error message TextField          |
| `hintStyle`          |  style of hint TextFieldcolor              |
| `readOnly`           |  enable TextField uneditable               |
| `validator`          |  callback validation of TextField          |
| `padding`            |  padding of TextField                      |

### `EmailElement`

> Pre-exsiting element

> check validation of email

> Pre-initialized values

> extends from TextElement


| Properties             | Description                             |
| -----------------------| ----------------------------------------|
| `DecorationElement`    |  input decoration of TextField.         |
| `label`                |  text label of TextField.               |
| `hint`                 |  text hint of textField.                |
| `isRequired`           |  make textField required in validation  |
| `errorEmailIsRequired` |  error message for textField when it's required  |
| `errorEmailPattern`    |  error message for textField input when it's not email in validation |
| `labelStyle`           |  style of label TextField               |
| `errorStyle`           |  style of error message TextField       |
| `hintStyle`            |  style of hint TextFieldcolor           |
| `readOnly`             |  enable TextField uneditable            |
| `padding`              |  padding of TextField                   |

### `PasswordElement`


> Pre-exsiting element

> check validation of password

> Pre-initialized values

> show/hide password

> extends from TextElement

| Properties                 | Description                                          |
| ---------------------------| -----------------------------------                  |
| `DecorationElement`        |  input decoration of TextField.                      |
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

| Properties           | Description                          |
| -------------------- | -----------------------------------  |
| `label`              |  text label of TextField.            |
| `hint`               |  text hint of textField.             |
| `DecorationElement`  |  input decoration of TextField.      |
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


| Properties                | Description                               |
| --------------------------| -----------------------------------       |
| `DecorationElement`       |  input decoration of TextField.           |
| `label`                   |  text label of TextField.                 |
| `initValue`               |  Initiale Value to country input.         |
| `labelModalSheet`         |  Title of modalSheet                      |
| `labelSearchModalSheet`   |  hint search textfield in BottomSheet     |
| `countryTextResult`       |  enumeration get result of selection countries |
| `showFlag`                |  show flag of countris in modalsheet      |
| `padding`                 |  padding of TextField                     |

### `PhoneNumberElement`


> Pre-exsiting element for phone number input

> Pre-initialized values


#### `To Do`

[ ] pick calling phone via BottomSheet

[ ] show flag of countries for each calling code

### `Properties`

| Properties                | Description                               |
| --------------------------| -----------------------------------       |
| `DecorationElement`       |  input decoration of TextField.           |
| `label`                   |  text label of TextField.                 |
| `hint`                    |  text placeholder for phone number input. |
| `initValue`               |  Initiale Value to country input.         |
| `errorMsg`                |  text error message                       |
| `validator`               |   callback validation of TextField        |
| `showFlag`                |  show flag of countris in rigth of input  |
| `padding`                 |  padding of TextField                     |
| `showPrefix`              |  show calling phone number(get current calling phone of user)|
| `readOnly`                |  bool make TextField readOnly             |

### `DecorationElement`

> abstract class

> Pre-exsiting inputDecoration for  TextFormField

> Pre-initialized values

> Typically one of `UnderlineDecorationElement` or `OutlineDecorationElement` or `RoundedDecorationElement` can be used.

##### `UnderlineDecorationElement`


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


##### `OutlineDecorationElement`

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

> without BorderSide

| Properties                | Description                         |
| --------------------------| ----------------------------------- |
| `radius`                  |  radius of the border.               |
| `filledColor`             |  base fill color of the decoration   |
| `focusColor`              |  focused fill color of the decoration|
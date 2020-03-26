# dynamicform
![pub](https://img.shields.io/badge/pub-v0.1.0-orange) ![GitHub](https://img.shields.io/github/license/liodali/checkbox_grouped)

create your form with easier way

## Getting Started

 * generate form
 * Pre-existing elements

## Installing

Add the following to your `pubspec.yaml` file:

    dependencies:
		dynamicForm: ^0.1.0



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
                                      ])
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

####  `textElement`
| Properties           | Description                         |
| -------------------- | ----------------------------------- |
| `typeInput`          |  Enumerate to specifie type of TextField.  |
| `label`              |  text label of TextField.            |
| `hint`               |  text hint of textField.             |
| `errorMsg`           |  message to show when TextField isn't validate.       |
| `labelStyle`         |  style of label TextField            |
| `errorStyle`         |  style of error message TextField    |
| `hintStyle`          |  style of hint TextFieldcolor        |
| `readOnly`           |  enable TextField uneditable         |
| `validator`          |  callback validation of TextField    |
| `padding`            |  padding of TextField                |




import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:wastetastic/Constants.dart';
import 'package:wastetastic/control/WasteRecordMgr.dart';
import 'package:wastetastic/entity/WasteCategory.dart';
import 'package:wastetastic/widgets/HeaderCard.dart';

final _formKey = GlobalKey<FormState>();
String selectedTime = '12:00';
String selectedDate = DateTime.now().toString();
String enteredWeight;
String selectedCategory = 'NORMAL WASTE';

class AddWasteScreen extends StatefulWidget {
  @override
  _AddWasteScreenState createState() => _AddWasteScreenState();
}

class _AddWasteScreenState extends State<AddWasteScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header_card(
          title: "Add New Record",
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DateTimePicker(
                      initialValue: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'Date',
                      icon: Icon(Icons.event),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter Date';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        selectedDate = val;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DateTimePicker(
                      type: DateTimePickerType.time,
                      initialValue: selectedTime,
                      timeLabelText: "Time",
                      icon: Icon(Icons.access_time),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter Time';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        selectedTime = val;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter Weight',
                        suffixText: 'Kg',
                        icon: Icon(Icons.shopping_cart_rounded),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter weight';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        enteredWeight = value;
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      icon: Icon(Icons.arrow_drop_down),
                      decoration: InputDecoration(
                          labelText: 'Waste Category',
                          icon: Icon(Icons.receipt_long)),
                      iconSize: 24,
                      elevation: 20,
                      style: TextStyle(color: Colors.white),
                      onChanged: (String newValue) {
                        setState(
                          () {
                            selectedCategory = newValue;
                          },
                        );
                      },
                      dropdownColor: Colors.grey[900],
                      items: kWasteCategory
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.

                              print(
                                  'date: ${selectedDate.substring(0, 10)} \n time: $selectedTime \n'
                                  'weight: $enteredWeight \n category: $selectedCategory');
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                              //@todo code to add details to user waste records
                              print(selectedCategory.replaceAll(' ', '_'));
                              WasteRecordMgr.addNewRecord(
                                'sdidt',
                                DateTime.parse(selectedDate.substring(0, 10) +
                                    " " +
                                    selectedTime),
                                double.parse(enteredWeight),
                                WasteCategory.values.firstWhere((element) =>
                                    element.toString() ==
                                    ('WasteCategory.' +
                                        selectedCategory.replaceAll(' ', '_'))),
                              );
                              //Dialog box
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title:
                                        Center(child: Text('New Record Added')),
                                    content: Text(
                                      "Yaaay!! You have added a new Waste Record to "
                                      "your account",
                                    ),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        textColor: Colors.grey,
                                        child: const Text('Continue'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('Add Record'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddDataForm extends StatefulWidget {
//   @override
//   _AddDataFormState createState() => _AddDataFormState();
// }

// class _AddDataFormState extends State<AddDataForm> {
//   final _formKey = GlobalKey<FormState>();
//   String title = '';
//   String description = '';
//   String imageUrl = '';
//   String googleMapUrl = '';
//   String name = '';
//   String numberOfChurch = '';
//   String createdTime = '';

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Title'),
//               onChanged: (value) => title = value,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a title';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Description'),
//               onChanged: (value) => description = value,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a description';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Image URL'),
//               onChanged: (value) => imageUrl = value,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter an image URL';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Google Map URL'),
//               onChanged: (value) => googleMapUrl = value,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a Google Map URL';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Name'),
//               onChanged: (value) => name = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Number of Churches'),
//               onChanged: (value) => numberOfChurch = value,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Created Time'),
//               onChanged: (value) => createdTime = value,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   // Store the item
//                   Map<String, dynamic> newItem = {
//                     'title': title,
//                     'description': description,
//                     'image': imageUrl,
//                     'url': googleMapUrl,
//                     'more': {
//                       'name': name,
//                        'number of church': numberOfChurch,
//                       'created time': createdTime,
//                     },
//                   };

//                   await FirebaseFirestore.instance
//                       .collection('churches')
//                       .add(newItem);

//                   // Clear the form fields
//                   title = '';
//                   description = '';
//                   imageUrl = '';
//                   googleMapUrl = '';
//                   name = '';
//                   numberOfChurch = '';
//                   createdTime = '';

//                   // Close the modal
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Add Church'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddDataForm extends StatefulWidget {
  @override
  _AddDataFormState createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final List<String> names = [
    'Kolefe',
    'Lemi Kura',
    'Bole',
    'Yeka',
    'Addis Ketma',
    'Ledeta',
    'Guleli',
    'Lafto',
    'Kirkos',
    'Kality'
  ];
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  String _imageUrl = '';
  String _title = '';
  String _Name = '';
  DateTime? _selectedDate;
  String _SundaySchool = '';
  String _NameOfArks = '';
  String? _SubCity = 'Bole';
  String _description = '';
  String _googleMapUrl = '';
  File? _imageFile;

   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Set the starting date range
      lastDate: DateTime(2101), // Set the ending date range
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked; // Set the selected date
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Picker Button
            ElevatedButton(
              onPressed: () async {
                final pickedFile =
                    await _picker.getImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                  });
                }
              },
              child: Text('Pick Image'),
            ),
            // Display the picked image
            if (_imageFile != null) Image.file(_imageFile!, height: 100),

            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Name';
                }
                return null;
              },
              onSaved: (value) {
                _Name = value!;
              },
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Start Date',
                hintText: _selectedDate != null
                    ? DateFormat('yyyy-MM-dd').format(_selectedDate!) // Format date
                    : 'Select Start Date',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context), // Call date picker
                ),
              ),
              validator: (value) {
                if (_selectedDate == null) {
                  return 'Please select a date';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Sunday School'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Sunday School';
                }
                return null;
              },
              onSaved: (value) {
                _SundaySchool = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name of Ark'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Name of Arks';
                }
                return null;
              },
              onSaved: (value) {
                _NameOfArks = value!;
              },
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'SubCity'),
              value: _SubCity,
              items: <String>['Kolefe', 'Lemi Kura', 'Bole', 'Yeka', 'Addis Ketma', 'Ledeta', 'Guleli', 'Lafto', 'Kirkos', 'Kality'].map((String name) {
                return DropdownMenuItem<String>(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _SubCity = newValue; // Update the selected value
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a SubCity';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Google Map URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Google Map URL';
                }
                return null;
              },
              onSaved: (value) {
                _googleMapUrl = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Save data to Firebase
                  _saveDataToFirebase();
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDataToFirebase() async {
    if (_imageFile != null) {
      // Upload the image to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('church_images/${DateTime.now().toString()}');
      await ref.putFile(_imageFile!);

      // Get the download URL/
      _imageUrl = await ref.getDownloadURL();
    }

    // Add the data to Firestore
    await FirebaseFirestore.instance.collection('churches').add({
      'imageUrl': _imageUrl,
      'title': _title,
      'Name': _Name,
      'Date': _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : '',
      'SundaySchool': _SundaySchool,
      'NameOfArks': _NameOfArks,
      'SubCity': _SubCity,
      'description': _description,
      'googleMapUrl': _googleMapUrl,
    });
  }
}

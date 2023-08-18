import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:student_profile/screen/student_detail.dart';
import 'package:student_profile/sql_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  File? _selectedImage;

  void _refreshJournals() async {
    final data = await SqlHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    _foundUsers = _journals;

    print("..nummber of items ${_journals.length}");
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _addItem() async {
    final imagePath = _selectedImage != null ? _selectedImage!.path : null;
    final _name = _nameController.text.trim();
    final _studentId = _studentIdController.text.trim();
    final _domain = _domainController.text.trim();
    final _batch = _batchController.text.trim();
    final _place = _placeController.text.trim();
    if (_name.isEmpty ||
        _studentId.isEmpty ||
        _domain.isEmpty ||
        _batch.isEmpty ||
        _place.isEmpty) {
      return null;
    }
    await SqlHelper.createItem(
      _nameController.text,
      _studentIdController.text,
      _domainController.text,
      _batchController.text,
      imagePath,
      _placeController.text,
    );
    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    final imagePath = _selectedImage != null ? _selectedImage!.path : null;
    await SqlHelper.updateItem(
      id,
      _nameController.text,
      _studentIdController.text,
      _domainController.text,
      _batchController.text,
      _placeController.text,imagePath,
    );
    _refreshJournals();
  }

  Future<void> _deleteItem(int id) async {
    await SqlHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  // void _runFilter(String enterKeyword) {
  //   List<Map<String, dynamic>> results = [];
  //   if (enterKeyword.isEmpty) {
  //     results = _journals;
  //   } else {
  //     results = _journals
  //         .where((element) => element["name"]
  //             .toString()
  //             .toLowerCase()
  //             .contains(enterKeyword.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     _foundUsers = results;
  //   });
  // }
  void _runFilter(String enterKeyword) {
    if (enterKeyword.isEmpty) {
      setState(() {
        _foundUsers = _journals;
      });
    } else {
      final results = _journals
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(enterKeyword.toLowerCase()))
          .toList();
      setState(() {
        _foundUsers = results;
      });
    }
  }

  void _showForm(id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _nameController.text = existingJournal['name'];
      _studentIdController.text = existingJournal['studentId'].toString();
      _domainController.text = existingJournal['domain'];
      _batchController.text = existingJournal['batch'].toString();
      _placeController.text = existingJournal['place'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 120,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: IconButton(
                              onPressed: () async {
                                final pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  final File? imageFile =
                                      File(pickedImage.path);
                                  setState(() {
                                    _selectedImage = imageFile;
                                  });
                                }
                              },
                              icon: Icon(Icons.add_a_photo_rounded))),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name field is required';
                          } else {
                            return null;
                          }
                        },
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: 'Name', border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'StudentId field is required';
                          } else {
                            return null;
                          }
                        },
                        controller: _studentIdController,
                        decoration: const InputDecoration(
                            hintText: 'StudentId',
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'place field is required';
                          } else {
                            return null;
                          }
                        },
                        controller: _domainController,
                        decoration: const InputDecoration(
                            hintText: 'Domain', border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Batch field is required';
                          } else {
                            return null;
                          }
                        },
                        controller: _batchController,
                        decoration: const InputDecoration(
                            hintText: 'Batch', border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator:(value){
                         if (value == null || value.isEmpty) {
                            return 'StudentId field is required';
                          } else {
                            return null;
                          }
                        },
                        controller: _placeController,
                        decoration: InputDecoration(
                          hintText: 'place',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (id == null) {
                            await _addItem();
                          }
                          if (id != null) {
                            await _updateItem(id);
                          }
                          _nameController.text = '';
                          _studentIdController.text = '';
                          _domainController.text = '';
                          _batchController.text = '';
                          _placeController.text = '';
                          Navigator.of(context).pop();
                          _formKey.currentState!.validate();
                        },
                        child: Text(id == null ? "create new" : 'update'),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Student Manager')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  color: Color.fromARGB(255, 214, 167, 26),
                  margin: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentDetails(
                          name: _foundUsers[index]['name'],
                          studentId: _foundUsers[index]['studentId'],
                          domain: _foundUsers[index]['domain'],
                          batch: _foundUsers[index]['batch'],
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(_foundUsers[index]['name']),
                      subtitle: Text(_foundUsers[index]['domain']),
                      leading: CircleAvatar(
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : null,
                        child: _selectedImage == null
                            ? IconButton(
                                onPressed: () =>
                                    _showForm(_foundUsers[index]['id']),
                                icon: Icon(Icons.add_a_photo_rounded),
                              )
                            : null,
                        //backgroundImage: _foundUsers[index]["image"],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () =>
                                    _showForm(_foundUsers[index]['id']),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () =>
                                    _deleteItem(_foundUsers[index]['id']),
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _showForm(null),
        ),
      ),
    );
  }
}

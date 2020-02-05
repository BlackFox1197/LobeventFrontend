import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final _profileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(labelText: 'Search Profile'),
          controller: _profileController,
        ),
        leading: MaterialButton(
          child: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _submitProfileSearch();
          },
        ),
        ),
    );
  }

  void _submitProfileSearch(){
    String userName = _profileController.text;

  }
}

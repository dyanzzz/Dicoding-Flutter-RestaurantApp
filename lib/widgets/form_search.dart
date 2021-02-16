import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:flutter/material.dart';

import '../common/styles.dart';

class FormSearch extends StatefulWidget {
  final void Function(String search) onSearch;

  FormSearch({this.onSearch});

  @override
  _FormSearchState createState() => _FormSearchState();
}

class _FormSearchState extends State<FormSearch> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidate = false;
  var _search;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: AppConfig.SearchDot,
                border: OutlineInputBorder(),
                filled: true,
                errorStyle: TextStyle(fontSize: 15),
              ),
              onChanged: (value) {
                _search = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return AppConfig.PleaseFillFormSearch;
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: RawMaterialButton(
                onPressed: () {
                  final isValid = _formKey.currentState.validate();
                  if (isValid) {
                    widget.onSearch(_search);
                    FocusManager.instance.primaryFocus.unfocus();
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
                fillColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    AppConfig.Search,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

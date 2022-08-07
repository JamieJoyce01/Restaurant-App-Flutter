import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookTablePage extends StatefulWidget {
  const BookTablePage({Key? key}) : super(key: key);

  @override
  State<BookTablePage> createState() => _BookTablePageState();
}

class _BookTablePageState extends State<BookTablePage> {
  final _bookFormkey = GlobalKey<FormState>();
  var _persons = 0;
  var _date;
  var _returnText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Book a Table"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          Form(key: _bookFormkey,
              child: Column(children: [
                const Text("Number of people attending:", style: TextStyle(fontSize: 15),),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    hintText: 'Amount of people',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid number';
                    }
                    _persons = int.parse(value);
                  },
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15,),
                ElevatedButton(onPressed: () async {
                  _date = await showDatePicker(context: context,
                      initialDate: _date ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year+1));
                }, child: const Text("Pick a date")),
                const SizedBox(height: 20,),
                Text(_returnText),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: () {
                  if(_bookFormkey.currentState!.validate()) {
                    if (_date == null) {
                      setState(() {
                        _returnText = "Please enter a date!";
                      });
                    } else {
                      setState(() {
                        _returnText = "";
                      });
                    }
                  }
                }, child: const Text("Submit booking"))
              ],))
        ],
      ),
    );
  }
}

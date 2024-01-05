import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountControler.text.isEmpty) return;
    final enteredTitle = _titleControler.text;
    final enteredAmount = double.parse(_amountControler.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019, 1, 1),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(children: [
            TextField(
              cursorColor: Colors.red,
              decoration: InputDecoration(labelText: 'Title: '),
              controller: _titleControler,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount: '),
              controller: _amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 75,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No date chosen!'
                        : 'Picked Date: ${DateFormat.yMMMMd().format(_selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text(
                'Add transaction',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
        elevation: 5,
      ),
    );
  }
}

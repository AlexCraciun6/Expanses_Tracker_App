import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TrasactionItem extends StatelessWidget {
  const TrasactionItem({
    Key key,
    @required this.transaction,
    @required this.deletetx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deletetx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                  '\$ ${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
          radius: 30,
        ),
        title: Text(
          transaction.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 80, 75, 75),
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  deletetx(transaction.id);
                },
                icon: Icon(Icons.delete),
                label: const Text('Delete'))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  deletetx(transaction.id);
                },
              ),
      ),
    );
  }
}

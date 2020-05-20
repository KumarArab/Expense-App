import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxs;

  TransactionList({this.transactions, this.deleteTxs});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraint) {
                return Column(
                  children: <Widget>[
                    Text(
                      "You have no transactions yet!",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        height: constraint.maxHeight * 0.6,
                        child: Image.asset('assets/images/waiting.png',
                            fit: BoxFit.cover)),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.all(13.0),
                  elevation: 6.0,
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff0288D1), Color(0xff26C6DA)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(0, 0, 0, 0),
                          foregroundColor: Colors.black,
                          radius: 30.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                "\$${transactions[index].amount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.redAccent,
                        onPressed: () => deleteTxs(transactions[index].id)),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

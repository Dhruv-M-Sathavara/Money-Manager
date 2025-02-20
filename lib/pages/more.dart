import 'package:expance_manager/functions/database_conectivity.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.backup, color: Colors.blue.shade300),
                    Text("Backup")
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      color: Colors.red.shade300,
                      onPressed: () async {
                        bool confirmDelete = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete All Transactions"),
                              content: Text("Are you sure you want to delete all transaction history?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false), 
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true), 
                                  child: Text("Delete", style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        ) ?? false;

                        if (confirmDelete) {
                          await DBOP().deleteAll();
                          setState(() {}); 
                        }
                      },
                      icon: Icon(Icons.delete),
                    ),
                    Text("Delete History"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.people, color: Colors.green.shade300),
                    Text("Split")
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';

class VotePost extends StatefulWidget {
  const VotePost({
    Key? key,
    required this.votes,
    required this.volName,
    required this.date,
    required this.text,
  }) : super(key: key);
  final List votes;
  final String volName;
  final DateTime date;
  final String text;
  @override
  State<VotePost> createState() => _VotePostState();
}

class _VotePostState extends State<VotePost> {
  bool selected = false;
  num total = 0;
  void setTotal() {
    total = 0;
    widget.votes.forEach(
      (element) {
        setState(() {
          total += element['quantity'];
        });
      },
    );
  }

  @override
  void initState() {
    setTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final account = Provider.of<Account>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.volName,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            DateFormat('hh:mm  dd/MM/yyyy').format(widget.date),
            style: TextStyle(color: Colors.grey[400]),
          ),
          Text(widget.text),
          ...widget.votes
              .map(
                (e) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              child: Container(
                                height: size.height * .06,
                                child: Center(
                                  child: Text(
                                    e['voteName'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: e['quantity'],
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                      color: Colors.green.withOpacity(.3),
                                    ),
                                    height: size.height * .06,
                                  ),
                                ),
                                Expanded(
                                  flex: (total - e['quantity'] as int),
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: GestureDetector(
                                child: IconButton(
                                  splashRadius: 1.0,
                                  iconSize: 16,
                                  icon: (e['selected'] != null &&
                                          (e['selected'] as List)
                                              .contains(account.id))
                                      ? Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.check_box_outline_blank,
                                          color: Colors.green,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      widget.votes.forEach((element) {
                                        if (element['selected'] &&
                                            element != e) {
                                          element['selected'] = false;
                                          element['quantity']--;

                                          print(total);
                                        }
                                      });
                                      e['selected'] = !e['selected'];
                                      if (e['selected'] == true)
                                        e['quantity']++;
                                      else
                                        e['quantity']--;
                                    });
                                    total = 0;
                                    widget.votes.forEach(
                                      (element) {
                                        setState(() {
                                          total += element['quantity'];
                                        });
                                      },
                                    );
                                    print(total);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ]),
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';


class InpatientDetails extends StatefulWidget {

  final String dataDetails;

  const InpatientDetails({Key key, this.dataDetails}) : super(key: key);

  @override
  _InpatientDetailsState createState() => _InpatientDetailsState();
}

class _InpatientDetailsState extends State<InpatientDetails> {

  _InpatientDetailsState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.dataDetails)
      ],
    );
  }
}
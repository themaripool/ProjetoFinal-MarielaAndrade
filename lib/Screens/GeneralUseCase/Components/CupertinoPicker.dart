import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoPickerView extends StatefulWidget {
  const CupertinoPickerView({Key key}) : super(key: key);

  @override
  _CupertinoPickerViewState createState() => _CupertinoPickerViewState();
}

class _CupertinoPickerViewState extends State<CupertinoPickerView> {
  var selectItem;
  double _kPickerSheetHeight = 216.0;
  int value = 0;


  final items=[
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _buildBody()
    );
  }

  Widget _buildBody() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 30,right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                showCupertinoModalPopup<void>(
                    context: context, builder: (BuildContext context){
                  return _buildBottomPicker(
                      buildCupertinoPicker()
                  );
                });
              },
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width:MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.pinkAccent
                    ),
                    child: Center(
                      child: Text("Cupertino Picker",
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    ),
                  ),
                 // SizedBox(height: 30,),

                  Container(
                    padding: EdgeInsets.only(top: 8,bottom: 8),
                    child: Text(selectItem!=null?selectItem:'No Item Chosen',
                      style: TextStyle(
                          color: Colors.black,

                      ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




 Widget buildCupertinoPicker(){
    return Container(
      child: CupertinoPicker(
        magnification: 1.5,
        backgroundColor: Colors.white,
        itemExtent: 50, //height of each item
        looping: true,
        children: items.map((item)=> Center(
          child: Text(item,
          style: TextStyle(fontSize: 32),),
        )).toList(),
        onSelectedItemChanged: (index) {
          setState(() => this.value = index);
          selectItem= items[index];
          print("Selected Iem: $index");
          // setState(() {
          //   selectItem=value.toString();
          // });
        },
      ),
    );

  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
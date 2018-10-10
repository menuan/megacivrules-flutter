import 'package:flutter/material.dart';

class CheckboxView extends StatefulWidget {
  CheckboxView({Key key, this.item}) : super(key: key);
  CheckBoxItem item;
  @override
  _CheckboxViewState createState() => new _CheckboxViewState(item: this.item);
}

class _CheckboxViewState extends State<CheckboxView> {
  _CheckboxViewState({this.item});
  CheckBoxItem item;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: item.value,
          onChanged: (val) {
            setState(() {
              item.value = !item.value;
              item.onChange(item.key, item.value);
            });
          },
        ),
        Text(item.title)
      ],
    );
  }
}

typedef void CheckBoxItemCallback<T>(T key, bool val);

class CheckBoxItem<T> {
  CheckBoxItem({this.title, this.value, this.onChange, this.key});
  CheckBoxItemCallback<T> onChange;
  T key;
  String title;
  bool value;
}

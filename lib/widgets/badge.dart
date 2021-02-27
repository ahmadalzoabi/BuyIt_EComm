import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return value != 0.toString()
        ? Stack(
            alignment: Alignment.center,
            children: [
              child,
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(3.0),
                  // color: Theme.of(context).accentColor,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color:
                        color != null ? color : Theme.of(context).accentColor,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
            ],
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              child,
            ],
          );
  }
}

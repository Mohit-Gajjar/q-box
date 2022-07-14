import 'package:flutter/material.dart';

class Dpp extends StatelessWidget {
  const Dpp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dpp',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 5,
          shadowColor: Colors.yellowAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Table(
            defaultColumnWidth:
                FixedColumnWidth((MediaQuery.of(context).size.width) * 0.33),
            border: TableBorder.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1.5,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            children: const [
              TableRow(
                children: [
                  PaddingCellHeader(txt: 'Name'),
                  PaddingCellHeader(txt: 'Questions Attempted'),
                  PaddingCellHeader(txt: 'Rank')
                ],
              ),
              TableRow(
                children: [
                  PaddingCellChildren(txt: 'Indrajit Sikder'),
                  PaddingCellChildren(txt: '95'),
                  PaddingCellChildren(txt: 'Diamomnd Icon'),
                ],
              ),
              TableRow(
                children: [
                  PaddingCellChildren(txt: 'Ayan Nandi'),
                  PaddingCellChildren(txt: '95'),
                  PaddingCellChildren(txt: 'Silver Icon'),
                ],
              ),
              TableRow(
                children: [
                  PaddingCellChildren(txt: 'Ayan Mondal'),
                  PaddingCellChildren(txt: '75'),
                  PaddingCellChildren(txt: 'Bronze Icon'),
                ],
              ),
              TableRow(
                children: [
                  PaddingCellChildren(txt: 'Arijit Nandi'),
                  PaddingCellChildren(txt: '68'),
                  PaddingCellChildren(txt: 'BronzeIcon'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaddingCellHeader extends StatelessWidget {
  const PaddingCellHeader({Key? key, required this.txt}) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: FittedBox(
            child: Text(
              txt,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PaddingCellChildren extends StatelessWidget {
  const PaddingCellChildren({Key? key, required this.txt}) : super(key: key);

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: FittedBox(
              child: Text(
                txt,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

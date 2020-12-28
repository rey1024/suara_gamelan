import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:suara_gamelan/DetectSound.dart';

class MenuGamelan extends StatefulWidget {
  @override
  _MenuGamelanState createState() => _MenuGamelanState();
}

class _MenuGamelanState extends State<MenuGamelan> {
  String _valJenis;
  List _listJenis =["Ugal Pengumbang", "Ugal Pangisep",
    "Gangsa Pengumbang", "Gangsa Pangisep",
    "Kantil Pangumbang", "Kantil Pangisep",
  "Penyacah Pangumbang", "Penyacah Pangisep",
  "Jublag Pangumbang", "Jublag Pangisep",
  "Jegog Pangumbang", "Jegog Pangisep" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.music_note,
          color: Colors.white
        ),
        title: Text('Nada Gamelan Bali'),

      ),
      body : Column(
        children: <Widget>[
          Container(
            child:
            Image.asset('images/gamelan.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text("Silakan Pilih Jenis Instrumen",
            style: TextStyle(
              fontSize: 20
            ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: DropdownButton(
              style: TextStyle(
                fontSize: 25,
              ),
              hint: Text("Pilih Jenis Gamelan"),
              value: _valJenis,
              items: _listJenis.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  _valJenis=value;
                });
              },
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 70,
            child: RaisedButton(
              onPressed: () {
                Navigator.push (
                  context,
                  MaterialPageRoute(builder: (context) => DetectSound(jenis : _valJenis)),
                );
              },
              color: Colors.black,
              child: Text(
                'Deteksi Nada',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        //color: Colors.transparent,
        child: Container(
          height: 60,
          color: Colors.black54,
          alignment: Alignment.center,
          child: Text(
            'Universitas Pendidikan Ganesha',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
        //elevation: 0,
      ),
    );

  }
}
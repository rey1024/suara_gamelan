import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';

class DetectSound extends StatefulWidget {
  DetectSound({@required this.jenis});
  final String jenis;

  @override
  _DetectSound createState() => _DetectSound(jenis);
}

class _DetectSound extends State<DetectSound> {
  String jenis;
  _DetectSound(this.jenis);
  double frequency;
  String note;
  bool isRecording;
  bool isMatch = false;



  final List<String> nada = <String>['dong', 'deng', 'dung', 'dang', 'ding', 'dong!', 'deng!', 'dung!', 'dang!', 'ding!'];
  final List<double> fdisbud = <double>[
    162.11,
    165.53,
    176.76,
    246.16,
    256.84,
    324.22,
    331.54,
    415.04,
    421.88,
    576.17];

  final List<double> fbllng = <double>[
    150,
    160.64,
    170.41,
    175.78,
    125.73,
    254.39,
    322.75,
    407.23,
    411.62,
    500.98
  ];
  FlutterFft flutterFft = new FlutterFft();

  @override
  void initState() {
    /*
    isRecording = false;
    frequency = 200;
    note = 'D';
    super.initState();
    */

   isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    super.initState();
    _async();

  }

  @override
  void dispose(){
    flutterFft.stopRecorder();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(
              Icons.music_note,
              color: Colors.white
          ),
          title: Text('$jenis'),

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 500,
                  padding: EdgeInsets.all(20),
                  child: Row(

                    children: [
                      Column(
                        children: [
                          Container(
                            child: Text("Disbud Kota Denpasar"),
                          ),
                          Container(
                            height: 400,
                            width: 160,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: nada.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index!=0 && index!=nada.length-1){
                                    var bawah = (fdisbud[index-1] + fdisbud[index]) / 2 ;
                                    var atas = (fdisbud[index+1] + fdisbud[index]) /2 ;
                                    if (frequency>=(bawah) && frequency<=(atas)) {
                                      isMatch=true;
                                    } else {
                                      isMatch=false;
                                    }
                                  } else if(index==0){
                                    var bawah = fdisbud[index] - 100 ;
                                    var atas = (fdisbud[index+1] + fdisbud[index]) /2 ;
                                    if (frequency>=(bawah) && frequency<=(atas)) {
                                      isMatch=true;
                                    } else {
                                      isMatch=false;
                                    }
                                  } else if (index==fdisbud.length-1) {
                                    var bawah = (fdisbud[index-1] + fdisbud[index]) / 2 ;
                                    var atas =  fdisbud[index] + 100 ;
                                    if (frequency>=(bawah) && frequency<=(atas)) {
                                      isMatch=true;
                                    } else {
                                      isMatch=false;
                                    }
                                  }

                                  return Container(
                                    margin: const EdgeInsets.all(2),
                                    height: 30,
                                    color: isMatch?Colors.deepOrange:Colors.brown,
                                    child: Center(child: Text('Bilah ${index+1} ${nada[index]} ${fdisbud[index]}  ')),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text("Sanggar DM Buleleng"),
                          ),
                          Container(
                            height: 400,
                            width: 160,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: nada.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index!=0 && index!=nada.length-1){
                                    var bawah = (fbllng[index-1] + fbllng[index]) / 2 ;
                                    var atas = (fbllng[index+1] + fbllng[index]) /2 ;
                                    if (frequency>=(bawah) && frequency<=(atas)) {
                                      isMatch=true;
                                    } else {
                                      isMatch=false;
                                    }
                                  } else if(index==0){
                                    var bawah = fbllng[index] - 100 ;
                                    var atas = (fbllng[index+1] + fbllng[index]) /2 ;
                                    if (frequency>=(bawah) && frequency<=(atas)) {
                                      isMatch=true;
                                    } else {
                                      isMatch=false;
                                    }
                                  } else if (index==fbllng.length-1) {
                                    var bawah = (fbllng[index-1] + fbllng[index]) / 2 ;
                                    var atas =  fbllng[index] + 100 ;
                                    if (frequency>=(bawah) && frequency<=(atas)) {
                                      isMatch=true;
                                    } else {
                                      isMatch=false;
                                    }
                                  }

                                  return Container(
                                    margin: const EdgeInsets.all(2),
                                    height: 30,
                                    color: isMatch?Colors.deepOrange:Colors.blueGrey,
                                    child: Center(child: Text('Bilah ${index+1} ${nada[index]} ${fbllng[index]}  ')),
                                  );
                                }
                            ),
                          ),
                        ],
                      )
                    ],
                  )


              ),

              isRecording
                  ? Text(
                "Nada  $note",
                style: TextStyle(
                  fontSize: 25,
                ),
              )
                  : Text(
                "None yet",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              isRecording
                  ? Text(
                "Frekwensi (KHz): ${frequency.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 25,
                ),
              )
                  : Text(
                "None yet",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        )

    );
  }

  _async() async {
    print("starting...");
    flutterFft.setSubscriptionDuration = 0.1;
    await flutterFft.startRecorder();
    setState(() => isRecording = flutterFft.getIsRecording);
    flutterFft.onRecorderStateChanged.listen(
          (data) => {
        setState(
              () => {
            frequency = data[1],
            note = data[2],
          },
        ),
        flutterFft.setNote = note,
        flutterFft.setFrequency = frequency,
      },
    );
  }
}







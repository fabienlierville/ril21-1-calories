import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  bool genre = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Calcul de calories"),
          backgroundColor: getColor(),
        ),
        body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextAvecStyle("Remplissez tous les champs pour obtenir votre besoin journalier en calories"),
              Card(
                elevation: 10,
                child: Column(
                  children: [
                    //Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextAvecStyle("Femme", color: Colors.pink),
                        Switch(
                          inactiveTrackColor: Colors.pink,
                            activeColor: Colors.blue,
                            value: genre,
                            onChanged: (bool b){
                              setState(() {
                                genre = b;
                              });
                            }
                        ),
                        TextAvecStyle("Homme", color: Colors.blue),
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: null,
                  child: TextAvecStyle("Calculer", color: Colors.white),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(getColor())
                ),
              )
            ],
          ),
        ) ,
      ),
    );
  }



  Text TextAvecStyle(String data, {color: Colors.black, fontSize: 15.0}){
    return Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color,
          fontSize: fontSize
      ),
    );
  }

  Color getColor(){
    //Genre est à true alors homme sinon femme
    if(genre) {
      return Colors.blue;
    }else{
      return  Colors.pink;
    }
  }

}

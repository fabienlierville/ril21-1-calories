import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  bool genre = false;
  int? age;
  int taille = 100;
  int? poids;
  int? activiteSportive;
  int? calorieBase;
  int? calorieAvecActivite;

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
              Container(
                child:  TextAvecStyle("Remplissez tous les champs pour obtenir votre besoin journalier en calories"),
              ),
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
                    ),
                    //Age
                    ElevatedButton(
                        onPressed: (){
                          selectionDate();
                        },
                        child: TextAvecStyle((age==null) ?"Cliquer pour votre age " : "Age = ${age}ans", color: Colors.white),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(getColor())
                      ),
                    ),
                    //Taille
                    TextAvecStyle("Votre taille est de ${taille} cm", color: getColor()),
                    Slider(
                      min: 100,
                      max: 250,
                      activeColor: getColor(),
                      value: taille.toDouble(),
                      onChanged: (double d){
                        setState(() {
                          taille = d.toInt();
                        });
                      },
                    ),
                    // Poids
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String value){
                        setState(() {
                          poids = int.tryParse(value);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Entrez votre poids en Kilos."
                      ),
                    ),
                    TextAvecStyle("Quelle est votre activité sportive ?", color: getColor()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Radio(
                                value: 0,
                                activeColor: getColor(),
                                groupValue: activiteSportive,
                                onChanged: (int? value){
                                  setState(() {
                                    activiteSportive = value;
                                  });
                                }
                            ),
                            TextAvecStyle("Faible"),
                          ],
                        ),
                        Column(
                          children: [
                            Radio(
                                value: 1,
                                activeColor: getColor(),
                                groupValue: activiteSportive,
                                onChanged: (int? value){
                                  setState(() {
                                    activiteSportive = value;
                                  });
                                }
                            ),
                            TextAvecStyle("Moyen"),
                          ],
                        ),
                        Column(
                          children: [
                            Radio(
                                value: 2,
                                activeColor: getColor(),
                                groupValue: activiteSportive,
                                onChanged: (int? value){
                                  setState(() {
                                    activiteSportive = value;
                                  });
                                }
                            ),
                            TextAvecStyle("Fort"),
                          ],
                        ),
                      ],
                    )

                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: calculerNombreDeCalories,
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

  Future<void> selectionDate() async{
    DateTime? datechoisie = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if(datechoisie != null){
      Duration difference = DateTime.now().difference(datechoisie);
      int jours = difference.inDays;
      double ans = (jours / 365);
      setState(() {
        age = ans.toInt();
      });

    }
  }

  void calculerNombreDeCalories(){
    //Vérification des champs
    if(age != null && poids != null && activiteSportive != null && taille != null){
      if(genre){
        calorieBase = (66.4730 + (13.7516 * poids!) + (5.0033 * taille) - (6.7550 * age!)).toInt();
      }else{
        calorieBase = (655.0955 + (9.5634 * poids!) + (1.8496 * taille) - (4.6756 * age!)).toInt();
      }
      switch(activiteSportive){
        case 0:
          calorieAvecActivite = (calorieBase! * 1.2).toInt();
          break;
        case 1:
          calorieAvecActivite = (calorieBase! * 1.5).toInt();
          break;
        case 2:
          calorieAvecActivite = (calorieBase! * 1.8).toInt();
          break;
        default:
          calorieAvecActivite = calorieBase;
          break;
      }
      dialogue();
    }else{
      //Alerte erreur
      alerte();
    }
  }


  Future<void> dialogue() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext contextDialog) {
          return SimpleDialog(
            title: TextAvecStyle("Votre besoin en calories", color: getColor()),
            contentPadding: EdgeInsets.all(5.0),
            children: [
              TextAvecStyle("De base : ${calorieBase!}"),
              TextAvecStyle("Avec Sport : ${calorieAvecActivite!}"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(contextDialog);
                },
                child: TextAvecStyle("Ok", color: Colors.white),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        getColor())
                ),
              ),
            ],
          );
        }
    );
  }

  Future<void> alerte() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext contextDialog){
          return AlertDialog(
            title: Text("Erreur", textScaleFactor: 2,),
            content: Text("Tous les champs de sont pas remplis"),
            contentPadding: EdgeInsets.all(5.0),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(contextDialog);
                  },
                  child: Text("Ok", style: TextStyle(color: Colors.red),)
              ),
            ],
          );
        }
    );
  }
}

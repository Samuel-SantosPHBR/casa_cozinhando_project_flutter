import 'dart:convert';

import '../detalhes/detalhes.dart';
import 'package:flutter/material.dart';
import '../../modelos/receita.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return new HomeState();
  }

}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return _construirHome();
  }

  Widget _construirHome(){
    return Scaffold(
      body: _construirListaCard(),
      floatingActionButton: _construirBotaoFiltrar(),
      appBar: _construirAppBar(),
    );
  }

  Widget _construirBotaoFiltrar(){
    return FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Você está fazendo uma pesquisa'),
            content: const Text('Esse é o conteudo de sua pesquisa.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancelar'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      child: Icon(Icons.search_rounded),
      backgroundColor: Colors.deepOrange,
    );
  }

  Widget _construirListaCard()
  {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/receitas.json'),
        builder: (context,snapshot){
          List<dynamic> receitas = json.decode(snapshot.data.toString());

          return ListView.builder(
              itemBuilder: (BuildContext context, int index){
                Receita receita = Receita.fromJson(receitas[index]);
                return _construirCard(receita);
              },
              itemCount: receitas == null ? 0 : receitas.length,
          );
        },
    );
  }

  PreferredSizeWidget _construirAppBar()
  {
    return AppBar(title: Center(child: Text("Minhas Receitas")));
  }

  Widget _construirCard(receita){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>Detalhes(receita: receita)
        ));
      },
        child: SizedBox(
          height: 150,
          child:Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              child: Column(
                children: [
                  Stack(
                    children: [
                      _construirImagem(receita.foto),
                      _construirGradienteCard(),
                      _construirTextoCard(receita.titulo),
                    ],
                  )
                ],
              )
          ),
        ),
    );
  }

  Widget _construirGradienteCard(){
    return Container(
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.red.withOpacity(0.7)
          ]
        )
      ),
    );
  }

  Widget _construirTextoCard(titulo){
    return Positioned(
        bottom: 10,
        left: 10,
        child: Text(titulo,style: TextStyle(fontSize: 25,color: Colors.white))
    );
  }

  Widget _construirImagem(foto){
    return Image.asset(foto,fit: BoxFit.fill,height: 130,width: 410);
  }
}
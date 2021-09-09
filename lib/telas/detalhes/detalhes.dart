import 'package:flutter/material.dart';
import '../../modelos/receita.dart';

class Detalhes extends StatelessWidget{

  final Receita receita;

  Detalhes({
    Key? key,
    required this.receita
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return _construirDetalhes();
  }

  Widget _construirDetalhes(){
    return Scaffold(
      body: ListView(
        children: <Widget>[
            _contruirImagemDetalhes(receita.foto),
            _construirTituloDetalhes(receita.titulo),
          _construirLinhasIconesDetalhe('${receita.porcoes} porçoes',receita.tempoPreparo),
          _construirSubtituloDetalhes("Ingredientes"),
          _construirTextoDetalhes(receita.ingredientes),
          _construirSubtituloDetalhes("Modo de Preparo"),
          _construirTextoDetalhes(receita.modoPreparo)
        ],
      ),
      appBar: _construirAppBar()
    );
  }

  Widget _construirGradienteImage(){
    return Container(
      height: 230,
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

  Widget _contruirImagemDetalhes(image){
    return Container(child: Image.asset(image));
  }

  Widget _construirTituloDetalhes(titulo){
    return Center(
        child: Text(titulo,style: TextStyle(
            color: Colors.red, fontSize: 30
        ))
    );
  }

  Widget _construirLinhasIconesDetalhe(rendimento,tempo_preparo){
    return Row(
      children: <Widget>[
        _construirColunaIconesDetalhes(Icons.restaurant, rendimento),
        _construirColunaIconesDetalhes(Icons.timer, tempo_preparo),
        _construirColunaIconesDetalhes(Icons.add_circle_outline_sharp, "Favoritar")
      ],
    );
  }

  Widget _construirColunaIconesDetalhes(icon, text){
    return Expanded(
        child: Column(
        children: <Widget>[
          Icon(icon, color: Colors.deepOrange),
          Text(text, style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
        ],
      )
    );
  }

  Widget _construirSubtituloDetalhes(subtitulo){
    return Center(
        child: Text(subtitulo,style: TextStyle(fontSize: 20),)
    );
  }

  Widget _construirTextoDetalhes(texto){
    return Container(child: Text(texto, style: TextStyle(fontSize: 15),),padding: EdgeInsets.all(16),);
  }

  PreferredSizeWidget _construirAppBar()
  {
    return AppBar(title:Text("Receita Especifica"));
  }

}
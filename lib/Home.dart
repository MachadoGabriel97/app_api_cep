import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController controllerTextCep = TextEditingController();
  Map<String,dynamic> retorno = {};

  void _recuperarCep() async {
    String cep = controllerTextCep.text.toString();
    String url = "https://viacep.com.br/ws/${cep}/json/";
    //print(url);
    http.Response response;
    response = await http.get(Uri.parse(url));
    //print(response.body.toString());
    //print(response.statusCode.toString());
    Map<String,dynamic> retornoJson = json.decode(response.body);

    setState(() {
      retorno = retornoJson ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Consumo de serviço web Api Cep',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.blue[300],
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset("imagens/icone.jpg"),
                TextFormField(
                  controller: controllerTextCep,
                  decoration: const InputDecoration(
                    label: Text("Informe o cep"),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: _recuperarCep,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                ),
                child: const Text(
                  "Recuperar Cep",
                  style: TextStyle(color: Colors.white),
                ),),

            retorno.isEmpty    ? const Text(""):
            Expanded(
              child: ListView(
                children: retorno.entries.map((dados) {
                  return ListTile(
                    title: capitalizaTexto(dados.key),
                    subtitle: Text(dados.value),
                  );
                }).toList(), // Converte o Iterable em uma lista de widgets
              ),
            )
          ],
        ),
      ),
    );
  }

 Text capitalizaTexto(String dados) {
    return  Text(dados[0].toUpperCase()+dados.substring(1).toLowerCase());
 }


}

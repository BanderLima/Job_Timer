import 'package:flutter/material.dart';

class ProjectTaskTile extends StatelessWidget {
  const ProjectTaskTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Row(
        // quer dizer linha.
        //esse main é a direção dela.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'nome da Task',
          ),
          // isso que faz com que consiga agrupar varios elementos dentro de um mesmo lugar, nesse caso, os textos dentro do componente .
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: 'Duração', style: TextStyle(color: Colors.grey)),
                TextSpan(text: '     '),
                TextSpan(
                    text: '4h',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

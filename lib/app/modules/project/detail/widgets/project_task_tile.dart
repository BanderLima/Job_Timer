import 'package:flutter/material.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

class ProjectTaskTile extends StatelessWidget {
  final ProjectTaskModel task;

  const ProjectTaskTile({super.key, required this.task});

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
          Text(
            task.name,
          ),
          // isso que faz com que consiga agrupar varios elementos dentro de um mesmo lugar, nesse caso, os textos dentro do componente .
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                    text: 'Duração', style: TextStyle(color: Colors.grey)),
                const TextSpan(text: '     '),
                TextSpan(
                    text: '${task.duration}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

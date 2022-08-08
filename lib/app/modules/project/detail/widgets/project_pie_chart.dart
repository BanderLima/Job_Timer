import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectPieChart extends StatelessWidget {
  final int projectEstimate;
  final int totalTasks;

  const ProjectPieChart(
      {Key? key, required this.projectEstimate, required this.totalTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //variavel criada para alterar a cor.
    final residual = (projectEstimate - totalTasks);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.loose, //minimo de espaço possível.
        children: [
          PieChart(//gráfico de pizza
              PieChartData(sections: [
            //sao os valores do gráfico
            PieChartSectionData(
              value: totalTasks.toDouble(),
              color: theme.primaryColor,
              showTitle: true,
              title: '${totalTasks}h',
              titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight
                      .bold), //aqui eu to mandando ele apresentar o título
            ),
            PieChartSectionData(
              value: residual.toDouble(),
              color: theme.primaryColorLight,
              showTitle: true,
              title: '${residual}h',
              titleStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ])),
          Align(
            //alinhando no centro do componente.
            alignment: Alignment.center,
            child: Text(
              '${projectEstimate}h',
              style: TextStyle(
                  fontSize: 25,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ), //stack é a sobreposição de elementos.
    );
  }
}

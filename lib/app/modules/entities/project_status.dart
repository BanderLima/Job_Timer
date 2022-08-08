// criado enum para indicar na tela essas mensagens.

enum ProjectStatus {
  em_andamento(label: 'Em andamento'),
  finalizado(label: 'Finalizado');

  final String label;

  const ProjectStatus({required this.label});
}

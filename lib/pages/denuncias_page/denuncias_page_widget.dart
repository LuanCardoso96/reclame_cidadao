import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DenunciasPageWidget extends StatefulWidget {
  const DenunciasPageWidget({Key? key}) : super(key: key);

  static String routeName = 'DenunciasPage';
  static String routePath = '/denuncias';

  @override
  State<DenunciasPageWidget> createState() => _DenunciasPageWidgetState();
}

class _DenunciasPageWidgetState extends State<DenunciasPageWidget> {
  List<Map<String, dynamic>> denuncias = [
    {
      'id': '1',
      'titulo': 'Buraco na rua',
      'descricao': 'Buraco grande na rua principal',
      'localizacao': 'Rua das Flores, 123',
      'status': 'Em análise',
      'data': '15/01/2024',
      'categoria': 'Infraestrutura',
    },
    {
      'id': '2',
      'titulo': 'Lixo acumulado',
      'descricao': 'Lixo não coletado há 3 dias',
      'localizacao': 'Avenida Central, 456',
      'status': 'Resolvido',
      'data': '10/01/2024',
      'categoria': 'Limpeza',
    },
    {
      'id': '3',
      'titulo': 'Poste quebrado',
      'descricao': 'Poste de luz quebrado',
      'localizacao': 'Rua do Comércio, 789',
      'status': 'Em andamento',
      'data': '12/01/2024',
      'categoria': 'Iluminação',
    },
  ];

  String filtroStatus = 'Todos';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> denunciasFiltradas = denuncias.where((denuncia) {
      if (filtroStatus == 'Todos') return true;
      return denuncia['status'] == filtroStatus;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Minhas Denúncias',
          style: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Text('Filtrar por: ',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: filtroStatus,
                  items: ['Todos', 'Em análise', 'Em andamento', 'Resolvido']
                      .map((status) =>
                          DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      filtroStatus = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          // Lista de denúncias
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: denunciasFiltradas.length,
              itemBuilder: (context, index) {
                final denuncia = denunciasFiltradas[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getStatusColor(denuncia['status']),
                      child: Icon(Icons.report, color: Colors.white),
                    ),
                    title: Text(
                      denuncia['titulo'],
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(denuncia['descricao']),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            SizedBox(width: 4),
                            Text(denuncia['localizacao'],
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(denuncia['status']),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                denuncia['status'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(denuncia['data'],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Abrir detalhes da denúncia
                      _showDenunciaDetails(context, denuncia);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNovaDenunciaDialog(context);
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Em análise':
        return Colors.orange;
      case 'Em andamento':
        return Colors.blue;
      case 'Resolvido':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showDenunciaDetails(
      BuildContext context, Map<String, dynamic> denuncia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(denuncia['titulo']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descrição: ${denuncia['descricao']}'),
            SizedBox(height: 8),
            Text('Localização: ${denuncia['localizacao']}'),
            SizedBox(height: 8),
            Text('Categoria: ${denuncia['categoria']}'),
            SizedBox(height: 8),
            Text('Status: ${denuncia['status']}'),
            SizedBox(height: 8),
            Text('Data: ${denuncia['data']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showNovaDenunciaDialog(BuildContext context) {
    final tituloController = TextEditingController();
    final descricaoController = TextEditingController();
    final localizacaoController = TextEditingController();
    String categoriaSelecionada = 'Infraestrutura';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Nova Denúncia'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              SizedBox(height: 8),
              TextField(
                controller: localizacaoController,
                decoration: InputDecoration(labelText: 'Localização'),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: categoriaSelecionada,
                decoration: InputDecoration(labelText: 'Categoria'),
                items: [
                  'Infraestrutura',
                  'Limpeza',
                  'Iluminação',
                  'Segurança',
                  'Outros'
                ]
                    .map((categoria) => DropdownMenuItem(
                        value: categoria, child: Text(categoria)))
                    .toList(),
                onChanged: (value) {
                  categoriaSelecionada = value!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (tituloController.text.isNotEmpty &&
                  descricaoController.text.isNotEmpty) {
                setState(() {
                  denuncias.add({
                    'id': (denuncias.length + 1).toString(),
                    'titulo': tituloController.text,
                    'descricao': descricaoController.text,
                    'localizacao': localizacaoController.text,
                    'status': 'Em análise',
                    'data': DateTime.now().toString().split(' ')[0],
                    'categoria': categoriaSelecionada,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}

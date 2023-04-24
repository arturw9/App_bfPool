class Produto {
  final String? id;
  final String nome;
  final String imagem;
  final String valor;
  final String quantidade;

  Produto(
      {required this.id,
      required this.nome,
      required this.imagem,
      required this.valor,
      required this.quantidade});

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      nome: json['nome'],
      imagem: json['imagem'],
      valor: json['valor'],
      quantidade: json['quantidade'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    data['valor'] = this.valor;
    data['quantidade'] = this.quantidade;
    data['id'] = this.id;
    return data;
  }
}

class Produto {
  final String nome;
  final String imagem;
  final String valor;
  final String quantidade;

  Produto(
      {required this.nome,
      required this.imagem,
      required this.valor,
      required this.quantidade});

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      nome: json['nome'],
      imagem: json['imagem'],
      valor: json['valor'],
      quantidade: json['quantidade'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    data['valor'] = this.valor;
    data['quantidade'] = this.quantidade;
    return data;
  }
}

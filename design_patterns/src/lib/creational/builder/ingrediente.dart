abstract class Ingrediente {
  String get nome;
  double get preco;
}

class Salsicha extends Ingrediente {
  @override
  String get nome => 'Salsicha';

  @override
  double get preco => 3.0;
}

class Pao extends Ingrediente {
  @override
  String get nome => 'Pão';

  @override
  double get preco => 2.0;
}

class Queijo extends Ingrediente {
  @override
  String get nome => 'Queijo';

  @override
  double get preco => 1.0;
}

class Carne extends Ingrediente {
  @override
  String get nome => 'Carne';

  @override
  double get preco => 4.0;
}

class Alface extends Ingrediente {
  @override
  String get nome => 'Alface';

  @override
  double get preco => 1.0;
}

class Tomate extends Ingrediente {
  @override
  String get nome => 'Tomate';

  @override
  double get preco => 2.0;
}

class Mostarda extends Ingrediente {
  @override
  String get nome => 'Mostarda';

  @override
  double get preco => 0.5;
}

class Catchup extends Ingrediente {
  @override
  String get nome => 'Catchup';

  @override
  double get preco => 0.5;
}

class Ovo extends Ingrediente {
  @override
  String get nome => 'Ovo';

  @override
  double get preco => 3.0;
}

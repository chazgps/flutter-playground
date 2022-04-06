abstract class ICPU {
  String get nome;
  String get velocidade;
  String get nucleos;
}

class CPUI3 extends ICPU {
  @override
  String get nome => 'Intel Core i3';

  @override
  String get velocidade => '1.8 GHz';

  @override
  String get nucleos => '2 núcleos';
}

class CPUI5 extends ICPU {
  @override
  String get nome => 'Intel Core i5';

  @override
  String get velocidade => '2.5 GHz';

  @override
  String get nucleos => '4 núcleos';
}

class CPUI7 extends ICPU {
  @override
  String get nome => 'Intel Core i7';

  @override
  String get velocidade => '3.7 GHz';
  
  @override
  String get nucleos => '8 núcleos';
}

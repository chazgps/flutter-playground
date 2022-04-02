Sobre o app
====================

Estudo sobre design patterns em Dart.

A idéia é ilustrar design patterns na linguagem Dart.

A aplicação exemplo foi codificada como um projeto projeto Dart CLI (command-line interface), onde
através da linha de comando pode ser passado valores indicando quais padrões se quer que sejam
demonstrados.

Exemplo:
    - bin\cli.exe singleton

Irá executar o exemplo demonstrando o padrão Singleton.

Padrões de criação (Creational Patterns)
========================================

- **Singleton** - Garante a existência de apenas uma instância de uma classe não importa a quantidade de vezes que se tente instânciar um novo objeto. 

- **Factory** - Define uma interface para criar um objeto mas é uma das subclasses que decidirá qual classe instanciar um objeto.

- **Builder** - Separa a construção de um objeto complexo em partes menores, simplificando este processo e permitindo a customização do objeto a ser instânciado.
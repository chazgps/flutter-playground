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
### **Singleton**
Garante a existência de apenas uma instância de uma classe não importa a quantidade de vezes que se tente instânciar um novo objeto.

Como exemplo, criei uma classe AppSettings que implementa o padrão Singleton para armazenar as configurações da aplicação. Devido a sua natureza, não desejamos que a classe possa ser instanciada mais de uma vez.

---
### **Factory**

Define uma interface para criar um objeto mas é uma das subclasses que decidirá qual classe instanciar um objeto.

No exemplo, criei uma Factory para retornar um objeto que calcula um hash a partir de uma string, a partir do tipo de função de hashing que for solicitada a fábrica retornar.

---
### **Builder**

Separa a construção de um objeto complexo em partes menores, permitindo a customização do objeto a ser instânciado.

No exemplo, trabalho com o exemplo de um trailer de lanche.
A pessoa que irá montar o lanche (Montador), recebe o pedido do cliente de qual lanche ela quer e ele deve seguir uma Receita para montar o lanche conforme o tipo.
Para este tipo de situação onde o lanche pode ser customizável, tendo um alguns ingrediente e em outros não, ou passos adicionais, o padrão Builder se encaixa perfeitamente para fazer a construção do (objeto) Lanche.
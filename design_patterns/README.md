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

---

### **Prototype**

Define a maneira pela qual obteremos uma cópia de um objeto de forma total ou parcial.
A implementação deste design pattern pode ser feita tanto por meio de uma interface que especifica a operação de clonagem (ex: clone()), como por meio de uma classe concreta.

Neste exemplo, existem as duas implementações:
- baseada em interface via método *clone()*: utilizada em algumas linguagens
- baseada em classe concreta via um método *copyWith()*: utilizada no Flutter como padrão para a clonagem de objetos.

Preferencialmente gosto da abordagem Flutter pois permite informar se algum atributo novo deve vir no objeto clonado, ao passo que na abordagem das outras linguagens, o objeto clonado é uma cópia idêntica e requer a declaração de uma interface e implementação desta.

No exemplo, a partir de 1 indivíduo (Adão), geramos uma população de mais 999 indivíduos via clonagem do objeto inicial (Adão).
A cada clonagem, um sorteio entre 3 características (idade, sexo e estado civil) é feito para randomizar a população em alguma destas 3 características.
Executando várias vezes, nota-se um certo padrão na distribuição da população por faixa etária. Saberia dizer porquê acontece ? :smiley:

---

### **Abstract Factory**

Define a maneira pela qual uma classe pode criar fábricas de objetos relacionados mas sem especificar suas implementações concretas.

Seria como ter vários objetos do padrão Factory controlados por um objeto master, mas o master não sabe qual implementação de factory seus filhos irão ter, ficará a critério de cada factory tomar esta decisão.

No exemplo, criei um Advisor (Vendedor) para recomendar a configuração de um computador para 3 perfis de usuários diferentes:

- Usuário básico: Só irá acessar a Internet e usar aplicações leves
- Usuário dev: Uso profissional e precisa de uma máquina potente ! Nas horas vagas gosta de usar para jogos.
- Usuário corporativo: Precisa ter um equilíbrio, não pode ser tão básica, mas não precisa ser potente, é para o usuário médio.

O vendedor delega a resposabilidade de escolher se é um desktop ou notebook, qual memória, CPU e armazenamento para as classes factory, conforme o perfil do usuário.
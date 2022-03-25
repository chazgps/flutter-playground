Uma breve introdução
====================

Implementação de um app estilo 'To-Do List'.

Foi criado de forma simples e para meu estudo da API Firebase Firestore.

Arquitetura
===========

Para não deixar o app dependente desta implementação, e permitir que uma outra API fosse usada de forma fácil posteriormente, criei uma interface ([TodoService](./src/lib/service/todo_service.dart)) e implementei as chamadas a API do Firebase implementando esta interface ([FirebaseTodoService ](./src/lib/service/firebase_todo_service.dart)).

Caso seja necessário trocar por uma outra forma de armazenamento (Ex: uma API própria), basta implementar a interface **TodoService** e fornecer ao widget [MyApp](./src/lib/my_app.dart) esta implementação para que seja usada pelas telas deste aplicativo.


Uma breve introdução
====================

Este repositório é uma implementação básica de autenticação de um usuário onde o foco foi ter a possibilidade de trocar a parte que antentica o usuário e trocar por uma outra de forma fácil.

Foi criado de forma simples e para meu estudo da API Firebase Authentication.

Arquitetura
===========

Para não deixar o app dependente desta implementação, e permitir que uma outra API fosse usada de forma fácil posteriormente, criei uma interface ([Autenticador](./src/lib/login/service/authenticator.dart)) e implementei as chamadas a API do Firebase implementando esta interface ([FirebaseAutenticador](./src/lib/login/service/firebase_autenticador.dart)).

Caso seja necessário trocar por uma outra forma de autenticação (Ex: uma API própria), basta implementar a interface **Autenticador** e fornecer ao widget [LoginPage](./src/lib/login/ui/pages/login_page.dart) esta implementação para que seja usada pelas telas deste aplicativo.

O contéudo principal da implementação está na pasta [login](./src/lib/login/). Esta é a pasta que pode ser copiada para outros projetos para reaproveitar esta implementação de autenticação.

Telas do app
============

|&nbsp;|&nbsp;|
|----|----|
|![Tela de login (Sign-up)](./screenshots/1-sign-in.png)| Tela de Login|
|![Tela de reset da senha](./screenshots/2-esqueci-a-senha.png)| Tela de reset da senha|
|![Tela de cadastro do usuário junto ao sistema](./screenshots/3-sign-up.png)| Tela de cadastro do usuário junto a aplicação|

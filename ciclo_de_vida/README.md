Sobre o app
====================

Estudo sobre ciclo de vida de um app Flutter, para monitorar quando o app é colocado
em 2o plano (background) e quando o usuário traz ele de volta para 1o plano (foreground).

Monitorar estes eventos do ciclo de vida de um app, tem várias utilidades como dealocação
de recursos, desligar uma animação ou vídeo sendo reproduzido para economizar bateria, etc.

Para adicionar este monitoramento a um StatelessWidget ou StatefulWidget:

1) Adicionar 
o mixin [LifeCycleMonitor](./src/lib/life_cycle_monitor_mixin.dart) a classe que extende de StatelessWidget ou StatefulWidget.

2) No construtor da classe chamar o método *initLifeCycleMonitor()*.
   
3) Sobrescrever os métodos *onPause* e *onResume* para receber as notificações de quando o app vai para 2o plano e volta para 1o plano.

4) Sobrescreva o método *onLoad* para receber notificação de quando a tela foi exibida pela 1a vez, ou seja, a 1a vez que o método *build()* da sua página foi chamada. Isto pode ser útil para situações onde você realizar algum trabalho mas quer ter a certeza que o usuário já tem um conteúdo sendo exibido na tela. Por exemplo, você pode querer chamar uma rotina para fazer a carga de dados a partir de uma API e deseja mais segurança de que a aplicação ficará mais fluída e o usuário vendo por exemplo um widget de progresso que você implementou em sua página.

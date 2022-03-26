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

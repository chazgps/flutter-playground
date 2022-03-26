Sobre o app
====================

Estudo sobre ciclo de vida de um app Flutter, para monitorar quando o app é colocado
em 2o plano (background) e quando o usuário traz ele de volta para 1o plano (foreground).

Monitorar estes eventos do ciclo de vida de um app, tem várias utilidades como dealocação
de recursos, desligar uma animação ou vídeo sendo reproduzido para economizar bateria, etc.

Para adicionar este monitoramento a StatelessWidget ou StatefulWidget, basta adicionar
o mixin [LifeCycleMonitor](./src/lib/src/life_cycle_monitor_mixin.dart) a classe e sobrescrever
os métodos *onPause* e *onResume*.

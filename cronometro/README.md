Sobre o app
====================

Estudo sobre reatividade com Flutter utilizando ValueNotifier para notificar a UI sobre mudanças acontecendo em
um objeto, que neste exemplo, é um cronometro regressivo.

Na 1a tela, quem vai observar as notificações do cronômetro é o widget ValueListenableBuilder.
Na 2a tela, quem vai observar é o widget AnimatedBuilder.

O cronômetro pode ser iniciado ou parado em qualquer uma das telas, que a outra se manterá consistente com
o estado do cronômetro.


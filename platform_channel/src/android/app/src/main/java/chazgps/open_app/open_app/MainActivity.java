package chazgps.open_app.open_app;

import android.content.Intent;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    final String CHANNEL = "acme.open_app/intent";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(_getMethodCallHandler());
    }

    private MethodChannel.MethodCallHandler _getMethodCallHandler() {
        return new MethodChannel.MethodCallHandler() {
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if (call.method.equals("openApp")) {
                    _trataMetodoOpenApp(call, result);
                } else {
                    result.notImplemented();
                }
            }
        };
    }

    private void _trataMetodoOpenApp(MethodCall call, @NonNull MethodChannel.Result result) {
        try {
            final String pacote = call.argument("pacote");

            final Intent intent = getPackageManager().getLaunchIntentForPackage(pacote);
            if (intent == null) {
                result.error("PACOTE_NAO_EXISTE", "Não existe um app com o pacote " + pacote, null);
            }

            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);

            result.success(1);
        } catch (Exception e) {
            result.error("ERRO_DESCONHECIDO", "Um erro desconhecido ocorreu", null);
        }
    }
}
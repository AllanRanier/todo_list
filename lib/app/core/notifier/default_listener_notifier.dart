// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list/app/core/notifier/default_changer_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangerNotifier changerNotifier;

  DefaultListenerNotifier({
    required this.changerNotifier,
  });

  void listener(
      {required BuildContext context,
      required SuccessvoidCallback succesCallback,
      ErrorvoidCallback? errorCallback}) {
    changerNotifier.addListener(() {
      if (changerNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changerNotifier.hasError) {
        if(errorCallback != null){
          errorCallback(changerNotifier, this);
        }
        Messages.of(context).showError(changerNotifier.error ?? 'Erro interno');
      } else if (changerNotifier.isSuccess) {
        succesCallback(changerNotifier, this);
      }
    });
  }

  void dispose() {
    changerNotifier.removeListener(() {});
  }
}

typedef SuccessvoidCallback = void Function(
    DefaultChangerNotifier notifier, DefaultListenerNotifier listenerNotifier);
typedef ErrorvoidCallback = void Function(
    DefaultChangerNotifier notifier, DefaultListenerNotifier listenerNotifier);

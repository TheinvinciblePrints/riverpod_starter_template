import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connection_checker.g.dart';

enum NetworkStatus { online, offline }

@Riverpod(keepAlive: true)  
ConnectionChecker connectionChecker(Ref ref) {
  return ConnectionCheckerImpl();
}

abstract class ConnectionChecker {
  Future<NetworkStatus> isConnected();
  Stream<InternetConnectionStatus> connectivityChanged();
  Future<NetworkStatus> getNetworkStatus(InternetConnectionStatus status);
}

class ConnectionCheckerImpl extends ConnectionChecker {
  @override
  Stream<InternetConnectionStatus> connectivityChanged() {
    return InternetConnectionChecker.instance.onStatusChange;
  }

  @override
  Future<NetworkStatus> getNetworkStatus(
    InternetConnectionStatus status,
  ) async {
    return status == InternetConnectionStatus.connected &&
            await InternetConnectionChecker.instance.hasConnection
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }

  @override
  Future<NetworkStatus> isConnected() async {
    return await InternetConnectionChecker.instance.hasConnection
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class Local3DAssetServer {
  HttpServer? _server;

  Uri? get origin {
    final server = _server;
    if (server == null) return null;
    return Uri.parse('http://127.0.0.1:${server.port}');
  }

  Future<Uri> start() async {
    if (_server != null) return origin!;

    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server!.listen(_handleRequest);
    return origin!;
  }

  Future<void> stop() async {
    await _server?.close(force: true);
    _server = null;
  }

  Future<void> _handleRequest(HttpRequest request) async {
    try {
      final path = request.uri.path == '/'
          ? '/character_viewer.html'
          : request.uri.path;
      final assetPath = _assetPathFor(path);

      if (assetPath == null) {
        request.response.statusCode = HttpStatus.notFound;
        request.response.write('Not found: $path');
        await request.response.close();
        return;
      }

      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();

      request.response.headers
        ..set(HttpHeaders.cacheControlHeader, 'no-store')
        ..set(HttpHeaders.accessControlAllowOriginHeader, '*')
        ..contentType = _contentTypeFor(path);

      request.response.add(bytes);
      await request.response.close();
    } catch (error) {
      request.response.statusCode = HttpStatus.internalServerError;
      request.response.write('Asset server error: $error');
      await request.response.close();
    }
  }

  String? _assetPathFor(String path) {
    if (path == '/character_viewer.html') {
      return 'assets/web/character_viewer.html';
    }

    if (path.startsWith('/models/') && !path.contains('..')) {
      return 'assets$path';
    }

    return null;
  }

  ContentType _contentTypeFor(String path) {
    if (path.endsWith('.html')) {
      return ContentType.html;
    }
    if (path.endsWith('.glb')) {
      return ContentType('model', 'gltf-binary');
    }
    return ContentType.binary;
  }
}

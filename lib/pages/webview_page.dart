import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gank_flutter_app/entry/gank.dart';
class WebviewPage extends StatefulWidget {

	Gank gank;

	WebviewPage(this.gank);

  @override
  WebviewPageState createState() {
    return new WebviewPageState();
  }
}

class WebviewPageState extends State<WebviewPage> {

	String url;

	final flutterWebviewPlugin = new FlutterWebviewPlugin();

	StreamSubscription _onDestroy;
	StreamSubscription<String> _onUrlChanged;
	StreamSubscription<WebViewStateChanged> _onStateChanged;
	StreamSubscription<WebViewHttpError> _onHttpError;
	StreamSubscription<double> _onScrollYChanged;
	StreamSubscription<double> _onScrollXChanged;

	final _urlCtrl = new TextEditingController(text: "");
	final _codeCtrl = new TextEditingController(text: 'window.navigator.userAgent');
	final _scaffoldKey = new GlobalKey<ScaffoldState>();

	final _history = [];

	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebviewPlugin.close();
	_urlCtrl.addListener(() => url = _urlCtrl.text);
	_onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
		if (mounted) {
			print('onDestroy\t$url');
		}
	});
	_onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
		if (mounted) {
			this.url = url;
			print('onUrlChanged\t$url');
		}
	});
	_onScrollYChanged = flutterWebviewPlugin.onScrollYChanged.listen((double y) {
		if (mounted) {
			print('onScrollYChanged\t$y');
		}
	});
	_onScrollXChanged = flutterWebviewPlugin.onScrollXChanged.listen((double x) {
		if (mounted) {
			print('onScrollXChanged\t$x');
		}
	});
	_onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
		if (mounted) {
			print('onStateChanged: ${state.type}\t${state.url}');
		}
	});
	_onHttpError = flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {
		if (mounted) {
			print('onHttpError: ${error.code}\t${error.url}');
		}
	});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onHttpError.cancel();
    _onStateChanged.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      appBar: new AppBar(
        title: new Text(widget.gank.desc),
      ),
	    withJavascript: true,
	    url: widget.gank.url,
	    withZoom: true,
	    withLocalStorage: true,
	    withLocalUrl: true,
    );
  }
}
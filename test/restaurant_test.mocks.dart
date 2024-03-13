import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class FakeResponse extends SmartFake implements Response {
  FakeResponse(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class FakeStreamedResponse extends SmartFake implements StreamedResponse {
  FakeStreamedResponse(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class MockClient extends Mock implements Client {
  MockClient() {
    throwOnMissingStub(this);
  }

  @override
  Future<Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: Future<Response>.value(FakeResponse(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as Future<Response>);

  @override
  Future<Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: Future<Response>.value(FakeResponse(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as Future<Response>);

  @override
  Future<Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: Future<Response>.value(FakeResponse(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as Future<Response>);

  @override
  Future<Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: Future<Response>.value(FakeResponse(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as Future<Response>);

  @override
  Future<Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: Future<Response>.value(FakeResponse(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as Future<Response>);

  @override
  Future<Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: Future<Response>.value(FakeResponse(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as Future<Response>);

  @override
  Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: Future<String>.value(''),
      ) as Future<String>);

  @override
  Future<Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: Future<Uint8List>.value(Uint8List(0)),
      ) as Future<Uint8List>);

  @override
  Future<StreamedResponse> send(BaseRequest? request) => (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue: Future<StreamedResponse>.value(FakeStreamedResponse(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as Future<StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppServicesClient implements AppServicesClient {
  _AppServicesClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://chapt-amr-mahmoud.wiremockapi.cloud/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthenticationResponses> login(
    String email,
    String password,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponses>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthenticationResponses.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationResponses> register(
    String email,
    String password,
    String userName,
    String phoneNumber,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
      'user_name': userName,
      'phone_number': phoneNumber,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponses>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/signup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AuthenticationResponses.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }

  @override
  Future<MessageResponse> sendMessage(MessageRequest messageRequest) async {
    List<Content> listOfOldMsgs = [];
    for (Message msg in messageRequest.oldMsgs) {
      if (msg.role != AppConstants.modelRoleName) {
        listOfOldMsgs.add(Content.text(msg.msg));
      } else {
        listOfOldMsgs.add(Content.model([TextPart(msg.msg)]));
      }
    }
    final GenerativeModel model = GenerativeModel(
      model: AppConstants.modelVersion,
      apiKey: apiKey,
      generationConfig:
          GenerationConfig(maxOutputTokens: AppConstants.geneConfig),
    );
    final ChatSession chat = model.startChat(
      history: listOfOldMsgs,
    );
    final Content content = Content.text(messageRequest.message);
    final GenerateContentResponse response = await chat.sendMessage(content);
    return MessageResponse.fromResponse(response);
  }
}

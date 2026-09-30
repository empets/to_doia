import 'dart:convert';

import 'package:http/http.dart';
import 'package:to_doia/core/service_systeme/model/api/api_error.dart';

abstract class ApiResult<T> {
  static const String _jsonNodeData = 'item'; //itemsSav
  static const String _jsonNodeResponse = 'response'; //itemsSav
  static const String _jsonNodeItemsTrans = 'itemsTrans'; //itemsSav
  static const String _jsonNodeKey = 'key'; //itemsSav
  static const String _jsonNodeDataItems = 'Items'; //itemsSav
  static const String _jsonNodeItemsSav = 'itemsSav'; //itemsSav
  static const String _jsonNodeItemSav = 'itemSav'; //itemsSav
  static const String _jsonNodeFactures = 'factures';
  static const String _jsonNodeDatas = 'items';
  static const String _jsonNodeHasError = 'hasError';
  static const String _jsonNodeDataField = 'data';
  static const String _jsonNodeOther = 'equipementsAssocies';
  static const String _jsonNodeItemMap = 'itemMap';
  static const String _jsonNodeLat = 'lat';
  static const String _jsonNodeLon = 'lon';

  // Fusion des deux anciennes constantes `_jsonNodestatus`/`_jsonNodeStatus`
  // (même valeur 'status', utilisées de façon interchangeable) — voir
  // `refactor-api-result-structure`.
  static const String _jsonNodeStatus = 'status';
  static const String _jsonNodeModulus = 'modulus'; // //infosClient
  static const String _jsonNodeInfosClient = 'infosClient'; // //infosClient

  // Clés à correspondance directe (présente et non nulle -> valeur transmise
  // telle quelle au mapper), dans l'ordre de résolution exact de l'ancienne
  // chaîne `if`/`else if` — voir design.md de `refactor-api-result-
  // structure`, décision 3. Ne pas réordonner : l'ordre détermine quelle clé
  // gagne quand plusieurs sont présentes dans la même réponse.
  static const List<String> _directKeys = [
    _jsonNodeKey,
    _jsonNodeItemsSav,
    _jsonNodeItemSav,
    _jsonNodeItemsTrans,
    _jsonNodeInfosClient,
    _jsonNodeResponse,
    _jsonNodeDataItems,
    _jsonNodeModulus,
    _jsonNodeFactures,
  ];

  static ApiResult<T> fromResponse<T>(
    Response response,
    T Function(dynamic) mapper, // Map<String, dynamic> or List<T>
  ) {
    try {
      if (json.decode(response.body) is List) {
        return Success(
          mapper(json.decode(response.body)),
        );
      }

      final responseData = _decodeBody(response);

      if (_hasErrorTrue(responseData)) {
        return _resolveErrorTrue(response, responseData, mapper);
      }

      if (_hasErrorFalseWithNoKnownKeys(responseData)) {
        return _resolveErrorFalseFallback(response, responseData, mapper);
      }

      if (responseData.containsKey(_jsonNodeData) &&
          responseData[_jsonNodeData] != null) {
        return _resolveDataField(response, responseData, mapper);
      }

      for (final key in _directKeys) {
        if (responseData.containsKey(key) && responseData[key] != null) {
          return Success(mapper(responseData[key]));
        }
      }

      if (responseData.containsKey(_jsonNodeDatas) &&
          responseData[_jsonNodeDatas] != null) {
        return _resolveDatasField(response, responseData, mapper);
      }

      final statusOnlyResult = _resolveStatusOnlyFallback(
        response,
        responseData,
        mapper,
      );
      if (statusOnlyResult != null) {
        return statusOnlyResult;
      }

      if (responseData.containsKey(_jsonNodeDataField)) {
        return Success(mapper(responseData[_jsonNodeDataField]));
      } else if (responseData.containsKey(_jsonNodeOther)) {
        return Success(mapper(responseData[_jsonNodeOther]));
      } else if (responseData.containsKey(_jsonNodeItemMap)) {
        return Success(mapper(responseData[_jsonNodeItemMap]));
      } else if (responseData.containsKey(_jsonNodeLat) &&
          responseData.containsKey(_jsonNodeLon)) {
        return Success(
          mapper(responseData),
        );
      } else {
        if (responseData.isEmpty) {
          return Success(
            mapper(responseData),
          );
        }

        return ServerError.fromResponse(response);
      }
    } catch (e, _) {
      return ServerError(
        ApiError(
          code: '500',
          message: 'Une erreur est survenue. Veuillez réessayer plus tard.',
        ),
      );
    }
  }

  static Map<String, dynamic> _decodeBody(Response response) {
    try {
      return json.decode(
        utf8.decode(
          response.bodyBytes,
        ),
      ) as Map<String, dynamic>;
    } catch (_) {
      return json.decode(
        response.body,
      ) as Map<String, dynamic>;
    }
  }

  static bool _hasErrorTrue(Map<String, dynamic> responseData) {
    return responseData.containsKey(_jsonNodeHasError) &&
        responseData[_jsonNodeHasError] != null &&
        (responseData[_jsonNodeHasError] as bool);
  }

  static bool _hasErrorFalseWithNoKnownKeys(
    Map<String, dynamic> responseData,
  ) {
    return responseData.containsKey(_jsonNodeHasError) &&
        responseData[_jsonNodeHasError] != null &&
        ((responseData[_jsonNodeHasError] as bool) == false) &&
        !responseData.containsKey(_jsonNodeData) &&
        !responseData.containsKey(_jsonNodeDatas) &&
        !responseData.containsKey(_jsonNodeFactures) &&
        !responseData.containsKey(_jsonNodeModulus) &&
        !responseData.containsKey(_jsonNodeDataField) &&
        !responseData.containsKey(_jsonNodeResponse) &&
        !responseData.containsKey(_jsonNodeKey) &&
        !responseData.containsKey(_jsonNodeItemsTrans) &&
        !responseData.containsKey(_jsonNodeItemSav) &&
        !responseData.containsKey(_jsonNodeItemsSav) &&
        !responseData.containsKey(_jsonNodeInfosClient) &&
        !responseData.containsKey(_jsonNodeItemMap);
  }

  // `hasError: true` — cas spécial `client/getOffreVerification` avec
  // `status.code == '952'` (l'item de `itemMap` fusionné au `status`),
  // sinon `ServerError`.
  static ApiResult<T> _resolveErrorTrue<T>(
    Response response,
    Map<String, dynamic> responseData,
    T Function(dynamic) mapper,
  ) {
    // verification du code 952
    if ((response.request != null) &&
        response.request!.url.path.contains('client/getOffreVerification')) {
      if ((responseData[_jsonNodeStatus] as Map)['code'] == '952') {
        final item = responseData[_jsonNodeItemMap] as Map<String, dynamic>
          ..addAll(
            {
              'status': responseData[_jsonNodeStatus] as Map<String, dynamic>,
            },
          );

        return Success(
          mapper(item),
        );
      }
    }

    return ServerError.fromResponse(response);
  }

  // `hasError: false` et aucune clé de données connue — cas spéciaux
  // `refreshtoken`/`auth/getToken` (tokens d'authentification), `status.code`
  // ∈ {900,902,903} avec cas spécial `client/getByCriteria`, sinon repli sur
  // `hasError` transmis tel quel au mapper.
  static ApiResult<T> _resolveErrorFalseFallback<T>(
    Response response,
    Map<String, dynamic> responseData,
    T Function(dynamic) mapper,
  ) {
    if (response.request != null &&
        response.request!.url.path.toLowerCase().endsWith('refreshtoken') &&
        responseData.containsKey('accessToken')) {
      // `auth/refreshToken` (v1) et `auth/v2/refreshToken` : l'objet
      // accessToken complet (expire_in/token/refreshToken) est transmis
      // tel quel — voir spec `user-token-refresh`, AccessTokenModel en
      // fait le parsing. `endsWith` (pas `contains`) : un faux positif
      // ferait parser une réponse non-auth comme si elle portait un
      // accessToken.
      return Success(
        mapper(responseData['accessToken']),
      );
    }

    if (response.request != null &&
        response.request!.url.path.toLowerCase().endsWith('auth/gettoken') &&
        responseData.containsKey('authToken')) {
      return Success(mapper(responseData['authToken']));
    }

    if (responseData.containsKey(_jsonNodeStatus) &&
        (((responseData[_jsonNodeStatus] as Map)['code'] == '903') ||
            (responseData[_jsonNodeStatus] as Map)['code'] == '902' ||
            (responseData[_jsonNodeStatus] as Map)['code'] == '900')) {
      if ((response.request != null) &&
          response.request!.url.path.contains('client/getByCriteria')) {
        return ServerError.fromResponse(response);
      }
      return Success(mapper(<dynamic>[]));
    }

    return Success(mapper(responseData[_jsonNodeHasError]));
  }

  // `item` présent — cas spéciaux `itemsSav`/`itemSav` imbriqués, cas
  // spécial rattachement (`validateOtpWithTag`/`updateLieux`/
  // `manualAttachContract`, fusion `accessToken`/`refreshToken`), sinon
  // `item` transmis tel quel.
  static ApiResult<T> _resolveDataField<T>(
    Response response,
    Map<String, dynamic> responseData,
    T Function(dynamic) mapper,
  ) {
    if (responseData.containsKey(_jsonNodeItemsSav)) {
      return Success(mapper(responseData[_jsonNodeItemsSav]));
    }
    if (responseData.containsKey(_jsonNodeItemSav)) {
      return Success(mapper(responseData[_jsonNodeItemSav]));
    }
    if (response.request != null &&
        (response.request!.url.path.contains('contrat/validateOtpWithTag') ||
            response.request!.url.path.contains('lieux/updateLieux') ||
            response.request!.url.path
                .contains('contrat/manualAttachContract'))) {
      final item = Map<String, dynamic>.from(
        responseData[_jsonNodeData] as Map<String, dynamic>,
      );
      // L'objet accessToken (expire_in/token) est transmis tel quel
      // sous sa propre clé. `refreshToken` est un FRÈRE de `accessToken`
      // au niveau racine de la réponse (`{ expire_in, token }`), jamais
      // imbriqué dans `accessToken` — comportement confirmé contre le
      // backend réel (voir spec `user-token-refresh`). On l'imbrique
      // nous-mêmes dans `accessToken.refreshToken` ici, seul point où
      // les deux objets sont encore visibles ensemble, pour que
      // `AccessTokenModel`/`RattachementContratModel`/
      // `UpdateLieuxContratModel` le récupèrent normalement.
      if (responseData['accessToken'] != null) {
        final accessToken = Map<String, dynamic>.from(
          responseData['accessToken'] as Map<String, dynamic>,
        );
        final siblingRefreshToken = responseData['refreshToken'];
        if (siblingRefreshToken is Map &&
            accessToken['refreshToken'] == null) {
          accessToken['refreshToken'] = siblingRefreshToken['token'];
        }
        item['accessToken'] = accessToken;
      }
      return Success(mapper(item));
    }
    return Success(mapper(responseData[_jsonNodeData]));
  }

  // `items` présent — cas spécial `validateOtpWithTag` (`clientId` seul),
  // cas spécial `reAuthentification`/`checkClient`/
  // `customerConnectionViaMaxit` (fusion `sessionUser`), sinon `items`
  // transmis tel quel.
  static ApiResult<T> _resolveDatasField<T>(
    Response response,
    Map<String, dynamic> responseData,
    T Function(dynamic) mapper,
  ) {
    if ((response.request != null) &&
        response.request!.url.path.contains('contrat/validateOtpWithTag')) {
      return Success(mapper(responseData['clientId']));
    }

    if (response.request != null &&
            response.request!.url.path
                .contains('client/reAuthentification') ||
        response.request != null &&
            response.request!.url.path.endsWith('client/checkClient') ||
        response.request != null &&
            response.request!.url.path
                .contains('client/customerConnectionViaMaxit')) {
      var items = <String, dynamic>{};

      if (responseData.containsKey('sessionUser')) {
        if (responseData[_jsonNodeDatas] is List) {
          items = (responseData[_jsonNodeDatas] as List).first
              as Map<String, dynamic>;
          items['sessionUser'] = responseData['sessionUser'];
        }
      }

      if (items.isNotEmpty) {
        return Success(
          mapper([
            ...[items],
          ]),
        );
      }
    }

    return Success(mapper(responseData[_jsonNodeDatas]));
  }

  // `status` présent sans `hasError` dans la réponse — chemin distinct de
  // `_resolveErrorFalseFallback` (qui exige `hasError: false` explicite),
  // avec un comportement différent pour les mêmes codes ; divergence
  // préservée telle quelle, pas corrigée par ce refactor (voir design.md).
  // Retourne `null` si aucun des quatre cas ne matche, pour que
  // `fromResponse` poursuive la chaîne (`data`/`equipementsAssocies`/...).
  static ApiResult<T>? _resolveStatusOnlyFallback<T>(
    Response response,
    Map<String, dynamic> responseData,
    T Function(dynamic) mapper,
  ) {
    if (responseData.containsKey(_jsonNodeStatus) &&
        (responseData[_jsonNodeStatus] is double)) {
      return ServerError.fromResponse(response);
    } else if (responseData.containsKey(_jsonNodeStatus) &&
        (responseData[_jsonNodeStatus] as Map)['code'] == '903') {
      return Success(mapper(<dynamic>[]));
    } else if (responseData.containsKey(_jsonNodeStatus) &&
        (responseData[_jsonNodeStatus] as Map)['code'] == '900') {
      return ServerError.fromResponse(response);
    } else if (responseData.containsKey(_jsonNodeStatus) &&
        (responseData[_jsonNodeStatus] as Map)['code'] == '100') {
      return ServerError.fromResponse(response);
    }

    return null;
  }
}

class Success<T> extends ApiResult<T> {
  Success(this.data);

  final T data;
}

class Failed<T> extends ApiResult<T> {
  Failed(this.errors);

  ApiError errors;
}

class ServerError<T> extends Failed<T> {
  ServerError(super.errors);

  static const String _jsonNodeStatus = 'status';
  static const String _jsonNodeItem = 'item';

  static ServerError<T> fromResponse<T>(Response response) {
    Map<dynamic, dynamic> bodyMap;
    try {
      bodyMap =
          json.decode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    } catch (_) {
      return ServerError(
        ApiError(
          code: '500',
          message: 'Une erreur est survenue. Veuillez réessayer plus tard.',
        ),
      );
    }

    if (bodyMap[_jsonNodeStatus] is int || bodyMap[_jsonNodeStatus] is double) {
      final code = '${bodyMap[_jsonNodeStatus]}';
      final message = '${bodyMap['error']} ${bodyMap[_jsonNodeStatus]}';
      return ServerError(
        ApiError.fromJson({
          'code': code,
          'message': message,
        }),
      );
    } else if (bodyMap.containsKey(_jsonNodeItem)) {
      return ServerError(
        ApiError.fromJson(
          bodyMap[_jsonNodeItem] as Map<String, dynamic>,
        ),
      );
    } else if (!bodyMap.containsKey(_jsonNodeItem) &&
        !bodyMap.containsKey(_jsonNodeStatus)) {
      final code = '${bodyMap['codeErreur']}';
      final message = '${bodyMap['message']}';
      return ServerError(
        ApiError.fromJson({
          'code': code,
          'message': message,
        }),
      );
    }

    return ServerError(
      ApiError.fromJson(
        (json.decode(utf8.decode(response.bodyBytes)) as Map)[_jsonNodeStatus]
            as Map<String, dynamic>,
      ),
    );
  }
}

class InternalError<T> extends Failed<T> {
  InternalError(super.errors);
}

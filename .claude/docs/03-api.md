# API Integration

## Valorant API

This app uses the public [Valorant API](https://valorant-api.com/) which requires no authentication.

### Base Configuration

```dart
class ApiConfig {
  static const String baseUrl = 'https://valorant-api.com/v1';
  static const String language = 'pt-BR';
}
```

## Endpoints

### Agents

```
GET /agents/?isPlayableCharacter=true&language=pt-BR
```

Returns all playable agents with:
- UUID, display name, description
- Full portrait, bust portrait, background
- Role information
- Abilities list

### Maps

```
GET /maps/?language=pt-BR
```

Returns all game maps with:
- UUID, display name
- Coordinates, tactical description
- Splash image, display icon

### Weapons

```
GET /weapons/?language=pt-BR
```

Returns all weapons with:
- UUID, display name, category
- Stats (fire rate, magazine size, reload time)
- Damage ranges (head/body/legs damage)
- Skins and chromas

## Response Structure

All endpoints return:

```json
{
  "status": 200,
  "data": [ ... ]
}
```

## DataSource Implementation

### Remote DataSource

```dart
abstract class AgentRemoteDataSource {
  Future<List<AgentModel>> getAgents();
}

class AgentRemoteDataSourceImpl implements AgentRemoteDataSource {
  final HttpClient _client;

  AgentRemoteDataSourceImpl(this._client);

  @override
  Future<List<AgentModel>> getAgents() async {
    final response = await _client.get(ApiConfig.agentsEndpoint);
    final List<dynamic> data = response['data'];
    return data.map((json) => AgentModel.fromJson(json)).toList();
  }
}
```

### Local DataSource (Cache)

```dart
abstract class AgentLocalDataSource {
  Future<List<AgentModel>> getCachedAgents();
  Future<void> cacheAgents(List<AgentModel> agents);
}
```

## HTTP Client

Located at `lib/app/data/http/http_client_service.dart`:

```dart
class HttpClientService {
  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw ServerException('Failed to load data');
  }
}
```

## Error Handling

### Exceptions (Data Layer)

```dart
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
}
```

### Failures (Domain Layer)

```dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}
```

## Caching Strategy

- Cache API responses locally using GetStorage
- Check cache before making network requests
- Invalidate cache after 24 hours
- Fallback to cache on network errors

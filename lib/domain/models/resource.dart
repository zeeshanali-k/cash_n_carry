abstract class Resource<T> {
  T? data;
  Resource({this.data});

}

class ResourceLoading extends Resource{}

class ResourceError<T> extends Resource{
  String? message;
  ResourceError({this.message}):super(data: null);
}

class ResourceSuccess<T> extends Resource{
  ResourceSuccess(T data):super(data: data);
}
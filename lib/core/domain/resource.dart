class Resource<T> {
  final T body;
  final String message;

  Resource({
    this.body,
    this.message,
  });

  Resource<T> success(T body) => Resource(
        body: body,
        message: null,
      );

  Resource<T> failed(String message) => Resource(
        body: null,
        message: message,
      );
}

class ResponseData {
  // Data of the response
  dynamic data;

  // Message of the response
  String message;

  // Had an error while fetching
  bool hasError;

  // Connection status
  bool isConnected;

  ResponseData({
    this.data = "",
    this.message = "",
    this.hasError = true,
    this.isConnected = true,
  });
}

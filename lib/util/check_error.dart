bool checkSessionError(Map<String, dynamic> response) {
  return response['error'] != null;
}

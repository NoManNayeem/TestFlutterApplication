class AuthService {
  bool _isLoggedIn = false; // Variable to track the login status

  // Simulating if this is the first time the user has launched the app
  Future<bool> isFirstLaunch() async {
    // Simulated delay to mimic a real async operation
    await Future.delayed(const Duration(seconds: 1));
    // Normally, you would check persistent storage to determine first launch
    return true; // Change this to false after the first launch
  }

  // Checking if the user is logged in
  Future<bool> isLoggedIn() async {
    // Simulated delay to mimic a real async operation
    await Future.delayed(const Duration(seconds: 1));
    return _isLoggedIn;
  }

  // Simulating login function
  Future<bool> login(String username, String password) async {
    // Simulated delay for login process
    await Future.delayed(const Duration(seconds: 1));

    // Check if the credentials are correct
    if (username == 'Nayeem' && password == 'Password') {
      _isLoggedIn = true; // Mark the user as logged in
      return true; // Login successful
    } else {
      return false; // Login failed
    }
  }

  // Simulating logout function
  Future<void> logout() async {
    // Simulated delay for logout process
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = false; // Mark the user as logged out
  }
}

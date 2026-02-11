class LoginRequest {
    String? username;
    String? password;

    LoginRequest({
        this.username,
        this.password,
    });

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}

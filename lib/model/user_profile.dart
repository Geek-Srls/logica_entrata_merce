class UserProfile {
  final String res;
  final String message;
  final String jwt;
  final String username;
  final String userid;
  final String nome;
  final String cognome;
  final String email;
  final String sesso;
  final String idGruppo;
  final String gruppo;
  final int expireAt;

  const UserProfile(
      {required this.res,
      required this.message,
      required this.jwt,
      required this.username,
      required this.userid,
      required this.nome,
      required this.cognome,
      required this.email,
      required this.sesso,
      required this.idGruppo,
      required this.gruppo,
      required this.expireAt});

  factory UserProfile.fromData(dynamic data) {
    final String res = data["res"];
    final String message = data["message"];
    final String jwt = data["jwt"];
    final String username = data["username"];
    final String userid = data["userid"];
    final String nome = data["nome"];
    final String cognome = data["cognome"];
    final String email = data["email"];
    final String sesso = data["sesso"];
    final String idGruppo = data["id_gruppo"];
    final String gruppo = data["gruppo"];
    final int expireAt = data["expireAt"];

    return UserProfile(
        res: res,
        message: message,
        jwt: jwt,
        username: username,
        userid: userid,
        nome: nome,
        cognome: cognome,
        email: email,
        sesso: sesso,
        idGruppo: idGruppo,
        gruppo: gruppo,
        expireAt: expireAt);
  }
}

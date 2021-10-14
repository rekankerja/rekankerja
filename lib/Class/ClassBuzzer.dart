/// Class Buzzer Dipakai untuk Send dan Receive Supaya gak kebanyakan class
/// Class Buzzer Dipakai untuk Send dan Receive Supaya gak kebanyakan class
/// Class Buzzer Dipakai untuk Send dan Receive Supaya gak kebanyakan class
/// Class Buzzer Dipakai untuk Send dan Receive Supaya gak kebanyakan class
/// Class Buzzer Dipakai untuk Send dan Receive Supaya gak kebanyakan class
/// Class Buzzer Dipakai untuk Send dan Receive Supaya gak kebanyakan class
/// Class Buzzer Dipakai untuk Send dan Receive Supaya gak kebanyakan class
///
///
///
///
///
class ClassBuzzer {
  String uidSender;
  String displayNameSender;
  String photoURLSender;
  String uidReceiver;
  String displayNameReceiver;
  String photoURLReceiver;
  String dateTimeSend;
  String dateTimeReceive;
  int idMessageSender;
  String pesan;
  String isRead;
  String isBuzzerReceive;
  String isUseBuzzer;

  Map toJson() => {
    'uidSender': uidSender,
    'displayNameSender': displayNameSender,
    'photoURLSender': photoURLSender,
    'uidReceiver': uidReceiver,
    'displayNameReceiver': displayNameReceiver,
    'photoURLReceiver': photoURLReceiver,
    'dateTimeSend': dateTimeSend,
    'dateTimeReceive': dateTimeReceive,
    'idMessageSender': idMessageSender,
    'pesan': pesan,
    'isRead': isRead,
    'isBuzzerReceive': isBuzzerReceive,
    'isUseBuzzer': isUseBuzzer,
  };

  ClassBuzzer(
     this.uidSender,
      this.displayNameSender,
      this.photoURLSender,
      this.uidReceiver,
      this.displayNameReceiver,
      this.photoURLReceiver,
      this.dateTimeSend,
      this.dateTimeReceive,
      this.idMessageSender,
      this.pesan,
      this.isRead,
      this.isBuzzerReceive,
      this.isUseBuzzer,
      );
}

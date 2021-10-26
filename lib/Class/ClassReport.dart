
class ClassReport {
  String UidReceiver;
  String UidSender;
  String idpesan;
  String dateTimeReceive;



  Map toJson() => {
    'UidReceiver': UidReceiver,
    'UidSender': UidSender,
    'idpesan': idpesan,
    'dateTimeReceive': dateTimeReceive
  };

  ClassReport(
      this.UidReceiver,
      this.UidSender,
      this.idpesan,
      this.dateTimeReceive
      );
}

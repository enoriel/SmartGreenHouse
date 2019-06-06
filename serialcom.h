#ifndef SERIALCOM_H
#define SERIALCOM_H
#include <QDateTime>

#include <QObject>
#include <QSerialPort>
#include <QMessageBox>
#include <QObject>
#include <QDebug>

class serialCom : public QObject
{
    Q_OBJECT
public:
    explicit serialCom(QObject *parent = nullptr);

signals:
    void serialValue(QByteArray buf);
    void tempReady();
    void hAirReady();
    void hGndReady();
    void s_tempGH(QString buffer);
    void s_airGH(QString buffer);
    void s_gndGH(QString buffer);
public slots:
    // Handle error
    void handleError(QSerialPort::SerialPortError error);
    void read();
    void close();
    void sendCommand(QString msg);
    void errorCommand();
    void waitForAnswer();
    int openCom();
//    ~serialCom();
private:
    QSerialPort *m_serial;
    QString m_port = "/dev/ttyO4";
    QString m_buffer, m_cmd;
    // Key words for parsing our buffer
    QString error_reply = "Erreur";
    QString temp_reply = "temperature";
    QString humi_air_reply = "humidite de l'air";
    QString humi_ground_reply = "humidite du sol";
    QString ok_reply = "OK";
};

#endif // SERIALCOM_H

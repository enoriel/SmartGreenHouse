#ifndef WEATHER_H
#define WEATHER_H
#include <QtNetwork>
#include <QDateTime>
#include "serialcom.h"

#include <QObject>

#define ON true
#define OFF false
#define recuperation_temperature    "t"	// Code ASCII de la lettre "t"
#define recuperation_humidite_air   "h"	// Code ASCII de la lettre "h"
#define recuperation_humidite_sol	"s"	// Code ASCII de la lettre "s"
#define eclairage_horitcole_ON      "o"	// Code ASCII de la lettre "o"
#define eclairage_horticole_OFF		"f"	// Code ASCII de la lettre "f"
#define consigne_temperature		"1"	// Code ASCII du chiffre 	 "0"
#define consigne_humidite_air		"2"	// Code ASCII du chiffre	 "1"
#define consigne_humidite_sol       "3"	// COde ASCII du chiffre 	 "2"

class Weather : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString temp READ getTemp NOTIFY weatherUpdate)
    Q_PROPERTY(double humidity READ getHumidity NOTIFY weatherUpdate)
    Q_PROPERTY(QString sunrise READ getSunrise NOTIFY weatherUpdate)
    Q_PROPERTY(QString sunset READ getSunset NOTIFY weatherUpdate)
    Q_PROPERTY(QString city READ getCity NOTIFY weatherUpdate)
    Q_PROPERTY(QString svg READ getIcon NOTIFY weatherUpdate)
    Q_PROPERTY(bool lightStatus READ getLightStatus NOTIFY lightStatus)
    Q_PROPERTY(QString tempGH READ getTempGH NOTIFY updateGH)
    Q_PROPERTY(QString humAir READ getHumAir NOTIFY updateGH)
    Q_PROPERTY(QString humGnd READ getHumGnd NOTIFY updateGH)

public:
    explicit Weather(QObject *parent = nullptr);
    Q_INVOKABLE void sendRequest(int id, const QString &msg1, const QString &msg2);
    Q_INVOKABLE void updateWeather();
    Q_INVOKABLE void errSearch();
signals:
    void weatherUpdate();
    void lightStatus();
    void updateGH();

private slots:
    void dWeatherUp();
    // Getters
    double getHumidity(){ return m_humidity; }
    QString getTemp(){return (QString::number((m_temp-273.15), 'f', 1));} // Floating point at one decimal
    QString getSunrise(){ return m_sunrise.toUtf8(); }
    QString getSunset(){ return m_sunset.toUtf8(); }
    QString getCity(){ return (m_city+", "+m_country); }
    QString getIcon(){ return m_icon; }
    QString getTempGH(){ return m_tempGH; }
    QString getHumAir(){ return (m_humAir+" %"); }
    QString getHumGnd(){ return (m_humGnd+" %"); }
    bool getLightStatus() { return m_statusLight; }
    // Update greenhouse parameters and weathers informations
    Q_INVOKABLE void setLightStatus(bool status);
    void getHTTPJSon();
    void updateAirHumGH();
    void updateTempGH();
    void sendTemp();
    void setTempGH();
    void setHAirGH();
    void setHGndGH();
    void sendHumAir();
    void sendHumGnd();
    void setIcon();
    void setDayTime();
    void errWeatherUpdate();
    void setUrl(int id, const QString &msg1, const QString &msg2);
    void setGHAirHum(QString buffer);
    void setGHGndHum(QString buffer);
    void setGHTemp(QString buffer);

private:
    QString m_url;
    QString m_city, m_country;
    double m_humidity, m_temp;
    QString m_sunset, m_sunrise, m_icon, m_cmd, m_tempGH, m_humAir, m_humGnd;
    int m_id, t_sunrise, t_sunset;
    QNetworkRequest *net_request;
    QNetworkAccessManager *manager;
    QJsonObject *data;
    QJsonDocument *doc;
    QNetworkReply *reply;
    serialCom *m_serial;
    QTimer *m_timer;
    bool m_statusLight;
};

#endif // WEATHER_H

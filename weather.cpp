#include "weather.h"

Weather::Weather(QObject *parent) :
    QObject(parent),
    m_city(""),
    m_country(""),
    m_humidity(0),
    m_temp(273.15),
    m_icon("01d"),
    m_tempGH("--.-"),
    m_humAir("--"),
    m_humGnd("--"),
    m_id(0),
    t_sunrise(0),
    t_sunset(0),
    m_statusLight(false)
{
    // Prepare for HTTP requests
    net_request = new QNetworkRequest;
    manager = new QNetworkAccessManager;
    data = new QJsonObject;
    doc = new QJsonDocument;
    m_serial = new serialCom(this);
    m_timer = new QTimer;

    // Signal to slot connections
    QObject::connect(this, &Weather::weatherUpdate, this, &Weather::dWeatherUp);
    QObject::connect(m_timer, &QTimer::timeout, this, &Weather::updateWeather);

    // Signal to send command
    QObject::connect(m_serial,&serialCom::tempReady,this,&Weather::sendTemp);
    QObject::connect(m_serial,&serialCom::hAirReady,this,&Weather::sendHumAir);
    QObject::connect(m_serial,&serialCom::hGndReady,this,&Weather::sendHumGnd);
    QObject::connect(m_serial,&serialCom::s_airGH,this,&Weather::setGHAirHum);
    QObject::connect(m_serial,&serialCom::s_tempGH,this,&Weather::setGHTemp);
    QObject::connect(m_serial,&serialCom::s_gndGH,this,&Weather::setGHGndHum);

    // Update every 60 seconds
    m_timer->setInterval(60000);
    setLightStatus(OFF);
    // Retrieving temperature and humidity from greenhouse's sensors
    setTempGH();
    setHAirGH();
    setHGndGH();
}

void Weather::dWeatherUp()
{

    qDebug() << "Informations métérologique mises à jour."<<endl;
}

void Weather::setLightStatus(bool status)
{
    QString cmd;
    // Send command to change light status (on/off)
    if (status == true)
        cmd = eclairage_horitcole_ON;
    if (status == false)
        cmd = eclairage_horticole_OFF;
    int ret = m_serial->openCom();
    if (ret == 0)
    {
        m_serial->sendCommand(cmd.toLocal8Bit());
        m_serial->close();
    }

    // Change display status (led on/off)
    m_statusLight = status;
    emit lightStatus();
}

/* Sending temperature by serial port to the greenhouse
 * Format: two characters
 */
void Weather::sendTemp()
{
        m_serial->sendCommand(QString::number((m_temp-273.15),'f',0).toLocal8Bit());
        m_serial->close();
}

// Request greenhouse's temperature
void Weather::setTempGH()
{
    int ret = 0;
    // Opening com port then requesting temp
    ret = m_serial->openCom();
    if (ret == 0)
    {
        m_serial->sendCommand("t");
        m_serial->waitForAnswer();
    }

}

// Request greenhouse's air humidity
void Weather::setHAirGH()
{
    int ret = 0;
    // Opening com port then requesting  air humidity
    ret = m_serial->openCom();
    if (ret == 0)
    {
        m_serial->sendCommand("h");
        m_serial->waitForAnswer();
    }
}

// Request greenhouse's ground humidity
void Weather::setHGndGH()
{
    int ret = 0;
    // Opening com port then requesting  air humidity
    ret = m_serial->openCom();
    if (ret == 0)
    {
        m_serial->sendCommand("s");
        m_serial->waitForAnswer();
    }
}

/* Sending air humidity to the greenhouse by serial port
 * Format: two characters
 */
void Weather::sendHumAir()
{
        m_serial->sendCommand(QString::number(m_humidity).toLocal8Bit());
        m_serial->close();
}

/* Sending ground humidity to the greenhouse by serial port
 * Format: two characters
 */
void Weather::sendHumGnd()
{
        m_serial->sendCommand(m_humGnd.toLocal8Bit());
        m_serial->close();
}

void Weather::setIcon()
{
    QString tmpIcon =(((*data).value("weather").toArray()).at(0).toObject())["icon"].toString();
    if (tmpIcon != m_icon)
    {
        m_icon = tmpIcon;
    }
}

void Weather::setDayTime()
{

    int tmpSunrise = (*data)["sys"].toObject()["sunrise"].toInt();
    // if the timestamp is different, the date as change so we update
    if (t_sunrise != tmpSunrise)
    {
        QDateTime sunrise;
        t_sunrise =tmpSunrise;
        sunrise.setTime_t(static_cast<uint>(t_sunrise));
        m_sunrise = sunrise.toString("hh:mm:ss");
        QDateTime sunset;
        t_sunset = (*data)["sys"].toObject()["sunset"].toInt();
        sunset.setTime_t(static_cast<uint>(t_sunset));
        m_sunset = sunset.toString("hh:mm:ss");
        qDebug() << "" << endl;
    }
    // Checking if we reached sunrise
    if ((QDateTime::currentDateTime().toTime_t() < static_cast<uint>(t_sunset)) && !m_statusLight && (QDateTime::currentDateTime().toTime_t() > static_cast<uint>(t_sunrise)))
    {
        // Turning on the lights
        setLightStatus(ON);
    }
    // Checking if we reached sunset
    else if ((QDateTime::currentDateTime().toTime_t() > static_cast<uint>(t_sunset)) && m_statusLight)
    {
        // Turning off the lights
        setLightStatus(OFF);
    }
}

void Weather::errWeatherUpdate()
{
    QMessageBox msgBox;
    msgBox.setWindowTitle("Erreur code "+(*data).value("cod").toString());
    msgBox.setText("Impossible de mettre à jour les données météorologiques.\n"+(*data).value("message").toString());
    msgBox.exec();
}

void Weather::setUrl(int id, const QString &msg1, const QString &msg2)
{
    switch (id) {
        /*
         * Search parameters: City, Country code
         */
        case 0: {
            // URL weather informations from city name and country id
            m_url = "http://api.openweathermap.org/data/2.5/weather?appid=0c42f7f6b53b244c78a418f4f181282a&q=" + msg1 + "," + msg2;
            //qDebug() << m_url;
            break;
        }
        case 1:{
            // URL weather informations from ZIP code and country
            m_url = "http://api.openweathermap.org/data/2.5/weather?appid=0c42f7f6b53b244c78a418f4f181282a&zip=" + msg1 + "," + msg2;
            //qDebug() << m_url;
            break;
        }
        case 2:{
            // URL weather informations from city name and country id
            m_url = "http://api.openweathermap.org/data/2.5/weather?appid=0c42f7f6b53b244c78a418f4f181282a&lat=" + msg2 + "&lon=" + msg1;
            //qDebug() << m_url;
            break;
        }
        default: {
            break;
        }
    }
}

void Weather::setGHAirHum(QString buffer)
{
    m_humAir = buffer.left(2);
    m_serial->close();
    emit updateGH();
}

void Weather::setGHGndHum(QString buffer)
{
    m_humGnd = buffer.left(2);
    m_serial->close();
    emit updateGH();
}

void Weather::setGHTemp(QString buffer)
{
    m_tempGH = buffer.left(4);
    m_serial->close();
    emit updateGH();
}

/* HTTP request JSon
 * Download JSon file using internet connection
 * then store the content in QJsonDocument
 */
void Weather::getHTTPJSon()
{
    // Start HTTP request
    // Configure the HTTP request for retrieving Json
    net_request->setUrl(m_url);
    net_request->setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    reply = manager->post(*net_request, doc->toJson());
    // Reading the all file
    while (!reply->isFinished())
    {
        qApp->processEvents();
    }
    QString resp = reply->readAll();
    //qDebug() << resp;
    // Setting weather info
    *doc = QJsonDocument::fromJson(resp.toLatin1());
    *data = doc->object();
}

void Weather::updateAirHumGH()
{
    int ret = 0;
    double tmpHumAir = (*data)["main"].toObject()["humidity"].toDouble();
    if (static_cast<int>(tmpHumAir) != static_cast<int>(m_humidity))
    {
        m_humidity = tmpHumAir;
        // Opening Serial Port and sending message
        ret = m_serial->openCom();
        if (ret == 0)
        {
            // Requesting air humidity update (msg character "2")
            m_serial->sendCommand("2");
            m_serial->waitForAnswer();
        }
    }
}

void Weather::updateTempGH()
{
    int ret;
    double tmpTemp = (*data)["main"].toObject()["temp"].toDouble();
    if (static_cast<int>(m_temp*10) != static_cast<int>(tmpTemp*10))
    {
        m_temp = tmpTemp;
        // Opening Serial Port and sending message
        ret = m_serial->openCom();
        if (ret == 0)
        {
            // Requesting temperature update (msg character "1")
            m_serial->sendCommand("1");
            m_serial->waitForAnswer();
        }
    }
}

void Weather::updateWeather()
{
    /* check if a city is selected
     * if a city is selected we update the data
     */
    int errcode = 0;

    if (m_id != 0)
    {
        m_url = "http://api.openweathermap.org/data/2.5/weather?appid=0c42f7f6b53b244c78a418f4f181282a&id="+ QString::number(m_id);

        getHTTPJSon();
        /* Handling errors
         * Code : 200 => City found
         * Any other value: Errors code then display message
         */
        errcode = (*data).value("cod").toInt();
        if (errcode == 200)
        {
            // Updating air humidity
            updateAirHumGH();
            // Updating icon
            setIcon();
            // Updating temperature
            updateTempGH();
            // Update sunrise
            setDayTime();
            // Emit job is done signals
            emit weatherUpdate();
        }
        else
        {
            errWeatherUpdate();
        }
    }
    // Updating greenhouse's temperature and humidity
    setTempGH();
    setHAirGH();
    setHGndGH();
}

void Weather::errSearch()
{
    QMessageBox msgBox;
    msgBox.setText("Veuillez remplir les deux champs avant de lancer une recherche.");
    msgBox.exec();
}

void Weather::sendRequest(int id, const QString &msg1, const QString &msg2)
{
    // button start
    setUrl(id, msg1, msg2);
    // Start HTTP request
    // Configure the HTTP request for retrieving Json
    getHTTPJSon();

    /* Handling errors
     * Code : 200 => City found
     * Any other value: Errors code then display message
     */

    int errcode = (*data).value("cod").toInt();
    if (errcode == 200)
    {
        // Setting weather information members to display
        m_city = (*data).value("name").toString();
        m_country = (*data)["sys"].toObject()["country"].toString();
        m_id = data->value("id").toInt();
        setDayTime();
        updateTempGH();
        updateAirHumGH();
        setIcon();


        // Emit job is done signals
        emit weatherUpdate();
    }
    else // Handling errors
    {
        // Display error message in new a Window
        errWeatherUpdate();
    }

    /*
     * Start automatic update
     * Frequency : once every minute
     */
    if (!(m_timer->isActive()))
        m_timer->start();
}

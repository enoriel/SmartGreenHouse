#include "serialcom.h"

serialCom::serialCom(QObject *parent) : QObject(parent)
{
    m_serial = new QSerialPort(this);

    // Errors
    connect(m_serial,static_cast<void (QSerialPort::*)(QSerialPort::SerialPortError)>(&QSerialPort::error),this,&serialCom::handleError);
    // Gestion de la lecture
    connect(m_serial,&QSerialPort::readyRead,this,&serialCom::read);
    /* Serial port configuration
     * Baudrate : 9600
     * Port : ttyUSB0
     * 1 bytes data
     * 1 stop bit
     */
    m_serial->setPortName(m_port);
    m_serial->setBaudRate(QSerialPort::Baud9600);
    m_serial->setDataBits(QSerialPort::Data8);
    m_serial->setStopBits(QSerialPort::OneStop);
    m_serial->setParity(QSerialPort::NoParity);
    m_serial->setFlowControl(QSerialPort::NoFlowControl);

//    if(!m_serial->open(QIODevice::ReadWrite))
//    {
//        QMessageBox msgBox;
//        // Debug message for developpers
//        qDebug() <<QObject::tr("Impossible d'ouvrir le port série %1...").arg(m_serial->portName());
//        // Error message for users
//        msgBox.setText("Connexion à la serre impossible. Si le problème persiste contactez l'assistance.");
//        msgBox.exec();
//    }
}

void serialCom::handleError(QSerialPort::SerialPortError error)
{
    if(error==QSerialPort::ResourceError)
    {
        // Error message
        QMessageBox msgBox;
        qDebug() <<QObject::tr("Erreur critique : %1").arg(m_serial->errorString());
        msgBox.setText("Erreur critique : %1."+m_serial->errorString());
        msgBox.exec();
    }
}

void serialCom::read()
{
    // Store the new data in buffer
    m_buffer = m_buffer + m_serial->readAll();
    qDebug() << m_buffer;
    if (m_buffer.contains(error_reply))
    {
        qDebug() << "error" << endl;
        errorCommand();
        // Clean buffer
        m_buffer = "";
    }
    else if (m_buffer.contains(temp_reply))
    {
        emit tempReady();
        // Clean buffer
        m_buffer = "";
    }
    else if (m_buffer.contains(humi_air_reply))
    {
        emit hAirReady();
        qDebug() << "air hum" << endl;
        // clean buffer
        m_buffer = "";
    }
    else if (m_buffer.contains(humi_ground_reply))
    {
        emit hGndReady();
        qDebug() << "hum gnd" << endl;
        // Clean buffer
        m_buffer = "";
    }
    else if (m_buffer.contains("OK\r\n"))
    {
        // Clean buffer
        m_buffer = "";
    }
    // Parsing response to GH sensors
    else if (m_buffer.contains("Degre Celsius"))
    {
        emit s_tempGH(m_buffer);
        // Clean buffer
        m_buffer = "";
    }
    else if (m_buffer.contains("Pourcent"))
    {
        // Air and soil humidity
        if (m_cmd == "h")
            emit s_airGH(m_buffer);
        else if(m_cmd == "s")
            emit s_gndGH(m_buffer);
        m_buffer = "";
    }
}

void serialCom::close()
{
    m_serial->close();
}

void serialCom::sendCommand(QString msg)
{
    m_serial->write(msg.toLocal8Bit());
    m_cmd = msg;
    m_serial->waitForBytesWritten();
}

void serialCom::errorCommand()
{
    QMessageBox msgBox;
    qDebug() <<QObject::tr("Erreur commande.");
    msgBox.setText("Erreur commande.");
    msgBox.exec();
    // Clean buffer
    m_buffer = "";
}

void serialCom::waitForAnswer()
{
    m_serial->waitForReadyRead();
}

/* openCom()
 * Open serial port
 * return -1 in case of error
 */
int serialCom::openCom()
{
    if(!m_serial->open(QIODevice::ReadWrite))
    {
        QMessageBox msgBox;
        // Debug message for developpers
        qDebug() <<QObject::tr("Impossible d'ouvrir le port série %1...").arg(m_serial->portName());
        // Error message for users
        msgBox.setText("Connexion à la serre impossible. Si le problème persiste contactez l'assistance.");
        msgBox.exec();
        return -1;
    }
    else
    {
        return 0;
    }
}

//serialCom::~serialCom()
//{
//    delete m_serial;
//}

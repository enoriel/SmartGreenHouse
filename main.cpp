#include <QApplication>
#include <QQmlApplicationEngine>
#include "weather.h"
#include "backlight.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qmlRegisterType<Weather>("bordeaux.ynov.com", 1, 0, "Weather");
    qmlRegisterType<BackLight>("bordeaux.ynov.com", 1, 0, "BackLight");

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

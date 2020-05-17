#ifndef CONTENIDOR_H
#define CONTENIDOR_H

#include <QMqttClient>
#include <QObject>
#include <QString>
#include <QStringListModel>


class Contenidor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString idContenidor READ idContenidor WRITE setIdContenidor NOTIFY idContenidorChange)
    Q_PROPERTY(QString producte READ producte WRITE setProducte NOTIFY producteChange)
    Q_PROPERTY(QStringList listModel READ listModel WRITE setListModel NOTIFY listModelChange)
    Q_PROPERTY(QString lat READ lat WRITE setLat NOTIFY latChanged)
    Q_PROPERTY(QString lon READ lon WRITE setLon NOTIFY lonChanged)
    Q_PROPERTY(QString temperatura READ temperatura WRITE setTemperatura NOTIFY temperaturaChange)
    Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChange)
    Q_PROPERTY(QStringList listModelContenidors READ listModelContenidors WRITE setListModelContenidors NOTIFY listModelContenidorsChange)


public:
    explicit Contenidor(QObject *parent = nullptr);

    QString idContenidor();
    Q_INVOKABLE void setIdContenidor(const QString &idContenidor);

    QString producte();
    void setProducte(const QString &producte);

    QStringList listModel();
    void setListModel(const QStringList &listmodel);

    QStringList listModelContenidors();
    void setListModelContenidors(const QStringList &listModelContenidors);

    QString lat();
    void setLat(const QString &lat);

    QString lon();
    void setLon(const QString &lon);

    QString temperatura();
    void setTemperatura(const QString &temperatura);

    QString data();
    void setData(const QString &data);

    void unsubscribe(QString text);
    void connecta();

    Q_INVOKABLE void afegirContenidor(QString idCont,QString prod);
    Q_INVOKABLE bool demanaLlistaContenidors();
    Q_INVOKABLE bool subscribe(QString text);
    Q_INVOKABLE bool comprovaContenidor(QString ct);
    Q_INVOKABLE bool demanaContenidor(QString cnt);
    Q_INVOKABLE bool editaContenidor(QString idCont, QString prod, QString temp, QString lat, QString lon);
    Q_INVOKABLE bool demanaContenidorHistoric(QString cnt);

signals:
    void idContenidorChange();
    void producteChange();
    void listModelChange();
    void listModelContenidorsChange();
    void latChanged();
    void lonChanged();
    void temperaturaChange();
    void dataChange();

private:
    QString m_data;
    QString m_idContenidor;
    QString m_producte;
    QMqttClient *m_client;
    QStringList m_listModel;
    QString m_temperatura;
    QString m_lat="41.385313";
    QString m_lon="2.143071";
    QStringList m_listModelContenidors;

};

#endif // CONTENIDOR_H

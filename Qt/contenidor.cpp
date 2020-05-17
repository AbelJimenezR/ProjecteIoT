#include "contenidor.h"

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMqttMessage>


Contenidor::Contenidor(QObject *parent) :
    QObject(parent)

{
    m_client = new QMqttClient(this);
    m_client->setHostname("broker.hivemq.com");
    m_client->setPort(1883);

    connect(m_client, &QMqttClient::messageReceived, this, [this](const QString &message, const QMqttTopicName &topic) {
        //QStringList listModel;

        QJsonDocument temp = QJsonDocument::fromJson(message.toUtf8());
        QJsonArray jArray = temp.array();

        //qDebug()<<topic;
        if(topic.name()=="repContenidors"){
            m_listModel.clear();
            foreach (const QJsonValue & value, jArray) {
                QJsonObject obj = value.toObject();
                qDebug()<<obj["distinct"].toString();
                m_listModel.append(obj["distinct"].toString());

            }
            emit listModelChange();

        }
        if(topic.name()=="repContenidorInici"){
            //if(temp[0]["id"].toString()==m_idContenidor){

            QStringList pa = temp[0]["time"].toString().split("T");
            QStringList pc = pa[1].split(".");

            //setData(temp[0]["time"].toString());
            setData(pa[0]+" / "+pc[0]);
            setLat(temp[0]["lat"].toString());
            setLon(temp[0]["lon"].toString());
            setIdContenidor(temp[0]["id"].toString());
            setTemperatura(temp[0]["temperatura"].toString());
            setProducte(temp[0]["product"].toString());

            //qDebug()<<temp[0]["time"];
         //   }
        }

        if(topic.name()=="repContenidor"){
            if(temp["id"].toString()==m_idContenidor){

                    setLat(temp["lat"].toString());
                    setLon(temp["lon"].toString());
                    setIdContenidor(temp["id"].toString());
                    setTemperatura(temp["temp"].toString());
                    setProducte(temp[0]["product"].toString());

                   // qDebug()<<m_idContenidor;
                }
        }

        if(topic.name()=="repContenidorHistoric"){
            m_listModelContenidors.clear();
            foreach (const QJsonValue & value, jArray) {
                QJsonObject obj = value.toObject();
                QJsonDocument doc(obj);
                m_listModelContenidors.append(obj["lat"].toString()+","+obj["lon"].toString()+
                        ","+obj["temperatura"].toString()+","+obj["id"].toString());


            }
            emit listModelContenidorsChange();

            qDebug()<<"holi";

        }


    });

    m_client->connectToHost();

}

void Contenidor::afegirContenidor(QString idCont,QString prod)
{
    QJsonObject q;
    q["id"]=idCont;
    q["product"]=prod;

    QJsonDocument doc(q);
    QByteArray bytes = doc.toJson();


    QString topic = "nouContenidor";
    if (m_client->publish(topic, bytes  ) == -1){
        qDebug()<<"Error de publicació";

    }else{
        qDebug()<<"Publicat correctament";
    }

    m_listModel.append(idCont);
    emit listModelChange();
}

bool Contenidor::editaContenidor(QString idCont,QString prod,QString temp, QString lat, QString lon)
{
    QJsonObject q;
    q["id"]=idCont;
    q["product"]=prod;
    q["lat"]=lat;
    q["lon"]=lon;
    q["temperatura"]=temp;

    QJsonDocument doc(q);
    QByteArray bytes = doc.toJson();

    QString topic = "nouContenidor";
    if (m_client->publish(topic, bytes  ) == -1){
        qDebug()<<"Error de publicació";
        return false;
    }else{
        qDebug()<<"Publicat correctament";
        return true;
    }

}

bool Contenidor::demanaLlistaContenidors(){
    QString topic = "demanaInici";
    if (m_client->publish(topic, "a") == -1){
        qDebug()<<"Error de publicació";
        return false;
    }else{
        qDebug()<<"Publicat correctament";
        return true;
    }
}

bool Contenidor::demanaContenidor(QString cnt){
    QString topic = "demanaContenidor";
    qDebug()<<"demanat";
    if (m_client->publish(topic, cnt.toUtf8()) == -1){
        qDebug()<<"Error de publicació";
        return false;
    }else{
        qDebug()<<"Publicat correctament";
        return true;
    }

}

bool Contenidor::demanaContenidorHistoric(QString cnt){
    QString topic = "demanaContenidorHistoric";
    QString m = "1";
    QJsonObject q;

    q["id"]=cnt;
    q["transport"]=m;

    QJsonDocument doc(q);
    QByteArray bytes = doc.toJson();


    qDebug()<<"demanat";
    if (m_client->publish(topic, bytes) == -1){
        qDebug()<<"Error de publicació";
        return false;
    }else{
        qDebug()<<"Publicat correctament";
        return true;
    }

}





QString Contenidor::idContenidor()
{
    return m_idContenidor;
}

void Contenidor::setIdContenidor(const QString &idContenidor)
{
    if (idContenidor == m_idContenidor)
        return;

    m_idContenidor = idContenidor;
    emit idContenidorChange();
}

QString Contenidor::producte()
{
    return m_producte;
}

void Contenidor::setProducte(const QString &producte)
{
    if (producte == m_producte)
        return;

    m_producte = producte;
    emit producteChange();
}

QStringList Contenidor::listModel()
{
    return m_listModel;
}

void Contenidor::setListModel(const QStringList &listModel)
{
    if (listModel == m_listModel)
        return;

    m_listModel = listModel;
    emit listModelChange();
}

QStringList Contenidor::listModelContenidors()
{
    return m_listModelContenidors;
}

void Contenidor::setListModelContenidors(const QStringList &listModelContenidors)
{
    if (listModelContenidors == m_listModelContenidors)
        return;
    m_listModelContenidors = listModelContenidors;
    emit listModelContenidorsChange();
}


QString Contenidor::lat()
{
    return m_lat;
}

void Contenidor::setLat(const QString &lat)
{
    if (lat == m_lat)
        return;

    m_lat = lat;
    emit latChanged();
}

QString Contenidor::lon()
{
    return m_lon;
}

void Contenidor::setLon(const QString &lon)
{
    if (lon == m_lon)
        return;

    m_lon = lon;
    emit lonChanged();
}

QString Contenidor::temperatura()
{
    return m_temperatura;
}

void Contenidor::setTemperatura(const QString &temperatura)
{
    if (temperatura == m_temperatura)
        return;
    m_temperatura = temperatura;
    emit temperaturaChange();
}

QString Contenidor::data()
{
    return m_data;
}

void Contenidor::setData(const QString &data)
{
    if (data == m_data)
        return;
    m_data = data;
    emit dataChange();
}



bool Contenidor::subscribe(QString text)
{
    auto subscription = m_client->subscribe(text);

    if (!subscription) {
        qDebug()<<"No Subscribe";
        return false;
        //QMessageBox::critical(this, QLatin1String("Error"), QLatin1String("Could not subscribe. Is there a valid connection?"));
    }else{
        qDebug()<<"Subscripció correcta";
        return true;
    }

}

void Contenidor::unsubscribe(QString text){

    m_client->unsubscribe(text);

}

void Contenidor::connecta(){
    if (m_client->state() == QMqttClient::Disconnected) {
        qDebug()<<"disconnected";
        m_client->connectToHost();
    } else {
        // m_client->disconnectFromHost();
        qDebug()<<"connected";
    }
}

bool Contenidor::comprovaContenidor(QString ct){
    qDebug()<<ct.length();
    foreach (const QString &str, m_listModel) {
        if (str.contains(ct)||ct.length()!=5)
            return true;
    }
    return false;
}

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

        QJsonDocument temp = QJsonDocument::fromJson(message.toUtf8());
        QJsonArray jArray = temp.array();

        if(topic.name()=="repContenidors"){
            m_listModel.clear();
            foreach (const QJsonValue & value, jArray) {
                QJsonObject obj = value.toObject();
                m_listModel.append(obj["distinct"].toString());
            }
            emit listModelChange();
        }

        if(topic.name()=="repContenidorInici"){

            setData(temp[0]["time"].toString());
            setLat(temp[0]["latitude"].toString());
            setLon(temp[0]["longitude"].toString());
            setIdContenidor(temp[0]["id"].toString());
            setTemperatura(temp[0]["temperature"].toString());
            setProducte(temp[0]["product"].toString());
            setIdTransport(temp[0]["transport"].toString()); 
        }

        if(topic.name()=="repContenidor"){
            if(temp["id"].toString()==m_idContenidor){
                setLat(temp["latitude"].toString());
                setLon(temp["longitude"].toString());
                setIdContenidor(temp["id"].toString());
                setTemperatura(temp["temperature"].toString());
                setProducte(temp["product"].toString());
                setData(temp["time"].toString());
                setIdTransport(temp["transport"].toString());
                emit listModelChange();
                m_listModelContenidors.append(temp["latitude"].toString()+","+temp["longitude"].toString()+
                        ","+temp["temperature"].toString()+","+temp["id"].toString()+","+temp["transport"].toString()+
                        ","+temp["product"].toString()+","+temp["time"].toString());
                emit listModelContenidorsChange();

            }
        }

        if(topic.name()=="repContenidorHistoric"){
            m_listModelContenidors.clear();
            foreach (const QJsonValue & value, jArray) {
                QJsonObject obj = value.toObject();
                QJsonDocument doc(obj);
                m_listModelContenidors.append(obj["latitude"].toString()+","+obj["longitude"].toString()+
                        ","+obj["temperature"].toString()+","+obj["id"].toString()+","+obj["transport"].toString()+
                        ","+obj["product"].toString()+","+obj["time"].toString());
            }

            emit listModelContenidorsChange();


        }


    });

    m_client->connectToHost();

}

void Contenidor::afegirContenidor(QString idCont,QString prod)
{
    QJsonObject q;
    q["id"]=idCont;
    q["product"]=prod;
    q["transport"]="1";

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
    qDebug()<<"hola";
}

bool Contenidor::editaContenidor(QString idCont,QString prod,QString temp, QString lat, QString lon,QString transport)
{
    QJsonObject q;
    q["id"]=idCont;
    q["product"]=prod;
    q["latitude"]=lat;
    q["longitude"]=lon;
    q["temperature"]=temp;
    q["transport"]=transport;

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

bool Contenidor::demanaInici(){
    QString topic = "demanaInici";
    if (m_client->publish(topic, "a") == -1){
        qDebug()<<"Error de publicació";
        return false;
    }else{
        qDebug()<<"Publicat correctament";
        return true;
    }
}

bool Contenidor::demanaContenidorInici(QString cnt){
    QString topic = "demanaContenidorInici";
    qDebug()<<"demanat";
    if (m_client->publish(topic, cnt.toUtf8()) == -1){
        qDebug()<<"Error de publicació";
        return false;
    }else{
        qDebug()<<"Publicat correctament";
        return true;
    }

}

bool Contenidor::demanaContenidorHistoric(QString cnt,QString tr){
    QString topic = "demanaContenidorHistoric";
    QString m = "1";
    QJsonObject q;

    q["id"]=cnt;
    q["transport"]=tr;

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

QString Contenidor::idTransport()
{
    return m_idTransport;
}

void Contenidor::setIdTransport(const QString &idTransport)
{
    if (idTransport == m_idTransport)
        return;
    m_idTransport = idTransport;
    emit idTransportChange();
}



bool Contenidor::subscribe(QString text)
{
    auto subscription = m_client->subscribe(text);

    if (!subscription) {
        qDebug()<<"No Subscribe";
        return false;
    }else{
        qDebug()<<"Subscripció correcta";
        return true;
    }

}

void Contenidor::unsubscribe(){

    //m_client->disconnectFromHost();

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

void Contenidor::setCredentials(QString username, QString password){
    m_client->setPassword(password);
    m_client->setUsername(username);

}



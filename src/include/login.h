#ifndef LOGIN_H
#define LOGIN_H

#include <QObject>
#include <QDebug>
#include <QSqlDatabase>
#include <QtSql>
#include <QSqlQuery>
#include <QVector>


class LoginAuth: public QObject {
    Q_OBJECT
public:
    LoginAuth();
    Q_INVOKABLE bool login(QString username, QString password);
private:
    QSqlQuery *qry;
};

#endif

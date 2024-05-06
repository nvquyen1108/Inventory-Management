#include "../include/login.h"

LoginAuth::LoginAuth()
:qry(new QSqlQuery)
{

}

bool LoginAuth::login(QString username, QString password){
    QString encodedPass = QString(QCryptographicHash::hash(password.toUtf8().toBase64(),QCryptographicHash::Md5).toHex());

//    qDebug() << "Encoded string is" << encodedPass;

    qry->prepare("SELECT COUNT(*) FROM Users WHERE UserName = :username AND Password = :pass");
    qry->bindValue(":username", username);
    qry->bindValue(":pass", encodedPass);

    if (qry->exec() && qry->next()) {
        int count = qry->value(0).toInt();
        return count > 0;
    }
    return false;
}

#ifndef DATABASE_H
#define DATABASE_H

//#include <QMessageBox>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QSqlQueryModel>

static bool createConnection()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");

    if (!db.isValid()) {
        qWarning() << "Failed to create database connection.";
    }
    db.setDatabaseName("QUANLY_KHOHANG");
    db.setHostName("localhost");
    db.setPort(5432);
    db.setUserName("postgres");
    db.setPassword("123456");
    if (!db.isOpen()) {
        if (!db.open()) {
            qWarning() << "Failed to open database:" << db.lastError().text();
        }
    }
    QSqlQuery query;

    QStringList tableList = db.tables();
    if(!tableList.contains("Input", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS Input ("
                   "Id varchar(128) NOT NULL PRIMARY KEY, "
                   "IdObject varchar(128) NOT NULL, "
                   "Count float default 0,"
                   "Price float default 0,"
                   "DateInput timestamp"
                   ")");
        qDebug() << "create table Input";
        query.exec("CREATE SEQUENCE input_id_seq ");
    }
    if(!tableList.contains("InputInfo", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS InputInfo ("
                      "IdObject varchar(128) NOT NULL PRIMARY KEY, "
                      "IdInput varchar(128) NOT NULL,"
                      "Count float default 0,"
                      "InputPrice float default 0,"
                      "Note TEXT,"
                      "Image TEXT"
                      ")");
        qDebug() << "create table InputInfo";
        query.exec("ALTER TABLE InputInfo ADD FOREIGN KEY (IdInput) REFERENCES Input(Id);");
        query.exec("ALTER TABLE InputInfo ADD FOREIGN KEY (IdObject) REFERENCES Object(Id);");
    }
    if(!tableList.contains("Object", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS Object ("
                      "Id varchar(128) UNIQUE NOT NULL PRIMARY KEY, "
                      "DisplayName varchar(255), "
                      "IdUnit int NOT NULL,"
                      "IdSuplier int NOT NULL,"
                      "QRCode varchar(255),"
                      "BarCode varchar(255),"
                      "Note TEXT,"
                      "Image TEXT"
                      ")");
        qDebug() << "create table Object";
        query.exec("CREATE SEQUENCE object_id_seq ");
        query.exec("ALTER TABLE Object ADD FOREIGN KEY (IdUnit) REFERENCES Unit(Id);");
        query.exec("ALTER TABLE Object ADD FOREIGN KEY (IdSuplier) REFERENCES Suplier(Id);");
    }
    if(!tableList.contains("Output", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS Output ("
                      "Id varchar(128) NOT NULL PRIMARY KEY, "
                      "IdObject varchar(128) NOT NULL, "
                      "Count float default 0,"
                      "DateOutput timestamp"
                      ")");
        qDebug() << "create table Output";
        query.exec("CREATE SEQUENCE output_id_seq ");
    }
    if(!tableList.contains("OutputInfo", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS OutputInfo ("
                      "Id varchar(128) NOT NULL PRIMARY KEY, "
                      "IdObject varchar(128) NOT NULL, "
                      "IdOutput varchar(128) NOT NULL,"
                      "Count float default 0,"
                      "Note varchar(255)"
                      ")");
        qDebug() << "create table OutputInfo";
        query.exec("CREATE SEQUENCE outputInfo_id_seq ");
        query.exec("ALTER TABLE OutputInfo ADD FOREIGN KEY (IdOutput) REFERENCES Output(Id);");
        query.exec("ALTER TABLE OutputInfo ADD FOREIGN KEY (IdObject) REFERENCES Object(Id);");
    }
    if(!tableList.contains("Suplier", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS Suplier ("
                      "Id SERIAL NOT NULL PRIMARY KEY, "
                      "DisplayName varchar(255), "
                      "Address varchar(255),"
                      "Email varchar(200) UNIQUE,"
                      "Phone varchar(20),"
                      "MoreInfo varchar(255),"
                      "LogoFile text,"
                      "ContractDate timestamp"
                      ")");
        qDebug() << "create table Suplier";
    }
    if(!tableList.contains("Unit", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS Unit ("
                   "Id SERIAL NOT NULL PRIMARY KEY, "
                   "DisplayName varchar(255)"
                   ")");
        qDebug() << "create table Unit";
    }
    if(!tableList.contains("UserRole", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS UserRole ("
                      "Id SERIAL NOT NULL PRIMARY KEY, "
                      "DisplayName varchar(255)"
                      ")");
        qDebug() << "create table UserRole";
        query.exec("insert into UserRole values(1, 'Admin')");
        query.exec("insert into UserRole values(2, 'Staff')");
    }
    if(!tableList.contains("Users", Qt::CaseInsensitive)){
        query.exec("CREATE TABLE IF NOT EXISTS Users ("
                      "Id SERIAL NOT NULL PRIMARY KEY, "
                      "DisplayName varchar(255),"
                      "UserName varchar(100),"
                      "Password varchar(255),"
                      "IdRole int NOT NULL"
                      ")");
        qDebug() << "create table Users";
        query.exec("insert into Users values(1, 'Admin','admin','db69fc039dcbd2962cb4d28f5891aae1',1)");
        query.exec("insert into Users values(2, 'nhan vien','staff','978aae9bb6bee8fb75de3e4830a1be46',2)");
        query.exec("ALTER TABLE Users ADD FOREIGN KEY (IdRole) REFERENCES UserRole(Id);");
    }

    return true;
}

#endif // DATABASE_H


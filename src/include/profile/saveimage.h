#ifndef SAVEIMAGE_H
#define SAVEIMAGE_H

#include <QCoreApplication>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QFile>
#include <QDir>
#include <QUrl>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlError>
#include <QImage>


class SaveImages: public QObject {
    Q_OBJECT
public:
//    SaveImages();
    explicit SaveImages(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void save_images(const QString& imageUrl, const QString& saveDirectory);
    Q_INVOKABLE void copyImage(const QString& sourcePath, const QString& destinationDirectory);
    Q_INVOKABLE void saveImageToServer(const QString& imagePath, const QString& serverPath);
    Q_INVOKABLE void saveImageToDatabase(const QString& imagePath);
};
#endif // SAVEIMAGE_H

#include "imageprovider.h"
#include <QQuickImageProvider>
#include <QUrl>
#include <QImage>
#include <QSqlQuery>

ImageProvider::ImageProvider()
: QQuickImageProvider(QQuickImageProvider::Image)
{

}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(requestedSize);

    // Assume you have a database connection 'database' available
    QSqlQuery query("SELECT LogoFile FROM Suplier WHERE Id = :id");
    query.bindValue(":id", id.toInt());
    if (!query.exec() || !query.next()) {
        qDebug() << "Failed to execute query:" << query.lastError().text();
        return QImage();
    }

    QByteArray imageData = query.value("image_data").toByteArray();
    QImage image;
    image.loadFromData(imageData);

    if (size)
        *size = image.size();

    return image;
}

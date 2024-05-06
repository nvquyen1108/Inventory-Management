#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QUrl>
#include <QImage>
#include <QSqlQuery>
#include <QSqlError>

class ImageProvider : public QQuickImageProvider {
public:
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
    ImageProvider();
};

#endif // IMAGEPROVIDER_H

#include "src/include/profile/saveimage.h"

void SaveImages::save_images(const QString &sourcePath, const QString &destinationDirectory)
{
    QString fileName = QFileInfo(sourcePath).fileName();
    QString destinationPath = destinationDirectory + "/" + fileName;

    QFile sourceFile(sourcePath);
    QFile destinationFile(destinationPath);

    if (sourceFile.open(QIODevice::ReadOnly) && destinationFile.open(QIODevice::WriteOnly)) {
        QByteArray imageData = sourceFile.readAll();
        destinationFile.write(imageData);

        qDebug() << "Image file copied to:" << destinationPath;
    } else {
        qDebug() << "Failed to copy image file";
    }

    sourceFile.close();
    destinationFile.close();
}
void SaveImages::copyImage(const QString& sourcePath, const QString& destinationDirectory) {
    QString fileName = QFileInfo(sourcePath).fileName();
    QString destinationPath = destinationDirectory + "/" + fileName;

    QFile sourceFile(sourcePath);
    QFile destinationFile(destinationPath);
    qDebug() << sourcePath << destinationPath << destinationDirectory;
    if (sourceFile.open(QIODevice::ReadOnly) && destinationFile.open(QIODevice::WriteOnly)) {
        QByteArray imageData = sourceFile.readAll();
        destinationFile.write(imageData);

        qDebug() << "Image file copied to:" << destinationPath;
    } else {
        qDebug() << "Failed to copy image file";
    }

    sourceFile.close();
    destinationFile.close();
}
void SaveImages::saveImageToServer(const QString& imagePath, const QString& serverPath)
{
    QString fileName = QFileInfo(imagePath).fileName();
    QFile imageFile(fileName);
    if (!imageFile.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open image file:" << imagePath;
        return;
    }

    // Tạo đường dẫn đến thư mục lưu trữ trên máy chủ (nếu chưa tồn tại)
    QDir serverDir;
    if (!serverDir.mkpath(serverPath)) {
        qDebug() << "Failed to create server directory:" << serverPath;
        return;
    }

    // Tạo đường dẫn đầy đủ đến tệp tin hình ảnh trên máy chủ
    QString serverImagePath = serverPath + "/" + QFileInfo(imagePath).fileName();

    // Đọc dữ liệu từ tệp tin hình ảnh nguồn
    QByteArray imageData = imageFile.readAll();
    imageFile.close();

    // Lưu dữ liệu vào tệp tin hình ảnh trên máy chủ
    QFile serverImageFile(serverImagePath);
    if (!serverImageFile.open(QIODevice::WriteOnly)) {
        qDebug() << "Failed to save image file to server:" << serverImagePath;
        return;
    }
    serverImageFile.write(imageData);
    serverImageFile.close();

    qDebug() << "Image saved to server:" << serverImagePath;
}
void SaveImages::saveImageToDatabase(const QString& imagePath)
{
    QString fileName = QFileInfo(imagePath).fileName();
    QFile file(fileName);

    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open image file:" << imagePath;
        return;
    }

    QByteArray imageData = file.readAll();
    file.close();

    QSqlQuery query;
    query.prepare("INSERT INTO Object (image) VALUES (:image_data)");
    query.bindValue(":image_data", imageData);
    if (!query.exec()) {
        qDebug() << "Failed to save image to database.";
        return;
    }

    qDebug() << "Image saved to database.";
}

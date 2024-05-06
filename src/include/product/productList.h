#ifndef PRODUCTLIST_H
#define PRODUCTLIST_H

#include <QAbstractListModel>
#include <QHash>
#include <QList>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlError>
#include <QImage>
#include <QUrl>



class ProductList : public QAbstractListModel {
    Q_OBJECT

public:
    enum ProductRole {
        Id = Qt::UserRole + 1,
        DisplayName,
        IdUnit,
        IdSuplier,
        QRCode,
        BarCode,
        Note,
        ImageFile
    };
    Q_ENUM(ProductRole)
    struct Product {
        QString id;
        QString displayName;
        QString idUnit;
        QString idSuplier;
        QString qrCode;
        QString barCode;
        QString note;
        QString imageFile;
    };

    explicit ProductList(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;

    void loadTableFromDatabase();

    Q_INVOKABLE QVariantMap get(int row) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
//    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    Q_INVOKABLE bool append(const QString &productName, const QString &unitName, const QString &supplierName,const QString &qrCode, const QString &barCode, const QString &note, const QString &image);
    Q_INVOKABLE bool updateData(int row, const QString &id, const QString &productName, const QString &unitName, const QString &supplierName, const QString &qrCode,const QString &barCode, const QString &note, const QString &image);
    Q_INVOKABLE void remove(int row, const QString &displayName);
//    Q_INVOKABLE void setData(const QModelIndex &parent,const QVariant &value,int role = Qt::EditRole);
    Q_INVOKABLE void refresh();
    Q_INVOKABLE QString getIdOnName(const QString &displayName);
    Q_INVOKABLE QStringList getNameOnSupplier(const QString &displayName);

private:

    QSqlQuery *qry;
    QList<Product> m_products;
};

#endif //

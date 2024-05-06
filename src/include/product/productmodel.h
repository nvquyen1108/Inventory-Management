#ifndef PRODUCTMODEL_H
#define PRODUCTMODEL_H

#include <QAbstractTableModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QUrl>

class ProductModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit ProductModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    Q_INVOKABLE bool append(const QString &productName, const QString &unitName, const QString &supplierName,const QString &qrCode, const QString &barCode, const QString &note, const QString &image);
    Q_INVOKABLE bool updateData(int row, const QString &id, const QString &productName, const QString &idUnit, const QString &idSupplier, const QString &qrCode,const QString &barCode, const QString &note, const QString &image);
    Q_INVOKABLE void remove(int row, const QString &id);
    Q_INVOKABLE void refresh();

    void loadTableFromDatabase();
    Q_INVOKABLE void getName(const QString displayName);
//    Q_INVOKABLE void setSupplier(const QString &idSupplier);

private:
    QSqlQuery *qry;
    QList<QList<QVariant>> m_data;

};
#endif // PRODUCTMODEL_H

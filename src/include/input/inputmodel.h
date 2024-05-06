#ifndef INPUTMODEL_H
#define INPUTMODEL_H

#include <QAbstractTableModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QUrl>

class InputModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit InputModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    Q_INVOKABLE bool append(const QString &productName, const QString &unitName, const QString &supplierName,const QString &qrCode, const QString &barCode, const QString &note, const QString &image);
    Q_INVOKABLE bool updateData(int row, const QString &id, const QString &productName, const QString &idUnit, const QString &idSupplier, const QString &qrCode,const QString &barCode, const QString &note, const QString &image);
    Q_INVOKABLE void remove(int row, const QString &id);
    Q_INVOKABLE void set();

    void loadTableFromDatabase();
//    Q_INVOKABLE void setSupplier(const QString &idSupplier);

private:
    QSqlQuery *qry;
    QList<QList<QVariant>> m_input;

};
#endif // InputModel

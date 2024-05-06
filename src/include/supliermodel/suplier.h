#ifndef SUPLIER_H
#define SUPLIER_H

#include <QSqlRelationalTableModel>
#include <QQmlParserStatus>

#include <QSqlDriver>
#include <QSqlRecord>
#include <QSqlField>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlIndex>
#include <QDateTime>
#include <QItemSelectionModel>
#include <QUrl>
#include <QLoggingCategory>
#include <QImage>
#include <QAbstractTableModel>

class Suplier: public QAbstractTableModel
{
    Q_OBJECT

public:
    explicit Suplier(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    Q_INVOKABLE bool append(const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo, const QString &logoFile);

    void loadTableFromDatabase();
    Q_INVOKABLE bool insertRows(int row, int count, const QModelIndex &parent,const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo);
    Q_INVOKABLE bool setData(const QModelIndex &index, const QVariant &value, int role);

private:
    QSqlQuery *qry;
    QSqlQueryModel *model;
    QList<QList<QVariant>> m_data;
};

#endif // SUPLIER_H

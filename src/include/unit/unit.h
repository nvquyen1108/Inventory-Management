#ifndef UNIT_H
#define UNIT_H

#include <QAbstractListModel>
#include <QHash>
#include <QList>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>

class Unit : public QAbstractListModel {
    Q_OBJECT
public:
    enum UnitRole {
        Id = Qt::UserRole + 1,
        UnitName
    };
    Q_ENUM(UnitRole)
    struct UnitStruct {
        QString id;
        QString unitName;
    };

    explicit Unit(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    void loadDataFromDatabase();

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE bool append(const QString &unitName);
    Q_INVOKABLE void updateData(int row,const QString &unitName);
    Q_INVOKABLE void remove(int row, const QString &unitName);
    Q_INVOKABLE QStringList getUnitOnObject(const QString &unitName);
private:

    QSqlQuery *qry;
    QList<UnitStruct> m_data;
};

#endif // UNIT_H

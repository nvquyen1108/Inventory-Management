#ifndef INVENTORYLIST_H
#define INVENTORYLIST_H

#include <QAbstractListModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QDate>
#include <QUrl>

class InventoryList : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ProductRole {
        DisplayName = Qt::UserRole + 1,
    };

    struct InventoryStruct {
        QString idObject;
    };

    explicit InventoryList(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void loadTableFromDatabase();

//    Q_INVOKABLE void refresh();
//    Q_INVOKABLE void loadTableFromDatabase(int currentMonth, int currentYear);
//    Q_INVOKABLE void currentMonthFunc(int currentMonth);
//    Q_INVOKABLE void currentYearFunc(int currentYear);

private:
    QSqlQuery *qry;
    QList<InventoryStruct> m_data;

};

#endif // INVENTORYLIST_H

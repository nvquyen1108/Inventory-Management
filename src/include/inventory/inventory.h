#ifndef INVENTORY_H
#define INVENTORY_H

#include <QAbstractTableModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QDate>
#include <QUrl>

class Inventory : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit Inventory(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const;
    Q_INVOKABLE void refresh();

    Q_INVOKABLE void loadTableFromDatabase(int currentMonth, int currentYear);
    Q_INVOKABLE void currentMonthFunc(int currentMonth);
    Q_INVOKABLE void currentYearFunc(int currentYear);

private:
    int currentMonth = 0;
    int currentYear = 0;
    QSqlQuery *qry;
    QList<QList<QVariant>> m_data;

};

#endif // INVENTORY_H

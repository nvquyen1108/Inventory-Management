#ifndef OUTPUTMODEL_H
#define OUTPUTMODEL_H

#include <QAbstractTableModel>
#include <QSqlQuery>
#include <QSqlError>
#include <QUrl>

class OutputModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit OutputModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
//    Q_INVOKABLE bool updateData(int row, const QString &id, const QString &productName, const QString &idUnit, const QString &idSupplier, const QString &qrCode,const QString &barCode, const QString &note, const QString &image);
//    Q_INVOKABLE void remove(int row, const QString &id);
//    Q_INVOKABLE void set();
    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool append(const QString &idObject, const QString &numberCount);

    void loadTableFromDatabase(int currentDay, int currentMonth, int currentYear);
    Q_INVOKABLE void currentDayFunc(int currentDay);
    Q_INVOKABLE void currentMonthFunc(int currentMonth);
    Q_INVOKABLE void currentYearFunc(int currentYear);

private:
    int currentDay = 0;
    int currentMonth = 0;
    int currentYear = 0;
    QSqlQuery *qry;
    QList<QList<QVariant>> m_output;
};

#endif // OUTPUTMODEL_H


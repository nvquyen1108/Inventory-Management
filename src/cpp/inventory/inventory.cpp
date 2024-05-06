#include "src/include/inventory/inventory.h"

Inventory::Inventory(QObject *parent)
    : QAbstractTableModel(parent),
    qry(new QSqlQuery)
{
    loadTableFromDatabase(currentMonth,currentYear);
}
void Inventory::currentMonthFunc(int currentMonth)
{
    this->currentMonth = currentMonth;
}
void Inventory::currentYearFunc(int currentYear)
{
    this->currentYear = currentYear;
}
void Inventory::loadTableFromDatabase(int currentMonth, int currentYear)
{
    qDebug() << "[Inventory Model] Constructing..." << currentMonth << currentYear;
    m_data.clear();
    QString s = "SELECT InputInfo.IdObject,Object.DisplayName,Unit.DisplayName,InputInfo.Count,InputInfo.InputPrice, EXTRACT(MONTH FROM Input.DateInput) AS month_number,EXTRACT(YEAR FROM Input.DateInput) AS year_number FROM InputInfo "
                "INNER JOIN Object ON InputInfo.IdObject = Object.Id "
                "INNER JOIN Unit ON Object.IdUnit = Unit.Id "
                "INNER JOIN Input ON InputInfo.IdInput = Input.Id "
                "WHERE EXTRACT(MONTH FROM Input.DateInput) = '%1' AND EXTRACT(YEAR FROM Input.DateInput) = '%2'";
    QString qryInventory = s.arg(QString::number(currentMonth),QString::number(currentYear));
    bool success = qry->exec(qryInventory);
    qDebug() << qryInventory << success;
    if (qry->exec(qryInventory)) {
        while (qry->next()) {
            QList<QVariant> row;
            row.append(qry->value("InputInfo.IdObject"));
            row.append(qry->value("Object.DisplayName"));
            row.append(qry->value("Unit.DisplayName"));
            row.append(qry->value("InputInfo.Count"));
            row.append(qry->value("InputInfo.InputPrice"));
            row.append(qry->value("month_number"));
            row.append(qry->value("year_number"));
            m_data.append(row);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}
//void Inventory::loadTableFromDatabase(int currentMonth, int currentYear)
//{
//    qDebug() << "[Inventory Model] Constructing..." << currentMonth << currentYear;
//    m_data.clear();
//    QString s = "SELECT Inventory.IdObject,Object.DisplayName,Unit.DisplayName,Inventory.Count,InputInfo.InputPrice,EXTRACT(MONTH FROM Input.DateInput) AS month_number,EXTRACT(YEAR FROM Input.DateInput) AS year_number FROM Inventory "
//                "INNER JOIN Object ON Inventory.IdObject = Object.Id "
//                "INNER JOIN Unit ON Object.IdUnit = Unit.Id "
//                "INNER JOIN InputInfo ON Inventory.IdInputInfo = InputInfo.Id "
//                "INNER JOIN Input ON InputInfo.IdInput = Input.Id "
//                "WHERE EXTRACT(MONTH FROM Input.DateInput) = '%1' AND EXTRACT(YEAR FROM Input.DateInput) = '%2'";
//    QString qryInventory = s.arg(QString::number(currentMonth),QString::number(currentYear));
//    bool success = qry->exec(qryInventory);
//    qDebug() << s << success;
//    if (qry->exec(qryInventory)) {
//        while (qry->next()) {
//            QList<QVariant> row;
//            row.append(qry->value("Inventory.IdObject"));
//            row.append(qry->value("Object.DisplayName"));
//            row.append(qry->value("Unit.DisplayName"));
//            row.append(qry->value("Inventory.Count"));
//            row.append(qry->value("InputInfo.InputPrice"));
//            row.append(qry->value("month_number"));
//            row.append(qry->value("year_number"));
//            m_data.append(row);
//        }
//    } else {
//        qDebug() << "Query failed:" << qry->lastError().text();
//    }
//}
int Inventory::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_data.size();
}

int Inventory::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    if (!m_data.isEmpty())
        return m_data.first().size();

    return 0;
}

QVariant Inventory::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Qt::DisplayRole)
        return QVariant();

    int row = index.row();
    int column = index.column();

    if (row < 0 || row >= m_data.size() || column < 0 || column >= m_data.first().size())
        return QVariant();

    return m_data[row][column];
}
QVariant Inventory::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role != Qt::DisplayRole || orientation != Qt::Horizontal)
        return QVariant();

    if (section < 0 || section >= m_data.first().size())
        return QVariant();

    // Return the header for the corresponding column
    return QString("Column %1").arg(section);
}
void Inventory::refresh()
{
    beginResetModel();
    loadTableFromDatabase(currentMonth,currentYear);
    endResetModel();
}

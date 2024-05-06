#include "src/include/inventory/inventoryList.h"

InventoryList::InventoryList(QObject *parent)
    : QAbstractListModel(parent),
    qry(new QSqlQuery)
{
    loadTableFromDatabase();
}
void InventoryList::loadTableFromDatabase()
{
    qDebug() << "[InventoryList Model] Constructing...";
    m_data.clear();
    QString s = "SELECT Object.DisplayName FROM InputInfo INNER Join Object ON InputInfo.IdObject = Object.Id ";
    bool success = qry->exec(s);
    qDebug() << s << success;
    if (qry->exec(s)) {
        while (qry->next()) {
            InventoryStruct row;
            row.idObject = qry->value("Object.DisplayName").toString();
            m_data.append(row);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}
int InventoryList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant InventoryList::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    switch (role) {
    case DisplayName: return m_data.at(index.row()).idObject;
    default: return QVariant();
    }

    return QVariant();
}

QHash<int, QByteArray> InventoryList::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[DisplayName] = "displayName";
    return roles;
}

//void InventoryList::refresh()
//{
//    beginResetModel();
//    loadTableFromDatabase();
//    endResetModel();
//}

#include "src/include/unit/unit.h"

Unit::Unit(QObject *parent)
    : QAbstractListModel(parent),
    qry(new QSqlQuery)
{
    loadDataFromDatabase();
}
void Unit::loadDataFromDatabase()
{
    m_data.clear();
        qDebug() << "Refreshing Unit list...";
    qry->prepare("SELECT Id, DisplayName FROM Unit");
    qDebug() << "SELECT Id, DisplayName FROM Unit";
    if (qry->exec()) {
        while (qry->next()) {
            UnitStruct unitstruct;
            unitstruct.id = qry->value("Id").toString();
            unitstruct.unitName = qry->value("DisplayName").toString();
            m_data.append(unitstruct);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}
int Unit::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant Unit::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    //    const Contact &contact = m_data.at(index.row());

    switch (role) {
    case Id: return m_data.at(index.row()).id;
    case UnitName: return m_data.at(index.row()).unitName;
    default: return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> Unit::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Id] = "idUnit";
    roles[UnitName] = "unitName";
    return roles;
}

QVariantMap Unit::get(int row) const
{
    const UnitStruct unitStruct = m_data.value(row);
    qDebug() << m_data.value(row).id;
    return { {"id", unitStruct.id}, {"displayName", unitStruct.unitName} };
}
bool Unit::append(const QString &unitName)
{
    qDebug() << "[Unit] append ...";
    for(auto i = 0;i<m_data.size();++i){
        if(unitName == m_data[i].unitName){
            return true;
        }
    }
    qDebug() << "unitName:" << unitName;
    if(unitName != ""){
        qry->prepare("INSERT INTO Unit(DisplayName) VALUES(:DisplayName)");
        qry->bindValue(":DisplayName", unitName);
        bool success = qry->exec();
        if(success){
            int row = 0;
            while (row < m_data.count() && unitName > m_data.at(row).unitName)
                ++row;

            QString id;
            QString s = "select Id from Unit where DisplayName = '%1'";
            QString in = s.arg(unitName);
            bool succes = qry->exec(in);
            qDebug() << "[Unit] append ... " << succes;
            if(succes){
                while(qry->next()){
                    id = qry->value("Id").toString();
                }
            }

            beginInsertRows(QModelIndex(), row, row);
            m_data.insert(row, {id,unitName});
            endInsertRows();
            return true;
        }else return false;
    }
}

void Unit::remove(int row, const QString &idUnit)
{
    qDebug() << "[supliercontact] remove ...";
    qry->prepare("DELETE FROM Unit WHERE Id = :id");
    qry->bindValue(":id",idUnit);
    bool success = qry->exec();
    qDebug() << "remove" << success;
    if (row < 0 || row >= m_data.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_data.removeAt(row);
    endRemoveRows();
    loadDataFromDatabase();
}
void Unit::updateData(int row, const QString &unitName)
{
    qDebug() << "[Unit] updateData ...";
    const UnitStruct unitStruct = m_data.value(row);
    QString s = "update Unit set DisplayName = '%1'  where Id = '%2'";
    QString in = s.arg(unitName,unitStruct.id);
    bool success = qry->exec(in);
    beginResetModel();
    m_data.replace(row,{unitStruct.id,unitName});
    endResetModel();
    loadDataFromDatabase();
    qDebug() << "update: " << in << success;
}
QStringList Unit::getUnitOnObject(const QString &idObject)
{
    qDebug() << "UNIT GetUnitName.....";
    QString selectID = "SELECT IdUnit FROM Object WHERE Id = '%1'";
    QString inUnit = selectID.arg(idObject);
    int idUnit = 0;
    if(qry->exec(inUnit)){
        while(qry->next()){
            idUnit = qry->value(0).toInt();
        }
    }

    QStringList unitName ;

    qry->prepare("SELECT DisplayName FROM Unit WHERE Id = :idUnit");
    qry->bindValue(":idUnit",idUnit);

    if(qry->exec()){
        while(qry->next()){
            unitName.append(qry->value("DisplayName").toString());
            qDebug() << "true";
        }
    }
    loadDataFromDatabase();
    return unitName;
}

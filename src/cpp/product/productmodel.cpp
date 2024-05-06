#include "src/include/product/productmodel.h"

ProductModel::ProductModel(QObject *parent)
    : QAbstractTableModel(parent),
    qry(new QSqlQuery)
{
    loadTableFromDatabase();
}

//ProductModel::~ProductModel()
//{

//}

void ProductModel::loadTableFromDatabase()
{
    qDebug() << "[Product Model] Constructing...";
    m_data.clear();
    QString s = "SELECT Object.Id, Object.DisplayName,Unit.DisplayName,Suplier.DisplayName,Object.QRCode,Object.BarCode FROM ((Object INNER JOIN Unit ON Object.IdUnit = Unit.Id INNER JOIN Suplier ON Object.IdSuplier = Suplier.Id))";
    bool success = qry->exec(s);
    qDebug() << s << success;
    if (qry->exec(s)) {
        while (qry->next()) {
            QList<QVariant> row;
            row.append(qry->value("Id"));
            row.append(qry->value("DisplayName"));
            row.append(qry->value("Unit.DisplayName"));
            row.append(qry->value("Suplier.DisplayName"));
            row.append(qry->value("QRCode"));
            row.append(qry->value("BarCode"));
            m_data.append(row);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}
int ProductModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_data.size();
}

int ProductModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    if (!m_data.isEmpty())
        return m_data.first().size();

    return 0;
}

QVariant ProductModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Qt::DisplayRole)
        return QVariant();

    int row = index.row();
    int column = index.column();

    if (row < 0 || row >= m_data.size() || column < 0 || column >= m_data.first().size())
        return QVariant();

    return m_data[row][column];
}
bool ProductModel::append(const QString &productName, const QString &unitName, const QString &supplierName,const QString &qrCode, const QString &barCode, const QString &note, const QString &imageFile)
{
    QString selectSupplier = "SELECT Id FROM Suplier WHERE DisplayName = '%1'";
    QString inSupplier = selectSupplier.arg(supplierName);
    int idSupplier ;
    if(qry->exec(inSupplier)){
        while(qry->next()){
            idSupplier = qry->value(0).toInt();;
        }
    }
    QString selectUnit = "SELECT Id FROM Unit WHERE DisplayName = '%1'";
    QString inUnit = selectUnit.arg(unitName);
    int idUnit ;
    if(qry->exec(inUnit)){
        while(qry->next()){
            idUnit = qry->value(0).toInt();;
        }
    }
    qDebug() << "[Product] append ..."  << idUnit << " " << idSupplier;

    qry->prepare("INSERT INTO Object(Id,DisplayName,IdUnit,IdSuplier,QRCode,BarCode, Note,Image) VALUES('24' || to_char(nextval('object_id_seq'), 'FM0000'), :productName,:idUnit,:idSupplier,:qrCode,:barCode, :note, :image) ");
    qry->bindValue(":productName",productName);
    qry->bindValue(":idUnit",idUnit);
    qry->bindValue(":idSupplier",idSupplier);
    qry->bindValue(":qrCode",qrCode);
    qry->bindValue(":barCode",barCode);
    qry->bindValue(":note",note);
    qry->bindValue(":image",imageFile);
    bool success = qry->exec();
    qDebug() << success;

    if(success){
        int row = 0;
        beginInsertRows(QModelIndex(), row, row);
        endInsertRows();
        loadTableFromDatabase();
        return true;
    }else return false;
}
QVariant ProductModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role != Qt::DisplayRole || orientation != Qt::Horizontal)
        return QVariant();

    if (section < 0 || section >= m_data.first().size())
        return QVariant();

    // Return the header for the corresponding column
    return QString("Column %1").arg(section);
}
//void ProductModel::remove(int row, const QString &displayName)
//{
//    qDebug() << "[ProductModel] remove ...";
//    qry->prepare("DELETE FROM Suplier WHERE DisplayName = :displayName");
//    qry->bindValue(":displayName",displayName);
//    bool success = qry->exec();
//    qDebug() << "remove" << success;
//    if (row < 0 || row >= m_contacts.count())
//        return;

//    beginRemoveRows(QModelIndex(), row, row);
//    m_data.removeAt(row);
//    endRemoveRows();
//}
bool ProductModel::updateData(int row, const QString &id, const QString &productName, const QString &unitName, const QString &supplierName, const QString &qrCode,const QString &barCode, const QString &note, const QString &imageFile)
{
    QString selectSupplier = "SELECT Id FROM Suplier WHERE DisplayName = '%1'";
    QString inSupplier = selectSupplier.arg(supplierName);
    int idSupplier ;
    if(qry->exec(inSupplier)){
        while(qry->next()){
            idSupplier = qry->value(0).toInt();;
        }
    }
    QString selectUnit = "SELECT Id FROM Unit WHERE DisplayName = '%1'";
    QString inUnit = selectUnit.arg(unitName);
    int idUnit ;
    if(qry->exec(inUnit)){
        while(qry->next()){
            idUnit = qry->value(0).toInt();;
        }
    }

    qDebug() << "[ProductModel] updateData ...";

    qry->prepare("update Object set DisplayName = :productName, IdUnit = :idUnit, IdSuplier = :idSupplier, QRCode = :qrCode, BarCode = :barCode, Note = :note, Image = :image where Id = :id");
    qry->bindValue(":id",id);
    qry->bindValue(":productName",productName);
    qry->bindValue(":idUnit",idUnit);
    qry->bindValue(":idSupplier",idSupplier);
    qry->bindValue(":qrCode",qrCode);
    qry->bindValue(":barCode",barCode);
    qry->bindValue(":note",note);
    qry->bindValue(":image",imageFile);
    bool success = qry->exec();
    qDebug() << success;
    if(success){
        beginResetModel();

        QList<QVariant>& innerList = m_data[row];
        for (int i = 0; i < innerList.size(); ++i) {
            QVariant& variant = innerList[i];
            if (variant.canConvert<QString>()) {
                switch (i) {
                case 0:variant.setValue(id);break;
                case 1:variant.setValue(productName);break;
                case 2:variant.setValue(idUnit);break;
                case 3:variant.setValue(idSupplier);break;
                case 4:variant.setValue(qrCode);break;
                case 5:variant.setValue(barCode);break;
                case 6:variant.setValue(note);break;
                case 7:variant.setValue(imageFile);break;
                default:break;
                }
            }
        }
        endResetModel();
        qDebug() << "update: " << success;
        return true;
    }else return false;
}
void ProductModel::remove(int row, const QString &id)
{
    qDebug() << "[ProductModel] remove ...";
    qry->prepare("DELETE FROM Object WHERE Id = :id");
    qry->bindValue(":id",id);
    bool success = qry->exec();
    qDebug() << "remove" << success;
    if (row < 0 || row >= m_data.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_data.removeAt(row);
    endRemoveRows();
}
void ProductModel::getName(const QString displayName)
{
    beginResetModel();

    qDebug() << "[Product Model] getName...";
    m_data.clear();
    QString s = "SELECT Object.Id, Object.DisplayName,Unit.DisplayName,Suplier.DisplayName,Object.QRCode,Object.BarCode FROM ((Object INNER JOIN Unit ON Object.IdUnit = Unit.Id INNER JOIN Suplier ON Object.IdSuplier = Suplier.Id)) WHERE Suplier.DisplayName = '%1'";
    QString qrySelect = s.arg(displayName);
    bool success = qry->exec(qrySelect);
    qDebug() << s << success;
    if (qry->exec(qrySelect)) {
        while (qry->next()) {
            QList<QVariant> row;
            row.append(qry->value("Id"));
            row.append(qry->value("DisplayName"));
            row.append(qry->value("Unit.DisplayName"));
            row.append(qry->value("Suplier.DisplayName"));
            row.append(qry->value("QRCode"));
            row.append(qry->value("BarCode"));
            m_data.append(row);
        }
        endResetModel();
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}
void ProductModel::refresh()
{
    beginResetModel();
    loadTableFromDatabase();
    endResetModel();
}

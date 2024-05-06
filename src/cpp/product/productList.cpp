#include "src/include/product/productList.h"

ProductList::ProductList(QObject *parent)
    : QAbstractListModel(parent),
    qry(new QSqlQuery)
{
    qDebug() << "[ProductList] Constructing...";
    loadTableFromDatabase();
}
void ProductList::loadTableFromDatabase()
{
    qDebug() << "Refreshing Product list...";
    m_products.clear();
    QString s = "SELECT Object.Id, Object.DisplayName,Unit.DisplayName,Suplier.DisplayName,Object.QRCode,Object.BarCode,Object.Note,Object.Image FROM ((Object INNER JOIN Unit ON Object.IdUnit = Unit.Id INNER JOIN Suplier ON Object.IdSuplier = Suplier.Id))";
    bool success = qry->exec(s);
    qDebug() << s << success;
    if (qry->exec(s)) {
        while (qry->next()) {
            Product product;
            product.id = qry->value("Id").toString();
            product.displayName = qry->value("DisplayName").toString();
            product.idUnit = qry->value("Unit.DisplayName").toString();
            product.idSuplier = qry->value("Suplier.DisplayName").toString();
            product.qrCode = qry->value("QRCode").toString();
            product.barCode = qry->value("BarCode").toString();
            product.note = qry->value("Note").toString();
            product.imageFile = qry->value("Image").toString();
            m_products.append(product);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}

int ProductList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_products.count();
}

QVariant ProductList::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_products.count())
        return QVariant();

    switch (role) {
    case Id: return m_products.at(index.row()).id;
    case DisplayName: return m_products.at(index.row()).displayName;
    case IdUnit: return m_products.at(index.row()).idUnit;
    case IdSuplier: return m_products.at(index.row()).idSuplier;
    case QRCode: return m_products.at(index.row()).qrCode;
    case BarCode: return m_products.at(index.row()).barCode;
    case Note: return m_products.at(index.row()).note;
    case ImageFile: return m_products.at(index.row()).imageFile;
    default: return QVariant();
    }

    return QVariant();
}

QHash<int, QByteArray> ProductList::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Id] = "idSuplier";
    roles[DisplayName] = "displayName";
    roles[IdUnit] = "idUnit";
    roles[IdSuplier] = "idSuplier";
    roles[QRCode] = "qrCode";
    roles[BarCode] = "barCode";
    roles[Note] = "note";
    roles[ImageFile] = "imageFile";
    return roles;
}

QVariantMap ProductList::get(int row) const
{
    const Product product = m_products.value(row);
    qDebug() << m_products.value(row).id;
    return { {"id", product.id}, {"displayName", product.displayName}, {"idUnit", product.idUnit}, {"idSuplier", product.idSuplier}, {"qrCode", product.qrCode}, {"barCode", product.barCode}, {"note", product.note}, {"imageFile", product.imageFile} };
}

bool ProductList::append(const QString &productName, const QString &unitName, const QString &supplierName,const QString &qrCode, const QString &barCode, const QString &note, const QString &image)
{
    qDebug() << "[ProductList] append ...";

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
    qry->bindValue(":image",image);
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

void ProductList::remove(int row, const QString &id)
{
    qDebug() << "[ProductList] remove ...";
    qry->prepare("DELETE FROM Object WHERE Id = :id");
    qry->bindValue(":id",id);
    bool success = qry->exec();
    qDebug() << "remove" << success;
    if (row < 0 || row >= m_products.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_products.removeAt(row);
    endRemoveRows();
}
bool ProductList::updateData(int row, const QString &id, const QString &productName, const QString &unitName, const QString &supplierName, const QString &qrCode,const QString &barCode, const QString &note, const QString &image)
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

    qDebug() << "[ProductList] updateData ..." << idUnit << " " << idSupplier;

    qry->prepare("update Object set DisplayName = :productName, IdUnit = :idUnit, IdSuplier = :idSupplier, QRCode = :qrCode, BarCode = :barCode, Note = :note, Image = :image where Id = :id");
    qry->bindValue(":id",id);
    qry->bindValue(":productName",productName);
    qry->bindValue(":idUnit",idUnit);
    qry->bindValue(":idSupplier",idSupplier);
    qry->bindValue(":qrCode",qrCode);
    qry->bindValue(":barCode",barCode);
    qry->bindValue(":note",note);
    qry->bindValue(":image",image);
    bool success = qry->exec();
    qDebug() << success;
    if(success){
        beginResetModel();
        loadTableFromDatabase();
        endResetModel();
        qDebug() << "update: " << success;
        return true;
    }else return false;
}
void ProductList::refresh()
{
    beginResetModel();
    loadTableFromDatabase();
    endResetModel();
}
QString ProductList::getIdOnName(const QString &displayName)
{
    QString selectProduct = "SELECT Id FROM Object WHERE DisplayName = '%1'";
    QString inProduct = selectProduct.arg(displayName);
    QString idProduct ;
    if(qry->exec(inProduct)){
        while(qry->next()){
            idProduct = qry->value(0).toString();
            return idProduct;
        }
    }
}
QStringList ProductList::getNameOnSupplier(const QString &idSuplier)
{
    QStringList nameProduct ;

    if(idSuplier != ""){
        QString selectProduct = "SELECT DisplayName FROM Object WHERE IdSuplier = '%1'";
        QString inProduct = selectProduct.arg(idSuplier);
        if(qry->exec(inProduct)){
            while(qry->next()){
                nameProduct.append(qry->value("DisplayName").toString());
            }
        }
    }
    return nameProduct;
}



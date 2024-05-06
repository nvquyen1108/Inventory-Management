#include "src/include/input/inputList.h"

InputList::InputList(QObject *parent)
    : QAbstractListModel(parent),
    qry(new QSqlQuery)
{
    qDebug() << "[InputList] Constructing...";
    loadTableFromDatabase();
}
void InputList::loadTableFromDatabase()
{
    qDebug() << "Refreshing INPUTLIST list...";
    m_input.clear();
    QString s = "SELECT Object.Id, Object.DisplayName,Unit.DisplayName,Suplier.DisplayName,InputInfo.Count,InputInfo.InputPrice,Object.Image "
                "FROM Object INNER JOIN Unit ON Object.IdUnit = Unit.Id "
                "INNER JOIN Suplier ON Object.IdSuplier = Suplier.Id "
                "INNER JOIN InputInfo ON Object.Id = InputInfo.IdObject";
    bool success = qry->exec(s);
    qDebug() << s << success;
    if (qry->exec(s)) {
        while (qry->next()) {
            InputProduct product;
            product.id = qry->value("Id").toString();
            product.displayName = qry->value("DisplayName").toString();
            product.idUnit = qry->value("Unit.DisplayName").toString();
            product.idSuplier = qry->value("Suplier.DisplayName").toString();
            product.inputCount = qry->value("InputInfo.Count").toString();
            product.inputPrice = qry->value("InputInfo.InputPrice").toString();
            product.imageFile = qry->value("Image").toString();
            m_input.append(product);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}

int InputList::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_input.count();
}

QVariant InputList::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_input.count())
        return QVariant();

    switch (role) {
    case Id: return m_input.at(index.row()).id;
    case DisplayName: return m_input.at(index.row()).displayName;
    case IdUnit: return m_input.at(index.row()).idUnit;
    case IdSuplier: return m_input.at(index.row()).idSuplier;
    case InputCount: return m_input.at(index.row()).inputCount;
    case InputPrice: return m_input.at(index.row()).inputPrice;
    case ImageFile: return m_input.at(index.row()).imageFile;
    default: return QVariant();
    }

    return QVariant();
}

QHash<int, QByteArray> InputList::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Id] = "idSuplier";
    roles[DisplayName] = "displayName";
    roles[IdUnit] = "idUnit";
    roles[IdSuplier] = "idSuplier";
    roles[InputCount] = "inputCount";
    roles[InputPrice] = "inputPrice";
    roles[ImageFile] = "imageFile";
    return roles;
}

QVariantMap InputList::get(int row) const
{
    const InputProduct product = m_input.value(row);
    qDebug() << m_input.value(row).id;
    return { {"id", product.id}, {"displayName", product.displayName}, {"idUnit", product.idUnit}, {"idSuplier", product.idSuplier}, {"qrCode", product.inputCount}, {"barCode", product.inputPrice}, {"imageFile", product.imageFile} };
}

bool InputList::append(const QString &idObject, const QString &numberCount, const QString &numberPrice, const QString &note, const QString &image)
{
    qDebug() << "[InputList] append ...";
    QString insertInput = "INSERT INTO Input(Id,IdObject,Count,Price,DateInput) VALUES ('10' || to_char(nextval('input_id_seq'), 'FM0000'),'%1','%2','%3', CURRENT_TIMESTAMP) RETURNING Id";
    QString qryInput = insertInput.arg(idObject,QString::number(numberCount.toFloat()),QString::number(numberPrice.toFloat()));
    bool isCheckQry = qry->exec(qryInput);
    if(isCheckQry){
        qDebug() << "qry1" << isCheckQry;
        QString idInput;
        while(qry->next()){
            qDebug() << "qry3" << idInput;

            idInput = qry->value("Id").toString();
            qDebug() << "qry4" << idInput;
            qry->prepare("INSERT INTO InputInfo(IdObject,IdInput,Count,InputPrice,Note,Image) VALUES (:idObject, :idInput, :count, :price, :note, :image) ON CONFLICT(IdObject) DO UPDATE SET Count = InputInfo.Count + :addcount, InputPrice = :inputprice");
            qry->bindValue(":idObject",idObject);
            qry->bindValue(":idInput",idInput);
            qry->bindValue(":count",numberCount.toFloat());
            qry->bindValue(":price",numberPrice.toFloat());
            qry->bindValue(":note",note);
            qry->bindValue(":image",image);
            qry->bindValue(":addcount",numberCount.toFloat());
            qry->bindValue(":inputprice",numberPrice.toFloat());
            if(qry->exec()){
                qDebug() << true;
                return true;
            }else return false;
        }
    }
}

void InputList::remove(int row, const QString &id)
{
    qDebug() << "[Product] remove ...";
    qry->prepare("DELETE FROM Object WHERE Id = :id");
    qry->bindValue(":id",id);
    bool success = qry->exec();
    qDebug() << "remove" << success;
    if (row < 0 || row >= m_input.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_input.removeAt(row);
    endRemoveRows();
}
bool InputList::updateData(const QString &id, const QString &productName, const QString &unitName, const QString &supplierName, const QString &qrCode,const QString &barCode, const QString &note, const QString &image)
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

    qDebug() << "[InputList] updateData ..." << idUnit << " " << idSupplier;

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
void InputList::set()
{
    beginResetModel();
    loadTableFromDatabase();
    endResetModel();
}
QString InputList::getIdOnName(const QString &displayName)
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
double InputList::getSumOnPrice(const QString &numberCount, const QString &numberPrice)
{
    static double sum = 0;
    qDebug() << numberCount << numberPrice;
    sum = numberCount.toDouble() * numberPrice.toDouble();
    qDebug() << sum;

    return sum;
}

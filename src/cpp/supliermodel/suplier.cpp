#include "src/include/supliermodel/suplier.h"

Suplier::Suplier(QObject *parent)
    : QAbstractTableModel(parent),
    qry(new QSqlQuery),
    model(new QSqlQueryModel)
{
    loadTableFromDatabase();
}

void Suplier::loadTableFromDatabase(){
    m_data.clear();
    qry->prepare("SELECT Id, DisplayName, Address, Phone, Email, MoreInfo, ContractDate FROM Suplier");
    if (qry->exec()) {
        while (qry->next()) {
            QList<QVariant> row;
            row.append(qry->value("Id"));
            row.append(qry->value("DisplayName"));
            row.append(qry->value("Address"));
            row.append(qry->value("Email"));
            row.append(qry->value("Phone"));
            row.append(qry->value("MoreInfo"));
            row.append(qry->value("ContractDate"));
            m_data.append(row);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
//    qDebug() << "Query num: " << m_data.at(0);

//    emit dataChanged(index(0), index(rowCount() - 1));
}
int Suplier::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_data.size();
}

int Suplier::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    if (!m_data.isEmpty())
        return m_data.first().size();

    return 0;
}

QVariant Suplier::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Qt::DisplayRole)
        return QVariant();

    int row = index.row();
    int column = index.column();

    if (row < 0 || row >= m_data.size() || column < 0 || column >= m_data.first().size())
        return QVariant();

    return m_data[row][column];
}
bool Suplier::append(const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo, const QString &logoFile)
{

//    QString s = "INSERT INTO Suplier VALUES(:1, :2, :3, :4, :5, :6, CURRENT_TIMESTAMP) ";

    qry->prepare("INSERT INTO Suplier(DisplayName, Address, Email, Phone, MoreInfo, LogoFile, ContractDate) VALUES(:DisplayName, :Address, :Email, :Phone, :MoreInfo, :LogoFile, CURRENT_TIMESTAMP)");
    qry->bindValue(":DisplayName", displayName);
    qry->bindValue(":Address", address);
    qry->bindValue(":Email", email);
    qry->bindValue(":Phone", phone);
    qry->bindValue(":MoreInfo", moreinfo);
    qry->bindValue(":LogoFile", logoFile);
    bool success = qry->exec();

    if(success){
        qDebug() << "query insert: " << success;
        int row = 0;

        QString id;
        QString contract;
        QString s = "select Id,ContractDate from Suplier where displayName = '%1'";
        QString in = s.arg(displayName);
        bool succes = qry->exec(in);
        qDebug() << succes;
        if(succes){
            while(qry->next()){
                id = qry->value("Id").toString();
                contract = qry->value("ContractDate").toString();
                qDebug() << id << contract;
            }
        }

        QList<QVariant> row1;
        row1.append(id);
        row1.append(displayName);
        row1.append(address);
        row1.append(email);
        row1.append(phone);
        row1.append(moreinfo);
        row1.append(contract);
        qDebug() << row1;
        beginInsertRows(QModelIndex(), row, row);
        m_data.append(row1);
        endInsertRows();
        return true;
    }else return false;
}
bool Suplier::insertRows(int row, int count, const QModelIndex &parent,const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo)
{
    Q_UNUSED(parent);
    QList<QVariant> rowData;
    rowData.append(displayName);
    rowData.append(address);
    rowData.append(email);
    rowData.append(phone);
    rowData.append(moreinfo);
    qDebug() << rowData;
//    row << displayName << address << email << phone << moreinfo;
    beginInsertRows(QModelIndex(), row, row + count - 1);
    m_data.append(rowData);
    endInsertRows();
//    emit dataChanged(index(row, 0), index(row + count - 1, columnCount() - 1));
    return true;
}
bool Suplier::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!index.isValid() || role != Qt::EditRole)
        return false;

    int row = index.row();
    int column = index.column();
    qDebug() << "row:" << row << " " << "column:" << column << " " << "role:" << role << " " << "value:" << value;

    if (row < 0 || row >= m_data.count() || column < 0 || column >= m_data.at(row).count())
        return false;
    qDebug() << "row2:" << row << " " << "column:" << column << " " << "role:" << role << " " << "value:" << value;

    // Update the data in the model
    m_data[row][column] = value;
    emit dataChanged(index, index, {role});
    qDebug() << "row3:" << row << " " << "column:" << column << " " << "role:" << role << " " << "value:" << value;

    // Update the data in the database
    // Assuming you have a method updateData() in your database manager to update the data in the database
    QVariantList rowData;
    for (const QVariant& data : m_data[row])
    {
        rowData.append(data);
    }
    qDebug() << "row4:" << row << " " << "column:" << column << " " << "role:" << role << " " << "value:" << value;

    loadTableFromDatabase();
    qDebug() << "row5:" << row << " " << "column:" << column << " " << "role:" << role << " " << "value:" << value;

    return true;
}
//QVariant headerData(int section, Qt::Orientation orientation, int role) const override {
//    if (orientation == Qt::Horizontal && role == Qt::DisplayRole) {
//        static QStringList headers = { "mamuahang", "ngaynhap", "nhacungcap", "nguoidathang", "tongdongia", "tinhtranghoadon", "thoigiantrahang" };

//        if (section >= 0 && section < headers.size())
//            return headers[section];
//    }

//    return QVariant();
//}
QVariant Suplier::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role != Qt::DisplayRole || orientation != Qt::Horizontal)
        return QVariant();

    if (section < 0 || section >= m_data.first().size())
        return QVariant();

    // Return the header for the corresponding column
    return QString("Column %1").arg(section);
}

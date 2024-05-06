#include "src/include/supliermodel/supliercontact.h"

SuplierContact::SuplierContact(QObject *parent)
    : QAbstractListModel(parent),
    qry(new QSqlQuery),
    model(new QSqlQueryModel)
{
    qDebug() << "[suplier contact] Constructing...";
    loadTableFromDatabase();
}
void SuplierContact::loadTableFromDatabase()
{
    qDebug() << "Refreshing Suplier list...";
    m_contacts.clear();
    qry->prepare("SELECT Id, DisplayName, Address, Phone, Email, MoreInfo, LogoFile, ContractDate FROM Suplier");
    qDebug() << "SELECT Id, DisplayName, Address, Phone, Email, MoreInfo, LogoFile, ContractDate FROM Suplier";
    if (qry->exec()) {
        while (qry->next()) {
            Contact contact;
            contact.id = qry->value("Id").toString();
            contact.displayName = qry->value("DisplayName").toString();
            contact.address = qry->value("Address").toString();
            contact.phone = qry->value("Phone").toString();
            contact.email = qry->value("Email").toString();
            contact.moreinfo = qry->value("MoreInfo").toString();
            contact.logoFile = qry->value("LogoFile").toString();
            contact.contractdate = qry->value("ContractDate").toString();
            m_contacts.append(contact);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }

    //    emit dataChanged(index(0), index(rowCount() - 1));
}

int SuplierContact::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_contacts.count();
}

QVariant SuplierContact::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_contacts.count())
        return QVariant();

//    const Contact &contact = m_contacts.at(index.row());

    switch (role) {
    case Id: return m_contacts.at(index.row()).id;
    case DisplayName: return m_contacts.at(index.row()).displayName;
    case Address: return m_contacts.at(index.row()).address;
    case Phone: return m_contacts.at(index.row()).phone;
    case Email: return m_contacts.at(index.row()).email;
    case MoreInfo: return m_contacts.at(index.row()).moreinfo;
    case LogoFile: return m_contacts.at(index.row()).logoFile;
    case ContractDate: return m_contacts.at(index.row()).contractdate;
    default: return QVariant();
    }

    return QVariant();
}

QHash<int, QByteArray> SuplierContact::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Id] = "idSuplier";
    roles[DisplayName] = "displayName";
    roles[Address] = "address";
    roles[Phone] = "phone";
    roles[Email] = "email";
    roles[MoreInfo] = "moreinfo";
    roles[LogoFile] = "logoFile";
    roles[ContractDate] = "contractDate";
    return roles;
}

QVariantMap SuplierContact::get(int row) const
{
    qDebug() << "[suplier contact] get...";
    const Contact contact = m_contacts.value(row);
    return { {"id", contact.id}, {"displayName", contact.displayName}, {"address", contact.address}, {"email", contact.email}, {"phone", contact.phone}, {"moreinfo", contact.moreinfo}, {"logoFile", contact.logoFile}, {"contractdate", contact.contractdate} };
}

bool SuplierContact::append(const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo,const QUrl &logoFile)
{
    qDebug() << "[supliercontact] append ...";

    qry->prepare("INSERT INTO Suplier(DisplayName, Address, Email, Phone, MoreInfo, LogoFile, ContractDate) VALUES(:DisplayName, :Address, :Email, :Phone, :MoreInfo, :LogoFile, CURRENT_TIMESTAMP)");
    qDebug() << "INSERT INTO Suplier(DisplayName, Address, Email, Phone, MoreInfo, LogoFile, ContractDate) VALUES(:DisplayName, :Address, :Email, :Phone, :MoreInfo, :LogoFile, CURRENT_TIMESTAMP)";
    qry->bindValue(":DisplayName", displayName);
    qry->bindValue(":Address", address);
    qry->bindValue(":Email", email);
    qry->bindValue(":Phone", phone);
    qry->bindValue(":MoreInfo", moreinfo);
    qry->bindValue(":LogoFile", logoFile.toString());
    bool success = qry->exec();
    qDebug() << "query insert: " << success;

    if(success){
        qDebug() << "query insert: " << success;
        int row = 0;
        while (row < m_contacts.count() && displayName > m_contacts.at(row).displayName)
            ++row;

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

        beginInsertRows(QModelIndex(), row, row);
        m_contacts.insert(row, {id,displayName, address, email, phone, moreinfo,logoFile.toString(),contract});

        endInsertRows();
        return true;
    }else return false;
}

void SuplierContact::remove(int row, const QString &email)
{
    qDebug() << "[supliercontact] remove ...";
    qry->prepare("DELETE FROM Suplier WHERE Email = :email");
    qry->bindValue(":email",email);
    bool success = qry->exec();
    qDebug() << "remove" << success;
    if (row < 0 || row >= m_contacts.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_contacts.removeAt(row);
    endRemoveRows();
}
void SuplierContact::updateData(int row, const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo,const QUrl &logoFile)
{
    qDebug() << "[supliercontact] updateData ...";
    const Contact contact = m_contacts.value(row);
    QString s = "update Suplier set DisplayName = '%1', Address = '%2', Email = '%3', Phone = '%4', MoreInfo = '%5', LogoFile = '%6', ContractDate = CURRENT_TIMESTAMP  where Id = '%7'";
    QString in = s.arg(displayName,address,email,phone,moreinfo,logoFile.toString(),contact.id);
    bool success = qry->exec(in);
    beginResetModel();
    m_contacts.replace(row,{contact.id,displayName, address, email, phone, moreinfo,logoFile.toString(),contact.contractdate});
    endResetModel();
    qDebug() << "update: " << in << success;
}
QString SuplierContact::getIdOnName(const QString &displayName)
{
    QString selectSupplier = "SELECT Id FROM Suplier WHERE DisplayName = '%1'";
    QString inSupplier = selectSupplier.arg(displayName);
    QString idSupplier ;
    if(qry->exec(inSupplier)){
        while(qry->next()){
            idSupplier = qry->value(0).toString();
            return idSupplier;
        }
    }
}
void SuplierContact::refresh()
{
    beginResetModel();
    loadTableFromDatabase();
    endResetModel();
}

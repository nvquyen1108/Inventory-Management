#ifndef SUPLIERCONTACT_H
#define SUPLIERCONTACT_H

#include <QAbstractListModel>
#include <QHash>
#include <QList>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlError>
#include <QImage>
#include <QUrl>



class SuplierContact : public QAbstractListModel {
    Q_OBJECT

public:
    enum ContactRole {
        Id = Qt::UserRole + 1,
        DisplayName,
        Address,
        Email,
        Phone,
        MoreInfo,
        LogoFile,
        ContractDate
    };
    Q_ENUM(ContactRole)
    struct Contact {
        QString id;
        QString displayName;
        QString address;
        QString email;
        QString phone;
        QString moreinfo;
        QString logoFile;
        QString contractdate;
    };


    explicit SuplierContact(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

//    int rowCount(const QModelIndex & = QModelIndex()) const;
//    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
//    QHash<int, QByteArray> roleNames() const;

    void loadTableFromDatabase();

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE bool append(const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo,const QUrl &logoFile);
    Q_INVOKABLE void updateData(int row,const QString &displayName, const QString &address, const QString &email, const QString &phone, const QString &moreinfo,const QUrl &logoFile);
    Q_INVOKABLE void remove(int row, const QString &displayName);
    Q_INVOKABLE QString getIdOnName(const QString &displayName);
    Q_INVOKABLE void refresh();

private:

    QSqlQuery *qry;
    QSqlQueryModel *model;

    QList<Contact> m_contacts;
};

#endif // SUPLIERCONTACT_H

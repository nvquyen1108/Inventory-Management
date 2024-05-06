#ifndef INPUTLIST_H
#define INPUTLIST_H

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



class InputList : public QAbstractListModel {
    Q_OBJECT

public:
    enum InputRole {
        Id = Qt::UserRole + 1,
        DisplayName,
        IdUnit,
        IdSuplier,
        InputCount,
        InputPrice,
        ImageFile
    };
    Q_ENUM(InputRole)
    struct InputProduct {
        QString id;
        QString displayName;
        QString idUnit;
        QString idSuplier;
        QString inputCount;
        QString inputPrice;
        QString imageFile;
    };

    explicit InputList(QObject *parent = nullptr);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void loadTableFromDatabase();

    Q_INVOKABLE QVariantMap get(int row) const;
    Q_INVOKABLE bool append(const QString &idObject, const QString &numberCount, const QString &numberPrice, const QString &note, const QString &image);
    Q_INVOKABLE bool updateData(const QString &id, const QString &productName, const QString &unitName, const QString &supplierName, const QString &qrCode,const QString &barCode, const QString &note, const QString &image);
    Q_INVOKABLE void remove(int row, const QString &displayName);
    Q_INVOKABLE void set();
    Q_INVOKABLE QString getIdOnName(const QString &displayName);
    Q_INVOKABLE double getSumOnPrice(const QString &numberCount, const QString &numberPrice);

private:

    QSqlQuery *qry;
    QList<InputProduct> m_input;
};

#endif //

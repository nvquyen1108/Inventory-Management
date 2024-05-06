#include "src/include/output/outputmodel.h"

OutputModel::OutputModel(QObject *parent)
    : QAbstractTableModel(parent),
    qry(new QSqlQuery)
{
    loadTableFromDatabase(currentDay,currentMonth,currentYear);
}
void OutputModel::currentDayFunc(int currentDay)
{
    this->currentDay = currentDay;
}
void OutputModel::currentMonthFunc(int currentMonth)
{
    this->currentMonth = currentMonth;
}
void OutputModel::currentYearFunc(int currentYear)
{
    this->currentYear = currentYear;
}

void OutputModel::loadTableFromDatabase(int currentDay, int currentMonth, int currentYear)
{
    qDebug() << currentDay << currentMonth << currentYear;

    qDebug() << "[OUTPUT Model] Constructing...";
    m_output.clear();
    QString s = "SELECT OutputInfo.IdObject,Object.DisplayName,Unit.DisplayName,OutputInfo.Count,EXTRACT(DAY FROM Output.DateOutput) AS day_number,EXTRACT(MONTH FROM Output.DateOutput) AS month_number,EXTRACT(YEAR FROM Output.DateOutput) AS year_number From OutputInfo "
                "INNER JOIN Object ON OutputInfo.IdObject = Object.Id "
                "INNER JOIN Unit ON Object.IdUnit = Unit.Id "
                "INNER JOIN Output ON OutputInfo.IdOutput = Output.Id "
                "WHERE EXTRACT(MONTH FROM Output.DateOutput) = '%1' AND EXTRACT(YEAR FROM Output.DateOutput) = '%2' AND EXTRACT(DAY FROM Output.DateOutput) = '%3' ";
    QString qryInventory = s.arg(QString::number(currentMonth),QString::number(currentYear), QString::number(currentDay));
    bool success = qry->exec(qryInventory);
    qDebug() << qryInventory << success;
    if (qry->exec(qryInventory)) {
        while (qry->next()) {
            QList<QVariant> row;
            row.append(qry->value("OutputInfo.IdObject"));
            row.append(qry->value("Object.DisplayName"));
            row.append(qry->value("Unit.DisplayName"));
            row.append(qry->value("OutputInfo.Count"));
            m_output.append(row);
        }
    } else {
        qDebug() << "Query failed:" << qry->lastError().text();
    }
}
int OutputModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_output.size();
}

int OutputModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    if (!m_output.isEmpty())
        return m_output.first().size();

    return 0;
}

QVariant OutputModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || role != Qt::DisplayRole)
        return QVariant();

    int row = index.row();
    int column = index.column();

    if (row < 0 || row >= m_output.size() || column < 0 || column >= m_output.first().size())
        return QVariant();

    return m_output[row][column];
}
bool OutputModel::append(const QString &idObject, const QString &numberCount)
{
    qDebug() << "[OutputModel] append ..." << currentDay << currentMonth << currentYear;

    QString insertOutput = "INSERT INTO Output(Id,IdObject,Count,DateOutput) VALUES ('10' || to_char(nextval('output_id_seq'), 'FM0000'),'%1', '%2', CURRENT_TIMESTAMP) RETURNING Id";
    QString qryInsertOutput = insertOutput.arg(idObject,QString::number(numberCount.toFloat()));
    QString idOutput;
    bool isCheckQry = qry->exec(qryInsertOutput);
    if(isCheckQry){
        while(qry->next()){
            idOutput = qry->value("Id").toString();
        }
    }
    QString selectOutputInfo = "SELECT IdOutput FROM OutputInfo "
                                "INNER JOIN Output ON OutputInfo.IdOutput = Output.Id "
                                "Where OutputInfo.IdObject = '%1' "
                                "AND EXTRACT(DAY FROM Output.DateOutput) = '%2' AND EXTRACT(MONTH FROM Output.DateOutput) = '%3'  AND EXTRACT(YEAR FROM Output.DateOutput) = '%4'";
    QString qrySelectOutputInfo = selectOutputInfo.arg(idObject,QString::number(this->currentDay),QString::number(this->currentMonth),QString::number(this->currentYear));
    QString setIdOutput;
    if(qry->exec(qrySelectOutputInfo)){
        while(qry->next()){
            setIdOutput = qry->value("IdOutput").toString();
        }
        if(setIdOutput != ""){
            QString updateOutputInfo = "UPDATE OutputInfo SET Count = OutputInfo.Count + '%1', IdOutput = '%2' WHERE OutputInfo.IdObject = '%3' AND OutputInfo.IdOutput = '%4'";
            QString qryUpdate = updateOutputInfo.arg(QString::number(numberCount.toFloat()),idOutput,idObject,setIdOutput);
            if(qry->exec(qryUpdate)){
                QString updateInputInfo = "UPDATE InputInfo SET Count = InputInfo.Count - '%1' WHERE IdObject = '%2'";
                QString qryUpdateInputInfo = updateInputInfo.arg(QString::number(numberCount.toFloat()),idObject);
                if(qry->exec(qryUpdateInputInfo)){
                    return true;
                }else return false;
            }
        }else{
            QString insertOutputInfo = "INSERT INTO OutputInfo(Id,IdObject,IdOutput,Count) VALUES('OU' || to_char(nextval('outputInfo_id_seq'), 'FM0000'), '%1', '%2', '%3')";
            QString qryInsertOutputInfo = insertOutputInfo.arg(idObject,idOutput,QString::number(numberCount.toFloat()));
            if(qry->exec(qryInsertOutputInfo)){
                QString updateInputInfo = "UPDATE InputInfo SET Count = InputInfo.Count - '%1' WHERE IdObject = '%2'";
                QString qryUpdateInputInfo = updateInputInfo.arg(QString::number(numberCount.toFloat()),idObject);
                if(qry->exec(qryUpdateInputInfo)){
                    return true;
                }else return false;
            }
        }
    }
    return false;
}

void OutputModel::refresh()
{
    beginResetModel();
    loadTableFromDatabase(currentDay,currentMonth,currentYear);
    endResetModel();
}

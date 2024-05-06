#ifndef DASHRECT_H
#define DASHRECT_H


#include <QObject>
#include <QQuickPaintedItem>
#include <QPainter>

class DashRect : public QQuickPaintedItem
{
    Q_OBJECT
public:
    explicit DashRect(QQuickItem *parent = nullptr);

    virtual void paint(QPainter *painter);
};
#endif // DASHRECT_H

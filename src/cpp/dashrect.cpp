#include "src/include/dashrect.h"

DashRect::DashRect(QQuickItem *parent) : QQuickPaintedItem(parent)
{

}

void DashRect::paint(QPainter *painter)
{
    painter->setPen(QPen(Qt::DashLine));
    painter->drawRoundedRect(0, 0, width() - 1, height() - 1, 4, 4);
}
